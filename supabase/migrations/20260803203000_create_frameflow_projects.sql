create extension if not exists pgcrypto;

create table if not exists public.frameflow_projects (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  name text not null default 'Projeto sem título' check (char_length(name) between 1 and 120),
  document jsonb not null default '{"version":1,"canvas":{"width":390,"height":844,"background":"#ffffff"},"layers":[]}'::jsonb,
  thumbnail text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists frameflow_projects_owner_updated_idx
  on public.frameflow_projects (owner_id, updated_at desc);

create or replace function public.frameflow_touch_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists frameflow_projects_touch_updated_at on public.frameflow_projects;
create trigger frameflow_projects_touch_updated_at
before update on public.frameflow_projects
for each row execute function public.frameflow_touch_updated_at();

alter table public.frameflow_projects enable row level security;

grant select, insert, update, delete on public.frameflow_projects to authenticated;
revoke all on public.frameflow_projects from anon;

drop policy if exists "frameflow_select_own" on public.frameflow_projects;
create policy "frameflow_select_own"
on public.frameflow_projects
for select
to authenticated
using ((select auth.uid()) = owner_id);

drop policy if exists "frameflow_insert_own" on public.frameflow_projects;
create policy "frameflow_insert_own"
on public.frameflow_projects
for insert
to authenticated
with check ((select auth.uid()) = owner_id);

drop policy if exists "frameflow_update_own" on public.frameflow_projects;
create policy "frameflow_update_own"
on public.frameflow_projects
for update
to authenticated
using ((select auth.uid()) = owner_id)
with check ((select auth.uid()) = owner_id);

drop policy if exists "frameflow_delete_own" on public.frameflow_projects;
create policy "frameflow_delete_own"
on public.frameflow_projects
for delete
to authenticated
using ((select auth.uid()) = owner_id);
