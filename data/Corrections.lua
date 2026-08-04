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

-- Correcoes recentes de quests: texto completo e fragmentos renderizados
-- separadamente pelo cliente.
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

    local titles = {
        [27650] = "Comissão para Ulthaan",
        [27651] = "Comissão para Longbraid, o Implacável",
        [28435] = "Comissão para Daryl, o Novato",
        [28438] = "Comissão para Orendil Folhafarta",
        [28468] = "Comissão para Galamav, o Atirador",
        [28480] = "Comissão para o Estalajadeiro Finmir",
        [28494] = "Comissão para Jason Mathers",
        [28575] = "Comissão para Manaar, o Observador",
        [28583] = "Comissão para Thotar",
        [28603] = "Comissão para Lolo, o Vigia",
    }
    if T then
        for id, title in pairs(titles) do T[id] = title end
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

    A.QuestTextEN2PT = A.QuestTextEN2PT or {}
    local Exact = A.QuestTextEN2PT
    Exact["Promoter of the Azzar Faire"] = "Promotor da Azzar Faire"
    Exact["The spectacular and sensational Azzar Faire is now open to all of you!"] = "A espetacular e sensacional Azzar Faire está aberta para todos!"
    Exact["<The promoter approaches you.>"] = "<O promotor se aproxima de você.>"
    Exact["Get ready for an explosion of fun with thrilling games, amazing prizes, and the tropical charm of a paradise island!"] = "Prepare-se para uma explosão de diversão, com jogos emocionantes, prêmios incríveis e todo o charme tropical de uma ilha paradisíaca!"
    Exact["If you dare to join the party, hand this coupon to Synix at the main entrance of the Azzar Faire. Don't think twice!"] = "Se quiser participar da festa, entregue este cupom a Synix na entrada principal da Azzar Faire. Não pense duas vezes!"
    Exact["Grab your ticket and visit the Azzar Faire!"] = "Pegue seu ingresso e visite a Azzar Faire!"
    Exact["Deliver the Azzar Faire Promotional Ticket to Synix at the Azzar Faire."] = "Entregue o Ingresso Promocional da Azzar Faire a Synix na Azzar Faire."
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

