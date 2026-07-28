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
