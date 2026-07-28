-- Correções pontuais aplicadas depois que todas as tabelas de dados carregam.
-- Mantém os pares origem/destino consistentes para que tooltips não alternem
-- entre inglês e português enquanto estão abertos.
AscensionPTBR = AscensionPTBR or {}
local APT = AscensionPTBR

APT.ItemName = APT.ItemName or {}
APT.ItemNameEN = APT.ItemNameEN or {}
APT.ItemDesc = APT.ItemDesc or {}
APT.ItemDescEN = APT.ItemDescEN or {}
APT.SpellNameEN2PT = APT.SpellNameEN2PT or {}
APT.DescPairs = APT.DescPairs or {}
APT.LinePatterns = APT.LinePatterns or {}

-- A fonte compacta do cliente 3.3.5 desenha o "Í" inicial de "Índice"
-- de forma incorreta em tooltips. Normalizamos o resultado final das linhas
-- de item, mantendo a frase natural e sem mexer em "indício"/"indícios".
-- As frases completas vêm antes do fallback para não produzir "o seu Taxa".
local TooltipRatingTerms = {
    { "Índice de acerto crítico", "chance de acerto crítico", "sua" },
    { "índice de acerto crítico", "chance de acerto crítico", "sua" },
    { "Índice de acerto", "chance de acerto", "sua" },
    { "índice de acerto", "chance de acerto", "sua" },
    { "Índice de aceleração", "celeridade", "sua" },
    { "índice de aceleração", "celeridade", "sua" },
    { "Índice de perícia", "perícia", "sua" },
    { "índice de perícia", "perícia", "sua" },
    { "Índice de penetração de armadura", "penetração de armadura", "sua" },
    { "índice de penetração de armadura", "penetração de armadura", "sua" },
    { "Índice de bloqueio", "bloqueio", "seu" },
    { "índice de bloqueio", "bloqueio", "seu" },
    { "Índice de defesa", "defesa", "sua" },
    { "índice de defesa", "defesa", "sua" },
    { "Índice de esquiva", "esquiva", "sua" },
    { "índice de esquiva", "esquiva", "sua" },
    { "Índice de aparo", "aparo", "seu" },
    { "índice de aparo", "aparo", "seu" },
    { "Índice de resiliência", "resiliência", "sua" },
    { "índice de resiliência", "resiliência", "sua" },
}

local function NormalizeTooltipRatingText(text)
    if type(text) ~= "string" or text == "" then return text end

    for _, rating in ipairs(TooltipRatingTerms) do
        local source, label, possessive = rating[1], rating[2], rating[3]

        -- O gerador dinâmico de itens produz, por exemplo:
        -- "Equipar: Aumenta em 11 o seu Índice de perícia."
        text = text:gsub(
            "Aumenta em ([^%.%c]+) o seu " .. source .. "%.",
            "Aumenta " .. possessive .. " " .. label .. " em %1."
        )
        text = text:gsub(
            "Aumenta em ([^%.%c]+) o seu " .. source .. "$",
            "Aumenta " .. possessive .. " " .. label .. " em %1."
        )

        -- Algumas descrições legadas usam "Aumenta seu índice ... em X".
        text = text:gsub(
            "Aumenta seu " .. source .. " em ([^%.%c]+)%.",
            "Aumenta " .. possessive .. " " .. label .. " em %1."
        )
        text = text:gsub(
            "Aumenta seu " .. source .. " em ([^%.%c]+)$",
            "Aumenta " .. possessive .. " " .. label .. " em %1."
        )
    end

    -- Fallback para variantes raras. "Bônus de" é masculino e continua
    -- correto depois de "o seu", ao contrário de uma troca cega por "Taxa".
    text = text:gsub("Índice de ", "Bônus de ")
    text = text:gsub("índice de ", "bônus de ")
    return text
end

APT.NormalizeTooltipText = NormalizeTooltipRatingText

APT.ItemName[134985] = "Banco Pessoal"
APT.ItemNameEN[134985] = "Personal Bank"
APT.ItemName[134986] = "Voucher de Aba do Banco Pessoal"
APT.ItemNameEN[134986] = "Personal Bank Tab Voucher"

APT.ItemDesc[134985] = "Dá acesso ao seu Banco Pessoal com abas expansíveis.\nVocê pode guardar itens vinculados nele."
APT.ItemDescEN[134985] = "Gives you access to your Guild Sized Bank with purchasable tabs.\nYou can put soulbound items into bank."

APT.SpellNameEN2PT["Summon Personal Bank"] = "Evocar Banco Pessoal"
APT.SpellNameEN2PT["Summon Celestial Personal Bank"] = "Evocar Banco Pessoal Celestial"
APT.SpellNameEN2PT["Unlock Personal Bank Tab"] = "Desbloquear aba do Banco Pessoal"
APT.SpellNameEN2PT["Unlock Realm Bank Tab"] = "Desbloquear aba do Banco do Reino"

-- Gossip.lua contains a few legacy strings with the typo "indicio". Keep
-- the source file untouched because it has legacy non-UTF-8 bytes, and apply
-- the corrected PT-BR text after the gossip table is loaded.
APT.GossipEN2PT = APT.GossipEN2PT or {}
APT.GossipEN2PT["Mr. Perelli, if you happen across any signs of Scourge activity or shady dealings in your travels, let the nearest Lordaeron soldier know."] = "Sr. Perelli, se encontrar qualquer indício de atividade do Flagelo ou negociações suspeitas durante suas viagens, avise o soldado de Lordaeron mais próximo."
APT.GossipEN2PT["No indications of struggle are present. No guardians are present."] = "Não há indícios de luta. Não há guardiões presentes."

-- The game font renders an initial accented capital I poorly in compact stat
-- labels. Use shorter labels that keep the same meaning and avoid that glyph.
APT.CustomUI = APT.CustomUI or {}
APT.UIStringsByEN = APT.UIStringsByEN or {}
local RatingLabels = {
    { "Hit Rating", "Índice de acerto", "Taxa de acerto" },
    { "Critical Strike Rating", "Índice de acerto crítico", "Taxa de acerto crítico" },
    { "Haste Rating", "Índice de aceleração", "Taxa de aceleração" },
    { "Expertise Rating", "Índice de perícia", "Taxa de perícia" },
    { "Armor Penetration Rating", "Índice de penetração de armadura", "Penetração de armadura" },
    { "Block Rating", "Índice de bloqueio", "Taxa de bloqueio" },
    { "Defense Rating", "Índice de defesa", "Defesa" },
    { "Dodge Rating", "Índice de esquivar", "Taxa de esquiva" },
    { "Parry Rating", "Índice de aparo", "Taxa de aparo" },
}
for _, rating in ipairs(RatingLabels) do
    APT.CustomUI[rating[1]] = rating[3]
    APT.CustomUI[rating[2]] = rating[3]
    APT.UIStringsByEN[rating[1]] = rating[3]
    APT.UIStringsByEN[rating[2]] = rating[3]
end

APT.UIStrings = APT.UIStrings or {}
APT.UIStrings.COMBAT_RATING_NAME2 = "Defesa"
APT.UIStrings.COMBAT_RATING_NAME3 = "Esquiva"
APT.UIStrings.COMBAT_RATING_NAME4 = "Aparo"
APT.UIStrings.COMBAT_RATING_NAME5 = "Bloqueio"
APT.UIStrings.COMBAT_RATING_NAME9 = "Taxa de acerto crítico"
APT.UIStrings.COMBAT_RATING_NAME10 = "Taxa de acerto crítico"
APT.UIStrings.COMBAT_RATING_NAME11 = "Taxa de acerto crítico"

-- A contagem de conjunto impede a busca por prefixo; o Core trata "Set:"
-- antes de chegar a estes pares. Aqui corrigimos as saídas PT-BR existentes.
if APT.DescPairs[48412] then
    APT.DescPairs[48412][2] = "Aumenta em {{1}}% a cura realizada.\nSer afetado por qualquer efeito que impeça você de lançar feitiços ativa um escudo de absorção para seu grupo. Este efeito tem recarga de 30 segundos e, enquanto está em recarga, remove o bônus de cura."
end
if APT.DescPairs[48413] then
    APT.DescPairs[48413][2] = "Curar um alvo com menos de 50% de vida faz com que ele receba {{1}}% a mais de suas curas até recuperar a vida máxima."
end
if APT.DescPairs[48429] then
    APT.DescPairs[48429][2] = "Aumenta em {{1}}% a cura realizada.\nSer afetado por qualquer efeito que impeça você de lançar feitiços ativa um escudo de absorção para seu grupo. Este efeito tem recarga de 30 segundos e, enquanto está em recarga, remove o bônus de cura."
end
if APT.DescPairs[79467] then
    APT.DescPairs[79467][2] = APT.DescPairs[48412] and APT.DescPairs[48412][2] or APT.DescPairs[79467][2]
end
if APT.DescPairs[79472] then
    APT.DescPairs[79472][2] = APT.DescPairs[48429] and APT.DescPairs[48429][2] or APT.DescPairs[79472][2]
end

local function PrioritizeDescriptionPrefix(prefix, preferred)
    local source = APT.DescByPrefix and APT.DescByPrefix[prefix]
    if type(source) == "number" then source = { source } end
    if type(source) ~= "table" then return end

    local ordered, seen = {}, {}
    for _, id in ipairs(preferred) do
        for _, available in ipairs(source) do
            if available == id and not seen[id] then
                ordered[#ordered + 1] = id
                seen[id] = true
            end
        end
    end
    for _, id in ipairs(source) do
        if not seen[id] then ordered[#ordered + 1] = id end
    end
    APT.DescByPrefix[prefix] = ordered
end

-- A versão curta genérica desse prefixo aparecia antes da descrição completa
-- do conjunto e escondia as linhas seguintes em inglês.
PrioritizeDescriptionPrefix("increases healing done by", { 48429, 79472, 48412, 79467 })

-- O painel de personagem é montado antes do hook; este padrão cobre a linha
-- dinâmica "Level 60 Draenei Necromancer" sem alterar nomes de itens ou skills.
table.insert(APT.LinePatterns, 1, { "^Level (%d+) (.-) Necromancer$", "Nível %1 %2 Necromante" })

-- O servidor atualizou esta missão depois da base original: a descrição ganhou
-- Ragnaros/Nefarian e uma regra de desbloqueio de raides. Preservamos a versão
-- antiga e a atual como pares EN/PT-BR exatos; o Core só troca o texto quando
-- uma das fontes conhecidas corresponde integralmente.
APT.QuestData = APT.QuestData or {}
local redeemer = APT.QuestData[1004002]
if redeemer then
    APT.QuestTitle = APT.QuestTitle or {}
    APT.QuestTitleEN = APT.QuestTitleEN or {}
    APT.QuestTitle[1004002] = "O Redentor"
    APT.QuestTitleEN[1004002] = "The Redeemer"

    redeemer.d = [[Tenho observado você há algum tempo, <name>. Agora que seu verdadeiro potencial se manifestou, finalmente chegou a hora de nos conhecermos. Derrotar um inimigo tão poderoso traz recompensas maiores do que os espólios que ele carrega.

Você notou a Raider's Commendation concedida à sua aba de moedas após sua vitória?

Reuni alguns dos equipamentos mais poderosos disponíveis aos heróis. Essas recompensas não são gratuitas; os espólios pertencem ao vencedor.]]

    redeemer.o = [[Já era hora de nos conhecermos pessoalmente, <name>. Você notou a Raider's Commendation concedida à sua aba de moedas após sua vitória?

Reuni alguns dos equipamentos mais poderosos disponíveis aos heróis. Essas recompensas não são gratuitas; os espólios pertencem ao vencedor. Colete mais Raider's Commendations e prove seu valor derrotando os adversários mais poderosos. Então abrirei minha coleção de tesouros para que você escolha sua recompensa.

Derrote chefes de raide para obter Raider's Commendations.]]

    redeemer.oVariants = {
        {
            en = [[It is about time we met in person <name>...
Did you notice the Raider's Commendation awarded to your currency tab after your moment of triumph?

I have collected some of the most powerful gear available to heroes. These rewards do not come free however. To the victor go the spoils. Collect more Raider's Commendations and prove your worth by defeating the ultimate adversaries like Ragnaros or Nefarian, and I will open my collection of treasures for you to pick from.

Slay Raid Bosses to collect Raider's Commendations. Bosses in more higher tier raids reward more Raider's Commendations. You can only unlock raids behind the current tier of content, so Molten Core gear would not become available until Blackwing Lair was released.]],
            pt = [[Já era hora de nos conhecermos pessoalmente, <name>...
Você notou a Raider's Commendation concedida à sua aba de moedas após sua vitória?

Reuni alguns dos equipamentos mais poderosos disponíveis aos heróis. Essas recompensas não são gratuitas; os espólios pertencem ao vencedor. Colete mais Raider's Commendations e prove seu valor derrotando adversários supremos, como Ragnaros ou Nefarian, e abrirei minha coleção de tesouros para que você escolha sua recompensa.

Derrote chefes de raide para obter Raider's Commendations. Chefes em raides de nível mais alto concedem mais Raider's Commendations. Você só pode desbloquear raides dos níveis anteriores ao conteúdo atual; portanto, os equipamentos de Molten Core só ficam disponíveis quando Blackwing Lair é liberada.]],
        },
    }
end
