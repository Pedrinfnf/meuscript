# FrameFlow Studio V5

Editor de design mobile-first com canvas, frames, layers, vetores, texto, Auto Layout, componentes, variáveis, protótipos, colaboração, histórico, exportação de imagens e integração MCP.

A V5 muda a direção do produto: o fluxo principal não é mais gerar UI Roblox em Lua. O fluxo principal é desenhar com ferramentas normais e exportar frames, layers ou slices como PNG, JPG, WebP, SVG ou JSON. Integrações para Roblox continuam disponíveis apenas como opção de desenvolvimento.

## Fase 1

- Slice Tool (`X`);
- exportação de seleção, frame, layer, slice ou página;
- PNG, JPG, WebP, SVG e FrameFlow JSON;
- escalas de 0.5x a 4x, qualidade, fundo, sufixo e presets;
- copiar como PNG ou SVG;
- renderer SVG independente do DOM;
- schema V5 e migração automática de projetos V4;
- 38 ferramentas MCP, resources e prompts;
- sessões MCP duráveis, permissões, heartbeat e seleção;
- transações MCP persistentes com preview, aprovação, rejeição, aplicação e rollback;
- Roblox removido da navegação principal e mantido apenas como integração opcional.

## Testes

```bash
npm run check
npm test
```

A suíte cobre modelo, exportação, Auto Layout, tipografia, vetores, componentes, variáveis, colaboração, MCP, ações visíveis e inicialização da interface.

## Limite honesto

A V5 não é 100% idêntica ao Figma. A meta é paridade comportamental por área, validada por testes, sem copiar marca, código ou assets proprietários.