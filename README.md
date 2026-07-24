# AscensionPT-BR

**Português (Brasil) – quase 100% traduzido**

Este repositório contém a tradução completa do AddOn **Ascension** para o servidor brasileiro.

### O que foi feito?
- Tradução de todas as strings que ainda estavam em inglês (menus, tooltips, mensagens de janela, descrições de missões, etc.).
- Substituição de termos genéricos **Irmandade → Guild** e **Banda → Raid** conforme solicitado.
- Correção de espaçamentos e ajustes de UI que evitavam overflow de caixas de mensagem.
- Implementação de um fallback (`APT.Fallback`) para garantir que qualquer string ainda não presente em `CustomUI.lua` ou `UIStrings.lua` seja traduzida automaticamente em tempo de execução.
- Otimização do laço de atualização dinâmica (`dynamicUIDriver`) para que as traduções apareçam quase instantaneamente (de 2.5 s → 0.4 s).
- Criação do pacote zip `AscensionPTBR.zip` pronto para ser instalado.

### Como funciona?
O AddOn carrega duas tabelas de tradução:
1. **`APT.CustomUI`** – contém todas as traduções específicas de UI customizadas.
2. **`APT.Fallback`** – dicionário de apoio que cobre quaisquer strings que ainda estejam faltando.
A função `TranslateStaticText` foi modificada para procurar nas duas tabelas antes de tentar um fallback de base, garantindo cobertura total.

### Instalação
1. Baixe o arquivo `AscensionPTBR.zip` na pasta `addons` do seu cliente WoW.
2. Reinicie o jogo; as novas traduções aparecerão em todas as janelas do Ascension.

### Contribuição
Sinta‑se à vontade para abrir *issues* ou *pull requests* caso encontre texto ainda não traduzido ou deseje melhorar alguma tradução.

---
*Tradução realizada por **Tuofxit** com a ajuda do assistente de IA . O addon agora está quase totalmente em PT‑BR, proporcionando uma experiência mais imersiva e fluida para a comunidade brasileira.*
