-- FrameFlow Studio V5: general design export and auditable MCP sessions.

alter table if exists public.frameflow_projects
  alter column metadata set default '{"schema":5,"appVersion":"5.0.0"}'::jsonb;

update public.frameflow_projects
set metadata = coalesce(metadata, '{}'::jsonb) || '{"schema":5,"appVersion":"5.0.0","primaryWorkflow":"design-export"}'::jsonb
where coalesce((metadata->>'schema')::integer, 0) < 5
   or metadata->>'appVersion' is distinct from '5.0.0';

create table if not exists public.frameflow_mcp_sessions (
  id uuid primary key default gen_random_uuid(),
  project_id uuid references public.frameflow_projects(id) on delete cascade,
  owner_id uuid not null references auth.users(id) on delete cascade,
  client_name text not null default 'MCP client',
  capabilities jsonb not null default '{}'::jsonb,
  permissions jsonb not null default '{"read":true,"write":false,"export":true,"comments":false,"versions":false}'::jsonb,
  selection jsonb not null default '[]'::jsonb,
  revision bigint not null default 0,
  status text not null default 'active' check (status in ('active','offline','revoked','closed')),
  last_seen_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.frameflow_mcp_transactions (
  id uuid primary key default gen_random_uuid(),
  session_id uuid references public.frameflow_mcp_sessions(id) on delete set null,
  project_id uuid references public.frameflow_projects(id) on delete cascade,
  owner_id uuid not null references auth.users(id) on delete cascade,
  base_revision bigint not null default 0,
  operations jsonb not null default '[]'::jsonb,
  diff jsonb not null default '{}'::jsonb,
  before_document jsonb,
  after_document jsonb,
  status text not null default 'preview' check (status in ('preview','approved','applied','rejected','failed','rolled_back')),
  error text,
  created_at timestamptz not null default now(),
  applied_at timestamptz
);

alter table public.frameflow_mcp_sessions enable row level security;
alter table public.frameflow_mcp_transactions enable row level security;
grant select, insert, update, delete on public.frameflow_mcp_sessions to authenticated;
grant select, insert, update, delete on public.frameflow_mcp_transactions to authenticated;

drop policy if exists "frameflow_mcp_sessions_own" on public.frameflow_mcp_sessions;
create policy "frameflow_mcp_sessions_own" on public.frameflow_mcp_sessions for all to authenticated
using ((select auth.uid()) = owner_id)
with check ((select auth.uid()) = owner_id and (project_id is null or exists (select 1 from public.frameflow_projects p where p.id = project_id and p.owner_id = (select auth.uid()))));

drop policy if exists "frameflow_mcp_transactions_own" on public.frameflow_mcp_transactions;
create policy "frameflow_mcp_transactions_own" on public.frameflow_mcp_transactions for all to authenticated
using ((select auth.uid()) = owner_id)
with check ((select auth.uid()) = owner_id and (project_id is null or exists (select 1 from public.frameflow_projects p where p.id = project_id and p.owner_id = (select auth.uid()))));

create index if not exists frameflow_mcp_sessions_project_seen_idx on public.frameflow_mcp_sessions(project_id,last_seen_at desc);
create index if not exists frameflow_mcp_transactions_project_created_idx on public.frameflow_mcp_transactions(project_id,created_at desc);
create index if not exists frameflow_mcp_transactions_session_created_idx on public.frameflow_mcp_transactions(session_id,created_at desc);

do $$ begin alter publication supabase_realtime add table public.frameflow_mcp_sessions; exception when duplicate_object then null; end $$;

alter table if exists public.frameflow_mcp_transactions
  add column if not exists before_document jsonb,
  add column if not exists after_document jsonb;