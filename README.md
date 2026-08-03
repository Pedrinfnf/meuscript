# FrameFlow Mobile

Editor visual mobile-first inspirado em ferramentas profissionais de design, com identidade própria.

## Recursos

- Login e cadastro com Supabase Auth
- Modo convidado offline via localStorage
- Projetos com autosave e Row Level Security
- Canvas com pan, zoom e gesto de pinça
- Retângulos, elipses, texto e imagens
- Layers, visibilidade, bloqueio e ordem
- Propriedades de posição, tamanho, rotação, cor e tipografia
- Undo/redo
- Exportação PNG e JSON editável
- PWA instalável no Android

## Backend

A tabela usada é `public.frameflow_projects`. A chave Supabase exposta no frontend é apenas a publishable key; a segurança dos dados depende das políticas RLS por `auth.uid()`.

## Deploy

Projeto estático pronto para Vercel. Não requer build.
