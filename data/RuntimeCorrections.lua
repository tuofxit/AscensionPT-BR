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
