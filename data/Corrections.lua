-- Revisões humanas ptBR aplicadas sobre registros legados cuja tradução
-- espanhola automática ficou corrompida. IDs, chaves e textos-fonte EN são
-- mantidos nas tabelas originais.
local A = AscensionPTBR
if not A then return end

local Q = A.QuestData
if Q then
    local aquaticIntro =
        "Saudações, jovem $c. Chegou a hora de conhecer nossa Forma Aquática, " ..
        "que permite mover-se livremente pela água por tempo indeterminado. " ..
        "Esse aspecto será uma ferramenta útil e uma bênção, mas você precisará merecê-lo antes de dominá-lo.\n\n" ..
        "Você enfrentará duas provas. A primeira testará sua capacidade de agir na água sob pressão. " ..
        "A segunda testará sua determinação para compreender a própria Forma Aquática.\n\n" ..
        "Prepare-se: a prova começa agora."
    if Q[26] then Q[26].c = aquaticIntro end
    if Q[27] then Q[27].c = aquaticIntro end

    local seaLionProgress =
        "Você formou o pingente para que eu possa examiná-lo, $n? Se precisar de ajuda para encontrar as partes, " ..
        "fale com os moradores daqui. Além de encontrar o que procura, você terá um motivo para explorar esta clareira sagrada."
    local seaLionComplete =
        "Parabéns por concluir a Prova do Leão Marinho, $n.\n\n" ..
        "Cada etapa mostrou que agilidade e resistência são necessárias para agir em harmonia debaixo d'água. " ..
        "Uma não existe sem a outra, e ambas dependem da sua disposição para incorporar o aspecto do leão marinho.\n\n" ..
        "Guarde bem essas lições quando conquistar sua Forma Aquática."
    for _, id in ipairs({ 30, 272 }) do
        if Q[id] then
            Q[id].p = seaLionProgress
            Q[id].c = seaLionComplete
        end
    end

    local aquaticReturn =
        "Soube do seu retorno, mas preciso de uma prova das lições aprendidas na Clareira da Lua antes de ensinar a Forma Aquática.\n\n" ..
        "Você trouxe o Pingente do Leão Marinho?"
    local aquaticReward =
        "Impressionante, $n. Você está $gpronto:pronta; para aprender a Forma Aquática, e será um prazer ensiná-la.\n\n" ..
        "Como reconhecimento pela sua conquista nas duas provas, receba este item. Espero que ele seja útil em sua jornada " ..
        "como $gprotetor:protetora; da natureza e $gguardião:guardiã; do equilíbrio."
    for _, id in ipairs({ 31, 5061 }) do
        if Q[id] then
            Q[id].p = aquaticReturn
            Q[id].c = aquaticReward
        end
    end
end

-- Revisão de títulos de missões de profissão: remover resíduos espanhóis.
do
    local T = A.QuestTitle
    if T then
        T[27650] = "Comissão para Ulthaan"
        T[27651] = "Comissão para Longbraid, o Implacável"
        T[28435] = "Comissão para Daryl, o Novato"
        T[28438] = "Comissão para Orendil Folhafarta"
        T[28468] = "Comissão para Galamav, o Atirador"
        T[28480] = "Comissão para o Estalajadeiro Finmir"
        T[28494] = "Comissão para Jason Mathers"
        T[28575] = "Comissão para Manaar, o Observador"
        T[28583] = "Comissão para Thotar"
        T[28603] = "Comissão para Lolo, o Vigia"
    end
    if Q then
        Q[27650].o = "Xai'ander quer que você use sua habilidade de ferraria para forjar 2 Adagas de Bronze Rápidas e leve o pedido a Ulthaan em Refúgio Vientodela, em Ashenvale central."
        Q[27651].o = "Brahnmar quer que você use sua habilidade de ferraria para forjar 3 Mãos de Bronze Prateadas e leve o pedido a Longbraid the Grim em Dun Modr, nos Pântanos do Norte."
        Q[28435].o = "Barbosão Buscapedras quer que você use sua habilidade de engenharia para criar 5 Fechaduras Práticas e leve o pedido a Dário the Youngling na Estalagem do Pájaro Longo, em Loch Modan."
        Q[28438].o = "Dinis the Purifier quer que você use sua habilidade de engenharia para criar 20 Dinamites Pesadas e leve o pedido a Orendil Broadleaf em Maestra's Post, em Ashenvale."
        Q[28468].o = "Nika Bloodscar quer que você use sua habilidade de engenharia para criar 1 Óculos Hiperenfocadas e leve o pedido a Galamav the Marksman em Karrath, nas Terras Baldías."
        Q[28480].o = "O Estalajadeiro Finmir quer que você use sua habilidade de Primeiros Socorros para criar 20 Bandagens Pesadas de Seda e leve o pedido ao Estalajadeiro Finmir no Refúgio na Lagoa Pantanosa."
        Q[28494].o = "Jason Mathers quer que você use sua habilidade de pesca para coletar 20 Peixes Brilhantes Crus e leve o pedido a Jason Mathers em Lago Cristalino, nas Montanhas do Oeste."
        Q[28575].o = "O Estalajadeiro Finmir quer que você use sua habilidade de Couraria para confeccionar 6 Braçadeiras Verdes de Couro e leve o pedido a Manaar the Watcher no Harborage, no Pântano dos Feitiços."
        Q[28583].o = "Kamari quer que você use sua habilidade de Couraria para criar 1 Aljava de Couro Leve e leve o pedido a Thotar no Penhasco Lâmina, em Durotar."
        Q[28603].o = "Tunkk quer que você use sua habilidade de Couraria para confeccionar 2 Fitas Sombrias e leve o pedido a Lolo the Lookout em Faldir's Cove, nas Terras Altas Arathi."
    end
end

-- Revisão humana 1.4.0: missões clássicas com tradução legada ruim e
-- missões novas do servidor que ainda não possuem ID na base local.
do
    local Q = A.QuestData
    local T = A.QuestTitle

    if Q and Q[40] then
        if T then T[40] = "Perigo Anfíbio" end
        Q[40].d = [=[$n, uma nova ameaça surgiu na Floresta de Elwynn! Os murlocs estão subindo pelos riachos do leste da floresta, espantando os peixes e atacando pessoas inocentes!

Avisei Marshal Dughan, mas ele está mais preocupado com os gnolls e os bandidos. Ele não acredita que os murlocs sejam uma ameaça.

Por favor, $n, fale com Dughan e convença-o a enviar mais tropas para o leste!]=]
        Q[40].o = [=[Remy "Two Times" quer que você fale com Marshal Dughan em Goldshire.]=]
        Q[40].c = [=[Sim, falei com Remy. Eu o respeito como comerciante, mas os relatos sobre murlocs no leste são vagos, na melhor das hipóteses.

Sua preocupação foi registrada, mas, sem um relatório militar que confirme a ameaça dos murlocs, não podemos enviar mais tropas para o leste.]=]
    end

    local capitalSupplies = {
        [1650238] = {
            objective = "Obtenha as mercadorias listadas no Trade District de Stormwind e leve-as para Bridda na Azzar Faire.",
            progress = "Você trouxe os suprimentos? Tudo de que preciso é vendido no Trade District de Stormwind. Vai ser fácil conseguir tudo, confie em mim.",
        },
        [1650239] = {
            objective = "Obtenha as mercadorias listadas no Valley of Strength de Orgrimmar e leve-as para Bridda na Azzar Faire.",
            progress = "Você trouxe os suprimentos? Tudo de que preciso é vendido no Valley of Strength de Orgrimmar. Vai ser fácil conseguir tudo, confie em mim.",
        },
        [1650275] = {
            objective = "Obtenha as mercadorias listadas no Trade District de Stormwind e leve-as para Bridda na Azzar Faire.",
            progress = "Você trouxe os suprimentos? Tudo de que preciso é vendido no Trade District de Stormwind. Vai ser fácil conseguir tudo, confie em mim.",
        },
        [1650276] = {
            objective = "Obtenha as mercadorias listadas no Valley of Strength de Orgrimmar e leve-as para Bridda na Azzar Faire.",
            progress = "Você trouxe os suprimentos? Tudo de que preciso é vendido no Valley of Strength de Orgrimmar. Vai ser fácil conseguir tudo, confie em mim.",
        },
    }
    if Q then
        for id, correction in pairs(capitalSupplies) do
            if Q[id] then
                Q[id].o = correction.objective
                Q[id].p = correction.progress
            end
        end

        if Q[1650271] then
            Q[1650271].o = "Aposte em uma corrida de caracóis na Azzar Faire."
            Q[1650271].p = "Ei! Você já fez sua aposta? Se sim, vá até o subterrâneo e torça por seu veloz corredor. Boa sorte!"
            Q[1650271].c = "A sorte sorriu para a sua aposta? Espero que tenha se divertido! Aceite este prêmio e volte quando quiser apostar novamente."
        end
    end

    A.QuestTextEN2PT = A.QuestTextEN2PT or {}
    local Exact = A.QuestTextEN2PT
    Exact["Azzar Faire"] = "Feira de Azzar"
    Exact[ [=[The spectacular and sensational Azzar Faire is now open to all of you!

<The promoter approaches you.>

Get ready for an explosion of fun with thrilling games, amazing prizes, and the tropical charm of a paradise island!

If you dare to join the party, hand this coupon to Synix at the main entrance of the Azzar Faire. Don't think twice!

Grab your ticket and visit the Azzar Faire!]=] ] = [=[A espetacular e sensacional Azzar Faire está aberta para todos!

<O promotor se aproxima de você.>

Prepare-se para uma explosão de diversão, com jogos emocionantes, prêmios incríveis e todo o charme tropical de uma ilha paradisíaca!

Se quiser participar da festa, entregue este cupom a Synix na entrada principal da Azzar Faire. Não pense duas vezes!

    Pegue seu ingresso e visite a Azzar Faire!]=]
    -- O cliente pode entregar cada paragrafo em um FontString separado.
    Exact["Promoter of the Azzar Faire"] = "Promotor da Azzar Faire"
    Exact["The spectacular and sensational Azzar Faire is now open to all of you!"] =
        "A espetacular e sensacional Azzar Faire está aberta para todos!"
    Exact["<The promoter approaches you.>"] = "<O promotor se aproxima de você.>"
    Exact["Get ready for an explosion of fun with thrilling games, amazing prizes, and the tropical charm of a paradise island!"] =
        "Prepare-se para uma explosão de diversão, com jogos emocionantes, prêmios incríveis e todo o charme tropical de uma ilha paradisíaca!"
    Exact["If you dare to join the party, hand this coupon to Synix at the main entrance of the Azzar Faire. Don't think twice!"] =
        "Se quiser participar da festa, entregue este cupom a Synix na entrada principal da Azzar Faire. Não pense duas vezes!"
    Exact["Grab your ticket and visit the Azzar Faire!"] =
        "Pegue seu ingresso e visite a Azzar Faire!"
    Exact["Deliver the Azzar Faire Promotional Ticket to Synix at the Azzar Faire."] =
        "Entregue o Ingresso Promocional da Azzar Faire a Synix na Azzar Faire."

    -- Missão customizada da Synix. Como o ID ainda não existe na base
    -- histórica, o Core usa estes textos exatos tanto na janela clássica
    -- quanto nas variantes que dividem a descrição em vários FontStrings.
    Exact["Goblin Security Screening"] = "Inspeção de Segurança Goblin"
    Exact[ [=[Before we let you in, we need to give you a quick scan. I hope you understand; it's Faire policy.

Here's the pamphlet with the Faire map. Take a look while I run this scanner over you.

<The goblin points a sketchy-looking gadget at you. As the laser scans you from head to toe, you notice a growing smell of something burning.>

I promise, our scanning technology is totally safe. Just a few more seconds and we're good to go!]=] ] = [=[Antes de deixarmos você entrar, precisamos fazer uma rápida inspeção. Espero que entenda; é uma regra da feira.

Aqui está o panfleto com o mapa da feira. Dê uma olhada enquanto passo este scanner em você.

<O goblin aponta para você um aparelho de aparência duvidosa. Enquanto o laser o examina da cabeça aos pés, você percebe um cheiro cada vez mais forte de algo queimando.>

Prometo que nossa tecnologia de inspeção é totalmente segura. Só mais alguns segundos e estará tudo pronto!]=]
    Exact["Before we let you in, we need to give you a quick scan. I hope you understand; it's Faire policy."] =
        "Antes de deixarmos você entrar, precisamos fazer uma rápida inspeção. Espero que entenda; é uma regra da feira."
    Exact["Here's the pamphlet with the Faire map. Take a look while I run this scanner over you."] =
        "Aqui está o panfleto com o mapa da feira. Dê uma olhada enquanto passo este scanner em você."
    Exact["<The goblin points a sketchy-looking gadget at you. As the laser scans you from head to toe, you notice a growing smell of something burning.>"] =
        "<O goblin aponta para você um aparelho de aparência duvidosa. Enquanto o laser o examina da cabeça aos pés, você percebe um cheiro cada vez mais forte de algo queimando.>"
    Exact["I promise, our scanning technology is totally safe. Just a few more seconds and we're good to go!"] =
        "Prometo que nossa tecnologia de inspeção é totalmente segura. Só mais alguns segundos e estará tudo pronto!"
    Exact["Open the map and wait for the scanning to be complete."] =
        "Abra o mapa e aguarde a conclusão da inspeção."
    Exact[ [=[Whoa, phew... <Synix waves a hand in front of her nose to ward off the burning smell.>

Well, the good news is it looks like you're all set!]=] ] = [=[Uau, ufa... <Synix abana a mão diante do nariz para afastar o cheiro de queimado.>

Bem, a boa notícia é que parece que está tudo certo com você!]=]

    Exact["Faire Points of Interest"] = "Pontos de Interesse da Feira"
    Exact[ [=[The barely contained excitement, the blinding lights, and the shouts of pure joy from other visitors can be quite disorienting, I know. Thus, before diving into the fun, you would do well to locate the main points of interest.

We highly recommend checking out the big central tent, the fairgrounds, the beach bar, and of course, the roller coaster.

Once you've hit all the hot spots, swing back here!]=] ] = [=[A empolgação quase incontida, as luzes ofuscantes e os gritos de pura alegria dos outros visitantes podem deixar qualquer um desorientado, eu sei. Por isso, antes de mergulhar na diversão, é melhor localizar os principais pontos de interesse.

Recomendamos que você visite a grande tenda central, o parque da feira, o bar da praia e, é claro, a montanha-russa.

Depois de conhecer todos esses lugares, volte aqui!]=]
    Exact["Speak with the workers to get more information about the main points of interest in the Azzar Faire."] =
        "Fale com os funcionários para obter mais informações sobre os principais pontos de interesse da Azzar Faire."

    -- Continuação do evento Azzar Faire, capturada diretamente do cliente.
    Exact["Restocking the Alcohol"] = "Repondo o Estoque de Bebidas"
    Exact[ [=[Hey there, darling! Enjoying paradise? This sun works wonders, doesn't it?

<Xoxis gives you a wink, her ever-contagious smile lighting up her face.>

Listen, I've got a little problem... They delivered a barrel of alcohol that's supposed to be at the Azzar Faire tavern, but it ended up here at my beach bar instead. And, well, none of my workers can leave this place unattended, and the barrel weighs about as much as our grill master... Would you be a sweetheart and take the barrel over to Zanket at the tavern?

I'm sure he'll make it worth your while, and if not... well, I'll have a little chat with him myself!]=] ] = [=[Olá, querido! Aproveitando o paraíso? Este sol faz maravilhas, não acha?

<Xoxis pisca para você, e seu sorriso sempre contagiante ilumina o rosto.>

Olha, estou com um pequeno problema... Entregaram um barril de bebida que deveria ter ido para a taverna da Azzar Faire, mas ele acabou aqui no meu bar da praia. E, bem, nenhum dos meus funcionários pode deixar este lugar sem supervisão, e o barril pesa quase tanto quanto o nosso mestre da grelha... Você poderia fazer a gentileza de levar o barril até Zanket, na taverna?

Tenho certeza de que ele recompensará você. Caso contrário... bem, eu mesma terei uma conversinha com ele!]=]
    Exact[ [=[Hey there, darling! Enjoying paradise?
This sun works wonders, doesn't it?

<Xoxis gives you a wink, her ever-contagious smile lighting up her face.>

Listen, I've got a little problem... They delivered a barrel of alcohol that's supposed to be at the Azzar Faire tavern, but it ended up here at my beach bar instead. And, well, none of my workers can leave this place unattended, and the barrel weighs about as much as our grill master... Would you be a sweetheart and take the barrel over to Zanket at the tavern?

I'm sure he'll make it worth your while, and if not... well, I'll have a little chat with him myself!]=] ] =
        Exact[ [=[Hey there, darling! Enjoying paradise? This sun works wonders, doesn't it?

<Xoxis gives you a wink, her ever-contagious smile lighting up her face.>

Listen, I've got a little problem... They delivered a barrel of alcohol that's supposed to be at the Azzar Faire tavern, but it ended up here at my beach bar instead. And, well, none of my workers can leave this place unattended, and the barrel weighs about as much as our grill master... Would you be a sweetheart and take the barrel over to Zanket at the tavern?

I'm sure he'll make it worth your while, and if not... well, I'll have a little chat with him myself!]=] ]

    Exact["Great to see you again! Have you enjoyed exploring the area? This has been but a first glimpse of everything that awaits you at the Azzar Faire. Now, enjoy to the fullest!"] =
        "Que bom ver você novamente! Gostou de explorar a área? Isso foi apenas uma primeira amostra de tudo o que espera por você na Azzar Faire. Agora, divirta-se ao máximo!"

    Exact["The Face of the Faire"] = "O Rosto da Feira"
    Exact[ [=[I'd say you're in luck! Today a very special person is visiting us!

Gizmo, the creator and founder of our wonderful faire, is here in the park and has decided to share a delightful snack with all the leisure, culture, and fun enthusiasts. If you also live the faire with the same passion as he does, don't think twice and go meet him. You'll find him in the big central tent. I wouldn't miss this unique opportunity to meet the genius behind all this magic if I were you!]=] ] = [=[Eu diria que você está com sorte! Hoje, uma pessoa muito especial está nos visitando!

Gizmo, o criador e fundador da nossa maravilhosa feira, está no parque e decidiu compartilhar um lanche delicioso com todos os apaixonados por lazer, cultura e diversão. Se você vive a feira com a mesma paixão que ele, não pense duas vezes: vá conhecê-lo. Você o encontrará na grande tenda central. Se eu fosse você, não perderia esta oportunidade única de conhecer o gênio por trás de toda essa magia!]=]
    Exact["Speak with Gizmo, the founder of the faire, in the big central tent."] =
        "Fale com Gizmo, o fundador da feira, na grande tenda central."

    -- Gizmo / investidores da Feira Azzar. Estes textos foram capturados do
    -- cliente em 18/08/2026 e permanecem como traduções exatas revisadas.
    Exact["Those Who Bring the Dough"] = "Quem Traz a Grana"
    Exact[ [=[Friend! Here, take a pin! It's the latest souvenir from the Azzar Faire, and it's completely free for you. Wear it proudly as a symbol of this incredible faire.

<Gizmo pins the souvenir on you.>

Be honest, don't you feel that this room lacks a bit of color? The long faces of the investors… they don't reflect the true spirit of the faire. I understand their focus is solely on the money the business generates, but with the global success we are experiencing, they could afford to smile a bit more!

Let's brighten up the atmosphere! Help me distribute these colorful pins and thank them for how well-invested their money is in this faire. It will be a good way to break the ice and do some networking. You never know when you might need someone with resources in the future, right?]=] ] = [=[Amigo! Tome um broche! Esta é a lembrança mais recente da Feira Azzar, totalmente grátis para você. Use-o com orgulho como símbolo desta feira incrível.

<Gizmo prende o broche em sua roupa.>

Seja sincero: você não acha que falta um pouco de cor neste lugar? As caras fechadas dos investidores... elas não refletem o verdadeiro espírito da feira. Entendo que eles se concentrem apenas no dinheiro gerado pelo negócio, mas, com o sucesso mundial que estamos alcançando, bem que poderiam sorrir um pouco mais!

Vamos animar o ambiente! Ajude-me a distribuir estes broches coloridos e a agradecer a eles por investirem tão bem seu dinheiro nesta feira. Será uma boa maneira de quebrar o gelo e fazer novos contatos. Nunca se sabe quando você poderá precisar de alguém com recursos no futuro, não é?]=]
    Exact["Give an Azzar Pin to the faire's main investors: Pipa, Aldara, Greely and Hobart."] =
        "Entregue um Broche da Feira Azzar aos principais investidores: Pipa, Aldara, Greely e Hobart."
    Exact["Why did you choose this location for the faire?"] =
        "Por que você escolheu este local para a feira?"
    Exact["Does the fair need more investors?"] =
        "A feira precisa de mais investidores?"
    Exact["Where did the idea of building a faire come from?"] =
        "De onde surgiu a ideia de construir uma feira?"
    Exact[ [=[<Gizmo is thinking out loud. His tiny eyes dart nervously around, taking note of every small detail.>

That fence is a meter too far to the left… and is that… mud? On the carpet? Intolerable!

Too many mistakes. Too many slips. The faire has to be perfect.]=] ] = [=[<Gizmo pensa em voz alta. Seus olhinhos percorrem o ambiente nervosamente, atentos a cada pequeno detalhe.>

Aquela cerca está um metro à esquerda do lugar certo... e aquilo é... lama? No tapete? Intolerável!

Erros demais. Deslizes demais. A feira precisa ser perfeita.]=]
    Exact[ [=[Your face… I don't recognize it… That can only mean you are new to the Azzar Faire!

<Gizmo enthusiastically shakes your hand and introduces himself.>

Welcome, <name>! I hope your experience here is absolutely fantastic. If you feel like it, have a snack and enjoy! Or not, it's up to you! Feel at home and do whatever you want. I've designed this place so that fun has no limits!]=] ] = [=[Seu rosto... não me é familiar... Isso só pode significar que você é novo na Feira Azzar!

<Gizmo aperta sua mão com entusiasmo e se apresenta.>

Boas-vindas, <name>! Espero que sua experiência aqui seja absolutamente fantástica. Se quiser, faça um lanche e divirta-se! Ou não, você decide! Sinta-se em casa e faça o que quiser. Criei este lugar para que a diversão não tenha limites!]=]

    -- Conclusão de "Those Who Bring the Dough". O servidor insere o nome
    -- do personagem diretamente no segundo parágrafo; <name> permite que a
    -- mesma tradução funcione para qualquer jogador.
    Exact[ [=[Fantastic job! Now everyone proudly shows where they've put a good part of their money.

Thank you very much, <name>. Now dive into the faire and soak up every bit of the fun! Oh yes... and for that you'll need...

<Gizmo rummages in one of his dozen pockets.>

Here you go! See you around the attractions!]=] ] = [=[Trabalho fantástico! Agora todos exibem com orgulho onde investiram boa parte do dinheiro.

Muito obrigado, <name>. Agora aproveite a feira e curta cada momento da diversão! Ah, sim... e, para isso, você vai precisar de...

<Gizmo vasculha um de seus doze bolsos.>

Aqui está! Vejo você nas atrações!]=]
end



-- Otimizacao/revisao 1.3: correcoes pontuais e seguras sobre dados legados.
do
    local S = A.SpellNameEN2ES
    if S then
        S["Amber Shardhide"] = "Pele de Estilhaço Âmbar"
        S["Amber Spiteful Frog"] = "Sapo Âmbar Rancoroso"
        S["Amethyst Glintshell"] = "Carapaça Brilhante de Ametista"
        S["Captain's Resolve"] = "Determinação do Capitão"
        S["Captain’s Resolve"] = "Determinação do Capitão"
        S["Corroded Carapace: Physical"] = "Carapaça Corroída: Dano Físico"
        S["Elder Hide"] = "Couro Ancião"
    end

    local I = A.ItemDesc
    if I then
        I[30721] = "*ATENÇÃO* Fantasmas não gostam de ser vistos."
        I[37027] = "AVISO: NÃO ABRIR, QUEBRAR, COMER, VESTIR, BEBER NEM CHEIRAR."
        I[50301] = "ATENÇÃO: Não há garantia de que realmente contenha uma mascote."
        I[54218] = "ATENÇÃO: Não há garantia de que realmente contenha uma montaria."
    end
end

-- Revisão de prioridade alta 1.3.0c: correções humanas de resíduos
-- espanhóis e traduções híbridas encontradas na auditoria.
do
    local S = A.SpellNameEN2ES
    if S then
        S["Fetch Shrunken Dragon's Claw"] = "Buscar a Garra de Dragão Encolhida"
        S["I'm not afraid cause yeah I'm gliding"] = "Não tenho medo, pois estou planando"
        S["Ironman - Skills Before Kills"] = "Homem de Ferro — Habilidades Antes das Baixas"
        S["Shudder Before The Scythe"] = "Estremecer Diante da Foice"
        S["Sigil of The Nightmare Before Winter Veil"] = "Selo do Pesadelo Antes do Véu de Inverno"
    end

    local I = A.ItemDesc
    if I then
        I[30417] = "Fede, é nojento e grande demais para você, mas é o que você procura."
        I[30759] = "Pode lançar outra flecha antes que a primeira alcance o alvo."
        I[33040] = "Renn o consertou, mas ninguém sabe quanto tempo vai durar."
        I[34600] = "É melhor devolvê-la a Glrglrglr o quanto antes!"
        I[34710] = "Lance um e procure abrigo!"
        I[39318] = "É melhor devolvê-la a Har'koa o quanto antes!"
        I[40536] = "Aviso: pode explodir prematuramente se for submetido a um pulso eletromagnético."
        I[44511] = "Embora você já tenha lido este molde, os elementos o danificaram tanto que seu conteúdo foi perdido."
        I[98074] = "Ensina a evocar este companheiro.\n\n|cFFFFD100Bip, bop. Cogsley ao seu dispor. Precisa de ajuda na Tormenta de Mana? Posso reparar seus itens e comprar suas mercadorias.|r\n\n|cFFFFD100Cogsley funciona somente na Tormenta de Mana.|r\n\nEste é um companheiro não combatente."
        I[355168] = "Antes do ataque da Horda, as forças de Stromgarde usavam bestas como esta para eliminar membros da Camarilha que se aventurassem ao alcance da ponte."
        I[777992] = "Estes itens não são mais usados e podem ser excluídos. Você pode escolher novamente seus feitiços iniciais pelo Avanço do Personagem (atalho N) antes de alcançar o nível 10."
        I[824385] = "Não pertenço a nenhuma filosofia; pertenço ao mundo real. A realidade não se ajusta a ideologias. Elas são abstrações convenientes que adotamos por medo de fazer perguntas sem a promessa de respostas."
        I[1389901] = I[824385]
    end

    local C = A.AchCritEN2ES
    if C then
        C["Complete 130 quests in Boren Tundra"] = "Conclua 130 missões na Tundra Boreana."
        C["Complete 100 Storm Peaks Quests"] = "Conclua 100 missões nos Picos Tempestuosos."
        C["Complete 2000 quests"] = "Conclua 2.000 missões."
    end
end

