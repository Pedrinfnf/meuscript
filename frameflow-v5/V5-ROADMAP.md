# FrameFlow V5 — roadmap de paridade funcional

Uma área só avança quando possui fluxo utilizável, persistência coerente e testes. “100% idêntico ao Figma” não é usado como afirmação absoluta; a meta é comportamento verificável.

| Área | Estado estimado | Principal lacuna |
|---|---:|---|
| Canvas e transformações | 68% | renderer espacial, matrizes completas e arquivos gigantes |
| Exportação geral | 82% | PDF, batch UX e asset pipeline avançado |
| Vetores | 48% | vector networks e geometry kernel robusto |
| Tipografia | 52% | shaping profissional e edição de parágrafo madura |
| Auto Layout | 61% | todos os edge cases aninhados |
| Components e libraries | 55% | bibliotecas remotas e revisão de updates |
| Variables e styles | 58% | scopes completos e styles publicados |
| Prototyping | 47% | Smart Animate preciso e timeline visual |
| Multiplayer e histórico | 38% | CRDT/OT e permissões server-side |
| MCP do documento FrameFlow | 92% | streaming visual, screenshot context e ACL granular |
| Paridade com o Figma completo | ~45% | maturidade, escala e ecossistema |

## Gates concluídos nesta fase

- [x] Slice Tool
- [x] PNG/JPG/WebP/SVG/JSON
- [x] export settings por node
- [x] copy as PNG/SVG
- [x] leitura completa de contexto pelo MCP
- [x] busca e batch read
- [x] escrita transacional com dry-run/diff
- [x] sessões MCP duráveis com permissões
- [x] preview persistente, aprovação/rejeição, aplicação e rollback
- [x] projects read/write autenticado

## Próximos gates

- [ ] renderer virtualizado e índice espacial
- [ ] PDF e exportação em lote com progresso
- [ ] vector networks e Shape Builder
- [ ] shaping tipográfico profissional
- [ ] bibliotecas compartilhadas na nuvem
- [ ] Smart Animate geométrico
- [ ] CRDT/OT real
- [ ] screenshots como MCP resources
- [ ] streaming de operações no canvas
- [ ] permissões MCP por arquivo, página e frame

## Regra de honestidade

“100%” só poderá ser usado para um gate fechado e testado. Não será usado para afirmar igualdade absoluta com um produto externo em evolução.