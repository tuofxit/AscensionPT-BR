# Ascension PT-BR

> Uma localização comunitária para tornar o Project Ascension mais confortável de jogar em português brasileiro.

O `AscensionPTBR` é mantido a partir de testes reais no cliente 3.3.5a. A prioridade não é traduzir por traduzir: é deixar as informações que ajudam a jogar — telas, objetivos, tooltips, mensagens e descrições — claras, naturais e estáveis.

- **Compatibilidade:** Project Ascension / cliente 3.3.5a
- **Manutenção:** Tuofxit (Bolin) e relatos da comunidade

## Jogue em PT-BR

Esta versão trabalha principalmente com:

- janelas, menus e mensagens de sistema;
- objetivos e descrições de missões;
- explicações de habilidades, efeitos e itens;
- tooltips gerados durante o jogo;
- correções de inglês, espanhol, concordância e texto que ultrapassa a interface.

Nomes próprios, habilidades, itens e NPCs podem continuar em inglês de propósito. Isso ajuda a manter compatibilidade com links do jogo, buscas, guias e identificadores internos do servidor.

## Instalar no seu cliente

1. Baixe [AscensionPTBR.zip](AscensionPTBR.zip) e extraia a pasta `AscensionPTBR`.
2. Coloque essa pasta em:

   ```text
   C:\Ascension\Launcher\resources\ascension-live\Interface\AddOns\
   ```

3. Confira se este arquivo existe no destino:

   ```text
   AscensionPTBR\AscensionPTBR.toc
   ```

4. Abra o jogo, habilite o addon na seleção de personagem e permita addons desatualizados se o cliente solicitar.
5. Se atualizou os arquivos com o jogo aberto, use `/reload`.

## Quando algo ainda aparece errado

O servidor adiciona e monta parte dos textos em tempo real. Depois de uma atualização, pode surgir uma descrição sem tradução, uma frase sem contexto ou uma linha grande demais para a caixa. Esses casos são tratados como correções contínuas, não como uma promessa artificial de “100% pronto”.

Se o problema for uma descrição, objetivo, instrução ou mensagem de sistema, vale reportar. Um nome próprio em inglês, por si só, normalmente não é erro.

## Envie um bom reporte

Abra uma [issue](https://github.com/tuofxit/AscensionPT-BR/issues/new) com, se possível:

1. uma captura de tela legível;
2. o texto exatamente como apareceu;
3. o local no jogo (missão, item, habilidade, NPC ou janela);
4. a versão do addon instalada;
5. uma sugestão de frase, se tiver.

Um print do tooltip aberto costuma ser suficiente para encontrar a origem de uma linha dinâmica. Não é necessário saber Lua para ajudar.

## Como a tradução é preservada

Antes de alterar um texto, a revisão considera contexto, espaço disponível e funcionamento do addon. IDs, chaves de referência, variáveis, placeholders como `%s`, `%d`, `{{1}}` e `$N`, além dos códigos de cor, são preservados para não quebrar a interface.

Correções e pull requests são bem-vindos, desde que respeitem essas estruturas e possam ser testados dentro do jogo.

## Origem e créditos

Esta manutenção brasileira parte do trabalho do [AscensionES](https://github.com/HideXs/AscensionES), criado por **HideXs**. Os créditos, avisos de autoria e condições do projeto de origem continuam preservados aqui.

O projeto também reconhece contribuições e componentes originalmente publicados por [GabrielBosco/AscensionPTBR](https://github.com/GabrielBosco/AscensionPTBR), quando presentes nesta versão. Este repositório mantém revisões, integrações e correções próprias para a versão mantida por Tuofxit.

Consulte também [CREDITS.md](CREDITS.md), [PERMISSION.md](PERMISSION.md) e [LICENSE-NOTICE.md](LICENSE-NOTICE.md).

---

Project Ascension, World of Warcraft, Warcraft e Blizzard Entertainment pertencem aos seus respectivos proprietários. Este é um projeto comunitário, gratuito, não comercial e sem vínculo oficial com essas marcas.
