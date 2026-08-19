<div align="center">

# AscensionPTBR

### Project Ascension em Português do Brasil

![Versão](https://img.shields.io/badge/versão-1.4.54-33ff99)
![Idioma](https://img.shields.io/badge/idioma-PT--BR-009c3b)
![Cliente](https://img.shields.io/badge/cliente-3.3.5a-d4af37)
![Projeto](https://img.shields.io/badge/projeto-comunitário-blue)

Uma localização feita para que jogadores brasileiros entendam o conteúdo do jogo com clareza, sem perder compatibilidade com o Project Ascension.

</div>

## Sobre o projeto

O **AscensionPTBR** é um addon comunitário mantido por **Tuofxit**. Ele traduz para português brasileiro os textos que ajudam o jogador a entender sistemas, objetivos e efeitos durante a partida.

A proposta é oferecer uma tradução natural, legível e estável. O addon atua quando o conteúdo é exibido, reduzindo processamento desnecessário, e preserva identificadores internos importantes para não quebrar a interface.

Esta versão pública utiliza apenas traduções de missões já cadastradas e revisadas. O tradutor automático experimental de missões não está incluído enquanto o protótipo ainda estiver em validação.

### O que é traduzido

- descrições e objetivos de missões;
- efeitos e descrições de habilidades;
- descrições, atributos e efeitos de itens;
- menus, botões, tooltips e janelas personalizadas;
- mensagens de sistema e instruções do servidor;
- trechos restantes em inglês ou espanhol;
- textos grandes, com ajustes para caber melhor nas caixas da interface.

Nomes próprios, nomes de NPCs e alguns nomes de habilidades ou itens podem permanecer em inglês de propósito. Isso facilita buscas, links, comandos e consultas em guias sem comprometer a compreensão das descrições.

## Instalação

1. Baixe o arquivo [`AscensionPTBR.zip`](AscensionPTBR.zip).
2. Extraia a pasta `AscensionPTBR`.
3. Copie a pasta para:

   ```text
   C:\Ascension\Launcher\resources\ascension-live\Interface\AddOns\
   ```

4. A estrutura final deve ficar assim:

   ```text
   Interface\AddOns\AscensionPTBR\AscensionPTBR.toc
   ```

5. Abra o jogo, habilite o addon na lista de AddOns e permita addons desatualizados caso o cliente solicite.
6. Se o jogo já estiver aberto, use `/reload` depois de atualizar os arquivos.

## Caso o addon não apareça na lista de AddOns dentro do jogo

Verifique se a pasta do addon está com o nome exato **`AscensionPTBR`**, sem hífen e sem pastas duplicadas. Em alguns casos, o nome ou a estrutura da pasta impede que o jogo reconheça o addon corretamente.

Correto:

```text
Interface\AddOns\AscensionPTBR\AscensionPTBR.toc
```

Incorreto:

```text
Interface\AddOns\AscensionPT-BR\AscensionPTBR.toc
Interface\AddOns\AscensionPTBR\AscensionPTBR\AscensionPTBR.toc
```

Se a estrutura estiver correta e o addon ainda não aparecer, feche completamente o jogo, abra novamente e confira se a opção para carregar addons desatualizados está habilitada.

## Encontrou um texto sem tradução?

O Project Ascension cria parte de seus textos dinamicamente. Por isso, uma atualização do servidor pode adicionar novas frases ou alterar conteúdos existentes.

Abra uma [issue](https://github.com/tuofxit/AscensionPT-BR/issues/new) e envie, se possível:

1. uma captura de tela legível;
2. o texto exatamente como apareceu;
3. onde ele apareceu — missão, item, habilidade, NPC ou janela;
4. a versão instalada do addon.

Relatos de erros gramaticais, textos em espanhol, descrições em inglês e frases que ultrapassam a interface também são bem-vindos.

## Segurança das traduções

As revisões preservam IDs, chaves internas, códigos de cor e marcadores como `%s`, `%d`, `{{1}}` e `$N`. Esses elementos fazem parte do funcionamento do jogo e não devem ser removidos durante uma tradução.

O projeto é testado no cliente 3.3.5a do Project Ascension. Correções e pull requests são bem-vindos quando mantêm essas estruturas e podem ser verificados dentro do jogo.

## Créditos e agradecimentos

- **Tuofxit** — autoria e manutenção desta versão brasileira.
- **HideXs** — criador do [AscensionES](https://github.com/HideXs/AscensionES), trabalho que serviu de base e inspiração para este projeto.
- **GabrielBosco** — autor do [AscensionPTBR](https://github.com/GabrielBosco/AscensionPTBR), usado como referência e inspiração para melhorias na localização brasileira.
- **Guilda A Cruzada Escarlate** — agradecimento especial pelo apoio ao projeto, pelos testes e pela ajuda na evolução do addon.
- **Comunidade brasileira do Project Ascension** — pelos relatos, capturas de tela e sugestões de correção.

Mais informações estão disponíveis em [CREDITS.md](CREDITS.md), [PERMISSION.md](PERMISSION.md) e [LICENSE-NOTICE.md](LICENSE-NOTICE.md).

---

Project Ascension, World of Warcraft, Warcraft e Blizzard Entertainment pertencem aos seus respectivos proprietários. Este é um projeto comunitário, gratuito, não comercial e sem vínculo oficial com essas marcas.
