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
APT.DescByID = APT.DescByID or {}
APT.TipPairs = APT.TipPairs or {}
APT.LinePatterns = APT.LinePatterns or {}
APT.RuntimeDescriptionPairs = APT.RuntimeDescriptionPairs or {}
APT.ServerUI = APT.ServerUI or {}
APT.TalentUIExact = APT.TalentUIExact or {}
APT.ChatExact = APT.ChatExact or {}
APT.ErrExact = APT.ErrExact or {}

-- Descrições do Livro de Feitiços que usam uma variante textual não coberta
-- pelos padrões históricos de SpellDescs.lua.
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cff8fff7aGenerates 1 Advantage|r\nEmanate an aura for (.-) that grants party and raid members a (.-)%% chance when they cast a spell or ability to heal themselves for (.-)%.\n\nWhile active, you generate 3 Focus every (.-) sec%.\n\nAll |cffffffffRanger's Horn|r spells share a cooldown%.%s*$",
    "|cff8fff7aGera 1 Vantagem|r\nEmana uma aura durante {{1}} que concede aos membros do grupo e da raide {{2}}% de chance de se curarem em {{3}} ao lançar um feitiço ou habilidade.\n\nEnquanto está ativa, você gera 3 Foco a cada {{4}} s.\n\nTodos os feitiços de |cffffffffRanger's Horn|r compartilham o tempo de recarga."
}
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cff8fff7aGenerates 1 Advantage|r\nEmanate an aura for (.-) that reduces the resource costs of spells by (.-)%% for party and raid members within (.-) yds%.\n\nWhile active, you generate 3 Focus every (.-) sec%.\n\nAll |cffffffffRanger's Horn|r spells share a cooldown%.%s*$",
    "|cff8fff7aGera 1 Vantagem|r\nEmana uma aura durante {{1}} que reduz em {{2}}% o custo de recursos dos feitiços dos membros do grupo e da raide em um raio de {{3}} m.\n\nEnquanto está ativa, você gera 3 Foco a cada {{4}} s.\n\nTodos os feitiços de |cffffffffRanger's Horn|r compartilham o tempo de recarga."
}
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cFF66DDFFLevel (.-) Passive|r\nYour damaging critical strikes now spawn a green |cFFFFFFFFDream Flower|r at a random location within 15 yds of you%.\n\nCan only occur once per sec%.%s*$",
    "|cFF66DDFFNível {{1}} Passivo|r\nSeus acertos críticos de dano agora geram uma |cFFFFFFFFDream Flower|r verde em um local aleatório a até 15 m de você.\n\nSó pode ocorrer uma vez por s."
}

-- O Livro de Feitiços entrega estas descrições já quebradas em linhas visuais.
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cff8fff7aGenerates 1 Advantage|r\nEmanate an aura for (.-) that grants party and raid members a (.-)%% chance when they cast a spell or ability to heal themselves for (.-)%.%s*$",
    "|cff8fff7aGera 1 Vantagem|r\nEmana uma aura durante {{1}} que concede aos membros do grupo e da raide {{2}}% de chance de se curarem em {{3}} ao lancar um feitico ou habilidade."
}
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cff8fff7aGenerates 1 Advantage|r\nEmanate an aura for (.-) that reduces the resource costs of spells by (.-)%% for party and raid members within (.-) yds%.\n\nWhile active, you generate 3 Focus every (.-) sec%.%s*$",
    "|cff8fff7aGera 1 Vantagem|r\nEmana uma aura durante {{1}} que reduz em {{2}}% o custo de recursos dos feiticos dos membros do grupo e da raide em um raio de {{3}} m.\n\nEnquanto esta ativa, voce gera 3 Foco a cada {{4}} s."
}
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cff8fff7aGenerates 1 Advantage|r\nEmanate an aura for (.-) that grants (.-)%% increased critical strike chance to party and raid members%. Does not stack with similar effects%.\n\nWhile active, you generate 3 Focus every (.-) sec%.%s*$",
    "|cff8fff7aGera 1 Vantagem|r\nEmana uma aura durante {{1}} que aumenta em {{2}}% a chance de acerto critico dos membros do grupo e da raide. Nao acumula com efeitos semelhantes.\n\nEnquanto esta ativa, voce gera 3 Foco a cada {{3}} s."
}
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cff8fff7aGenerates 1 Advantage|r\nEmanate an aura for (.-) that grants (.-)%% increased critical strike chance to party and raid members%. Does not stack with similar effects%.\n\nWhile active, you generate 3 Focus every (.-) sec%.\n\nAll |cffffffffRanger's Horn|r spells share a cooldown%.%s*$",
    "|cff8fff7aGera 1 Vantagem|r\nEmana uma aura durante {{1}} que aumenta em {{2}}% a chance de acerto critico dos membros do grupo e da raide. Nao acumula com efeitos semelhantes.\n\nEnquanto esta ativa, voce gera 3 Foco a cada {{3}} s.\n\nTodos os feiticos de |cffffffffRanger's Horn|r compartilham o tempo de recarga."
}
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cff8fff7aGenerates 1 Advantage|r\nEmanate an aura for (.-) that grants (.-)%% increased haste to party and raid members%. Does not stack with similar effects%.\n\nWhile active, you generate (.-) Focus every (.-) sec%.%s*$",
    "|cff8fff7aGera 1 Vantagem|r\nEmana uma aura durante {{1}} que aumenta em {{2}}% a aceleracao dos membros do grupo e da raide. Nao acumula com efeitos semelhantes.\n\nEnquanto esta ativa, voce gera {{3}} Foco a cada {{4}} s."
}
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^|cff8fff7aGenerates 1 Advantage|r\nEmanate an aura for (.-) that grants (.-)%% increased haste to party and raid members%. Does not stack with similar effects%.\n\nWhile active, you generate (.-) Focus every (.-) sec%.\n\nAll |cffffffffRanger's Horn|r spells share a cooldown%.%s*$",
    "|cff8fff7aGera 1 Vantagem|r\nEmana uma aura durante {{1}} que aumenta em {{2}}% a aceleracao dos membros do grupo e da raide. Nao acumula com efeitos semelhantes.\n\nEnquanto esta ativa, voce gera {{3}} Foco a cada {{4}} s.\n\nTodos os feiticos de |cffffffffRanger's Horn|r compartilham o tempo de recarga."
}
APT.RuntimeDescriptionPairs[#APT.RuntimeDescriptionPairs + 1] = {
    "^Emanate an aura for (.-) that grants party members within (.-) yds (.-)%% increased magic damage and (.-)%% reduced pushback from taking damage while casting%.\n\nAll |cffffffffRanger's Horn|r spells share a cooldown%.%s*$",
    "Emana uma aura durante {{1}} que concede aos membros do grupo em um raio de {{2}} m {{3}}% de dano magico aumentado e {{4}}% de reducao de recuo ao sofrer dano enquanto lancam feiticos.\n\nTodos os feiticos de |cffffffffRanger's Horn|r compartilham o tempo de recarga."
}

local hornDescriptionLines = {
    { "^|cff8fff7aGenerates (.-) Advantage|r$", "|cff8fff7aGera %1 Vantagem|r" },
    { "^Gera (.-) Advantage$", "Gera %1 Vantagem" },
    { "^grants party and raid members a (.-)%% chance when they cast a spell$", "concede aos membros do grupo e da raide %1%% de chance ao lancarem um feitico" },
    { "^grants party and raid members a (.-)%% chance when they cast a spell or ability to heal themselves for (.-)%.$", "concede aos membros do grupo e da raide %1%% de chance de se curarem em %2 ao lancar um feitico ou habilidade." },
    { "^that grants (.-)%% increased critical strike chance$", "que aumenta em %1%% a chance de acerto critico" },
    { "^that grants (.-)%% increased haste$", "que aumenta em %1%% a aceleracao" },
    { "^to party and raid members%. Does not$", "dos membros do grupo e da raide. Nao" },
    { "^stack with similar effects%.$", "acumula com efeitos semelhantes." },
    { "^by (.-)%% for allies within (.-) yds%.$", "em %1%% para aliados em um raio de %2 m." },
    { "^Emanate an aura for (.-) that$", "Emana uma aura durante %1 que" },
    { "^grants party and raid members a$", "concede aos membros do grupo e da raide uma" },
    { "^(.-)%% chance when they cast a spell$", "%1%% de chance ao lançarem um feitiço" },
    { "^or ability to heal themselves for (.-)%.$", "ou habilidade de se curarem em %1." },
    { "^reduces the resource costs of spells$", "reduz o custo dos feitiços" },
    { "^by (.-)%% for party and raid members$", "em %1%% para os membros do grupo e da raide" },
    { "^within (.-) yds%.$", "dentro de um raio de %1 m." },
    { "^While active, you generate (.-) Focus$", "Enquanto está ativo, você gera %1 de Foco" },
    { "^every (.-) sec%.$", "a cada %1 s." },
    { "^All |cffffffffRanger's Horn|r spells share a$", "Todos os feitiços de |cffffffffRanger's Horn|r compartilham o" },
    { "^cooldown%.$", "tempo de recarga." },
}
for _, pattern in ipairs(hornDescriptionLines) do
    table.insert(APT.LinePatterns, 1, pattern)
end

-- Politica central para habilidades: os nomes permanecem exatamente como o
-- servidor os envia em ingles; somente as descricoes sao localizadas. A base
-- historica usa SpellNameEN2ES para dezenas de milhares de nomes e algumas
-- telas customizadas reutilizam ServerUI/TalentUIExact, o que fazia o titulo
-- ser traduzido antes de o tooltip conseguir localizar a descricao pelo nome.
--
-- A tabela original e convertida em um catalogo-identidade no carregamento.
-- Isso nao cria varredura, timer ou trabalho por quadro: e uma unica passagem
-- durante o login e mantem as consultas O(1) usadas pelo Core.
do
    local spellNames = APT.SpellNameEN2ES
    if type(spellNames) ~= "table" then spellNames = APT.SpellNameEN2PT or {} end

    local function PlainFirstLine(text)
        if type(text) ~= "string" then return nil end
        local first = text:match("^([^\n]+)") or text
        return first:gsub("|c%x%x%x%x%x%x%x%x", "")
            :gsub("|r", "")
            :gsub("|T.-|t", "")
            :gsub("^%s+", "")
            :gsub("%s+$", "")
    end

    local function EscapePattern(text)
        return (text:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1"))
    end

    -- Apenas traducoes que realmente aparecem nas tabelas de interface
    -- precisam do caminho inverso. Assim evitamos duplicar em memoria toda a
    -- base de nomes, que e muito grande.
    local reverse = APT.SpellNamePT2EN or {}
    local dictionaries = { APT.ServerUI, APT.ServerUINoColor }
    for _, dictionary in ipairs(dictionaries) do
        if type(dictionary) == "table" then
            for source, translated in pairs(dictionary) do
                local english = PlainFirstLine(source)
                if english and spellNames[english] and type(translated) == "string" then
                    local localized = PlainFirstLine(translated)
                    local historical = PlainFirstLine(spellNames[english])
                    -- SpellNames tambem contem alguns rotulos genericos, como
                    -- "Whisper" e "Hit Rating". So trate a entrada como titulo
                    -- de habilidade quando ela tem estilo/rank de habilidade ou
                    -- quando usa exatamente a antiga traducao desse nome.
                    local isSpellLabel = source:find("|c", 1, true)
                        or source:find("\n", 1, true)
                        or (localized and historical and localized == historical)
                    if isSpellLabel then
                        if localized and localized ~= english and not reverse[localized] then
                            reverse[localized] = english
                        end

                        -- Preserva a primeira linha (nome e codigos de cor) e
                        -- localiza somente metadados exibidos nas linhas seguintes.
                        local first, tail = source:match("^([^\n]+)(.*)$")
                        if first then
                            tail = (tail or "")
                                :gsub("Level", "Nível")
                                :gsub("Rank", "Grau")
                            dictionary[source] = first .. tail
                        else
                            dictionary[source] = source
                        end
                    end
                end
            end
        end
    end

    -- Neutraliza a traducao do titulo sem perder o catalogo usado para detectar
    -- nomes e encontrar IDs/descricoes. Fazemos a mudanca na propria tabela para
    -- nao manter uma segunda copia de dezenas de milhares de entradas.
    for english in pairs(spellNames) do
        if type(english) == "string" then spellNames[english] = english end
    end
    APT.SpellNameEN2PT = spellNames
    APT.SpellNameEN2ES = spellNames
    APT.SpellNamePT2EN = reverse

    APT.ResolveOriginalSpellName = function(text)
        local plain = PlainFirstLine(text)
        if not plain or plain == "" then return nil end
        if spellNames[plain] then return plain end
        return reverse[plain]
    end

    APT.RestoreOriginalSpellNameText = function(text)
        if type(text) ~= "string" or text == "" then return nil end
        local plain = PlainFirstLine(text)
        local english = plain and (spellNames[plain] and plain or reverse[plain])
        if not english then return nil end
        if english == plain then return text end
        local first, tail = text:match("^([^\n]+)(.*)$")
        if not first then return english end
        local restored, count = first:gsub(EscapePattern(plain), english, 1)
        if count == 0 then restored = english end
        return restored .. (tail or "")
    end
end

-- Habilidades misticas/customizadas podem chegar com IDs diferentes em cada
-- servidor. Estes modelos mecanicos sao reaproveitados por qualquer habilidade
-- que tenha a mesma descricao, sem depender de nome ou ID.
table.insert(APT.LinePatterns, 1, {
    "^Instantly strike the enemy, causing ([%d%.,]+)%% weapon damage plus ([%d%.,]+), total damage increased by ([%d%.,]+)%% for each of your diseases on the target%.$",
    "Golpeia o inimigo instantaneamente, causando %1%% do dano da arma mais %2. O dano total aumenta em %3%% por doenca no alvo."
})
table.insert(APT.LinePatterns, 1, {
    "^Strikes the target, dealing ([%d%.,]+)%% weapon damage plus ([%d%.,]+) as Nature damage and granting you Maelstrom Weapon if known%.$",
    "Golpeia o alvo, causando %1%% do dano da arma mais %2 de dano de Natureza e concede Arma Maelstrom, se conhecida."
})
table.insert(APT.LinePatterns, 1, {
    "^Strike twice, dealing ([%d%.,]+) Physical damage per strike%.$",
    "Ataca duas vezes, causando %1 de dano Fisico por golpe."
})
table.insert(APT.LinePatterns, 1, {
    "^Increase your chance to block and block value in ([%d%.,]+)%% during ([%d%.,]+) s%.$",
    "Aumenta sua chance e valor de bloqueio em %1%% durante %2 s."
})
table.insert(APT.LinePatterns, 1, {
    "^Increase your chance to block and block value by ([%d%.,]+)%% for ([%d%.,]+) s%.$",
    "Aumenta sua chance e valor de bloqueio em %1%% durante %2 s."
})
table.insert(APT.LinePatterns, 1, {
    "^Instantly strike the enemy, causing ([%d%.,]+)%% weapon damage as (.-) plus ([%d%.,]+), total damage increased by ([%d%.,]+)%% for each of your diseases on the target%.$",
    "Golpeia o inimigo instantaneamente, causando %1%% do dano da arma como %2 mais %3. O dano total aumenta em %4%% por doenca no alvo."
})
table.insert(APT.LinePatterns, 1, {
    "^Strikes the target, dealing ([%d%.,]+)%% weapon damage as (.-) plus ([%d%.,]+)%.$",
    "Golpeia o alvo, causando %1%% do dano da arma como %2 mais %3."
})
table.insert(APT.LinePatterns, 1, {
    "^Strikes the target, dealing ([%d%.,]+)%% weapon damage plus ([%d%.,]+) as (.-) damage%.$",
    "Golpeia o alvo, causando %1%% do dano da arma mais %2 de dano de %3."
})
table.insert(APT.LinePatterns, 1, {
    "^Strike ([%a]+) times, dealing ([%d%.,]+) (.-) damage per strike%.$",
    "Ataca %1 vezes, causando %2 de dano de %3 por golpe."
})
table.insert(APT.LinePatterns, 1, {
    "^Deals ([%d%.,]+) (.-) damage to the target%.$",
    "Causa %1 de dano de %2 ao alvo."
})
table.insert(APT.LinePatterns, 1, {
    "^Deals ([%d%.,]+)%% weapon damage to the target%.$",
    "Causa %1%% do dano da arma ao alvo."
})
table.insert(APT.LinePatterns, 1, {
    "^Grants you (.-) for ([%d%.,]+) sec%.$",
    "Concede %1 durante %2 s."
})
table.insert(APT.LinePatterns, 1, {
    "^Increases your (.-) by ([%d%.,]+)%% for ([%d%.,]+) sec%.$",
    "Aumenta seu/sua %1 em %2%% durante %3 s."
})
table.insert(APT.LinePatterns, 1, {
    "^Reduces the cooldown of (.-) by ([%d%.,]+) sec%.$",
    "Reduz a recarga de %1 em %2 s."
})
table.insert(APT.LinePatterns, 1, {
    "^Strike twice, dealing ([%d%.,]+) Physical damage per strike%.$",
    "Ataca duas vezes, causando %1 de dano Fisico por golpe."
})

local function RegisterRuntimeDescription(ids, pair)
    local pairID = #APT.DescPairs + 1
    APT.DescPairs[pairID] = pair
    for _, spellID in ipairs(ids) do
        APT.DescByID[spellID] = { pairID }
    end
end

RegisterRuntimeDescription({ 806359, 681012 }, APT.RuntimeDescriptionPairs[4])
RegisterRuntimeDescription({ 800088, 503643 }, APT.RuntimeDescriptionPairs[5])
RegisterRuntimeDescription({ 806360, 503644 }, APT.RuntimeDescriptionPairs[6])
RegisterRuntimeDescription({ 503645, 800087 }, APT.RuntimeDescriptionPairs[8])
RegisterRuntimeDescription({ 806361 }, APT.RuntimeDescriptionPairs[10])
RegisterRuntimeDescription({ 92117, 705080, 806365 }, APT.RuntimeDescriptionPairs[3])

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

local ComparisonStatLabels = {
    ["Strength"] = "força",
    ["Agility"] = "agilidade",
    ["Stamina"] = "vigor",
    ["Intellect"] = "intelecto",
    ["Spirit"] = "espírito",
    ["Armor"] = "armadura",
    ["Attack Power"] = "poder de ataque",
    ["Spell Power"] = "poder mágico",
    ["Hit Rating"] = "chance de acerto",
    ["Critical Strike Rating"] = "chance de acerto crítico",
    ["Crit Rating"] = "chance de acerto crítico",
    ["Haste Rating"] = "aceleração",
    ["Expertise Rating"] = "perícia",
    ["Resilience Rating"] = "resiliência",
    ["Defense Rating"] = "defesa",
    ["Dodge Rating"] = "esquiva",
    ["Parry Rating"] = "aparo",
    ["Block Rating"] = "bloqueio",
    ["Armor Penetration Rating"] = "penetração de armadura",
}

local function NormalizeComparisonStat(text)
    local color, sign, amount, stat, reset = text:match(
        "^(|c%x%x%x%x%x%x%x%x)([+%-])([%d%.,]+)%s+(.+)(|r)$"
    )
    if not stat then
        sign, amount, stat = text:match("^([+%-])([%d%.,]+)%s+(.+)$")
        color, reset = "", ""
    end
    local translated = stat and ComparisonStatLabels[stat]
    if not translated then return text end
    return color .. sign .. amount .. " de " .. translated .. reset
end

local function NormalizeTooltipRatingText(text)
    if type(text) ~= "string" or text == "" then return text end

    -- Alguns itens antigos são montados em partes pelo cliente. A tradução
    -- genérica podia deixar "sec for" no meio da frase enquanto o sufixo de
    -- recarga era atualizado. Normalizamos tanto a origem inglesa quanto a
    -- variante híbrida observada no tooltip de Second Wind.
    text = text:gsub(
        "^Use:%s+Restores%s+([%d%.,]+)%s+mana%s+every%s+([%d%.,]+)%s+sec%s+for%s+([%d%.,]+)%s+sec%.%s+%(([%d%.,]+)%s+Min%s+Cooldown%)%s*$",
        "Uso: Restaura %1 de mana a cada %2 s durante %3 s. (Recarga: %4 min)"
    )
    text = text:gsub(
        "^Uso:%s+Recupera%s+([%d%.,]+)%s+de%s+mana%s+a%s+cada%s+([%d%.,]+)%s+sec%s+for%s+([%d%.,]+)%s+s%.%s+%(([%d%.,]+)%s+min%s+de%s+recarga%)%s*$",
        "Uso: Restaura %1 de mana a cada %2 s durante %3 s. (Recarga: %4 min)"
    )
    text = text:gsub(
        "^Equipar:%s+Your direct damage and healing spells have a chance%-increase your haste rating by ([%d%.,]+) for ([%d%.,]+) sec%.%s+%(([%d%.,]+) sec cd%)%s*$",
        "Equipar: Seus feitiços de dano direto e cura têm chance de aumentar sua aceleração em %1 durante %2 s. (Recarga: %3 s)"
    )
    text = text:gsub(
        "^Equipar:%s+Your direct damage and healing spells have a chance to increase your haste rating by ([%d%.,]+) for ([%d%.,]+) sec%.%s+%(([%d%.,]+) sec cd%)%s*$",
        "Equipar: Seus feitiços de dano direto e cura têm chance de aumentar sua aceleração em %1 durante %2 s. (Recarga: %3 s)"
    )

    -- A tabela legada de atributos veio parcialmente do espanhol e gerava
    -- frases como "Mejora tu índice de celeridad". Corrigimos as variantes
    -- aqui, depois que o tooltip foi montado, preservando os valores do item.
    local itemStatCorrections = {
        { "^Equipar:%s+Mejora tu índice de golpe crítico corpo a corpo ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto crítico corpo a corpo em %1 p." },
        { "^Equipar:%s+Mejora tu índice de golpe crítico a distancia ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto crítico à distância em %1 p." },
        { "^Equipar:%s+Mejora tu índice de golpe crítico ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto crítico em %1 p." },
        { "^Equipar:%s+Melhore seu índice de golpe crítico com feitiços ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto crítico com feitiços em %1 p." },
        { "^Equipar:%s+Mejora tu índice de celeridad corpo a corpo ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua aceleração corpo a corpo em %1 p." },
        { "^Equipar:%s+Mejora tu índice de celeridad a distancia ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua aceleração à distância em %1 p." },
        { "^Equipar:%s+Mejora tu índice de celeridad ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua aceleração em %1 p." },
        { "^Equipar:%s+Melhore seu índice de celeridade com feitiços ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua aceleração de feitiços em %1 p." },
        { "^Equipar:%s+Mejora tu índice de golpe corpo a corpo ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto corpo a corpo em %1 p." },
        { "^Equipar:%s+Mejora tu índice de golpe a distancia ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto à distância em %1 p." },
        { "^Equipar:%s+Mejora tu índice de golpe ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto em %1 p." },
        { "^Equipar:%s+Melhore seu índice de golpe com feitiços ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto com feitiços em %1 p." },
        { "^Equipar:%s+Mejora tu índice de temple ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua resiliência em %1 p." },
        { "^Equipar:%s+Mejora tu bônus de golpe crítico ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua chance de acerto crítico em %1 p." },
        { "^Equipar:%s+Mejora tu bônus de celeridad ([%d%.,]+) p%.$",
          "Equipar: Aumenta sua aceleração em %1 p." },
        { "^Equipar:%s+Aumenta o poder com feitiços ([%d%.,]+) p%.$",
          "Equipar: Aumenta seu poder mágico em %1 p." },
        { "^Equipar:%s+Aumenta em ([%d%.,]+) o seu Poder PvE%.$",
          "Equipar: Aumenta seu Poder PvE em %1." },
    }
    for _, correction in ipairs(itemStatCorrections) do
        text = text:gsub(correction[1], correction[2])
    end
    text = NormalizeComparisonStat(text)

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
APT.UIStrings = APT.UIStrings or {}

-- Tooltip do relógio. O texto original era longo demais para a caixa compacta
-- do minimapa. Corrigimos tanto as constantes usadas pelo cliente quanto as
-- frases que podem chegar aos hooks de tradução, evitando texto cortado ou
-- alternância entre versões.
local ClockTooltipLabels = {
    TIMEMANAGER_TOOLTIP_TITLE = "Relógio",
    TIMEMANAGER_TOOLTIP_REALMTIME = "Reino:",
    TIMEMANAGER_TOOLTIP_LOCALTIME = "Local:",
    GAMETIME_TOOLTIP_TOGGLE_CLOCK = "Clique para configurar.",
}
for key, translated in pairs(ClockTooltipLabels) do
    APT.UIStrings[key] = translated
end

local ClockTooltipAliases = {
    ["Time Info"] = "Relógio",
    ["Informação hora"] = "Relógio",
    ["Realm time:"] = "Reino:",
    ["Hora do reino:"] = "Reino:",
    ["Local time:"] = "Local:",
    ["Hora local:"] = "Local:",
    ["Click to show clock settings."] = "Clique para configurar.",
    ["Clique para mostrar a configuração do relógio."] = "Clique para configurar.",
}
for source, translated in pairs(ClockTooltipAliases) do
    APT.CustomUI[source] = translated
    APT.UIStringsByEN[source] = translated
end

-- Dicas de acerto do painel de personagem. O servidor monta estas frases com
-- nível e porcentagens em tempo real, então usamos padrões em vez de valores
-- fixos. As versões PT-BR são deliberadamente compactas para a caixa estreita.
APT.CustomUI["Off-Hand Hit"] = "Acerto (mão secundária)"
APT.UIStringsByEN["Off-Hand Hit"] = "Acerto (mão secundária)"

local CharacterHitTooltipPatterns = {
    {
        "^Off%-Hand Hit ([%d%.,]+)$",
        "Acerto (mão secundária): %1",
    },
    {
        "^Increases your melee off%-hand chance to hit a target of level (%d+) by ([%d%.,]+)%% %(%+([%d%.,]+)%%%)%.$",
        "Contra alvo de nível %1: +%2%% de acerto com a mão secundária (+%3%%).",
    },
    {
        "^([%d%.,]+)%% chance to hit is required to never miss a raid boss with your off%-hand weapon%.$",
        "Chefe de raide: %1%% de acerto para não errar.",
    },
    {
        "^([%d%.,]+)%% chance to hit is required to never miss a player with your off%-hand weapon%.$",
        "Jogador: %1%% de acerto para não errar.",
    },
    {
        "^This is only for off%-hand auto attacks%. Your normal hit rating is used for abilities%.$",
        "Só afeta ataques automáticos da mão secundária. Habilidades usam o acerto normal.",
    },
}
for _, pattern in ipairs(CharacterHitTooltipPatterns) do
    table.insert(APT.LinePatterns, 1, pattern)
end

-- Menu de tipos de chat. Estas constantes são usadas diretamente pelo
-- cliente ao abrir a lista ao lado da caixa de texto; por isso corrigimos a
-- fonte e também as variantes antigas que possam já estar visíveis na tela.
local ChatMenuLabels = {
    SAY_MESSAGE = "Dizer",
    PARTY_MESSAGE = "Grupo",
    RAID = "Raide",
    BATTLEGROUND = "C. de Batalha",
    BATTLEGROUND_LEADER = "Líder do Campo de Batalha",
    GUILD_CHAT = "Guilda",
    YELL_MESSAGE = "Gritar",
    WHISPER = "Sussurrar",
    EMOTE = "Emote",
    REPLY_MESSAGE = "Responder",
    LANGUAGE = "Idioma",
    VOICEMACRO_LABEL = "Emote de voz",
}
for key, translated in pairs(ChatMenuLabels) do
    APT.UIStrings[key] = translated
end

local ChatMenuAliases = {
    ["Say"] = "Dizer",
    ["Party Chat"] = "Grupo",
    ["Chat Grupo"] = "Grupo",
    ["Raid"] = "Raide",
    ["Battleground"] = "C. de Batalha",
    ["Campo de Batalha"] = "C. de Batalha",
    ["Battleground Leader"] = "Líder do Campo de Batalha",
    ["Líder de batalha"] = "Líder do Campo de Batalha",
    ["Guild Chat"] = "Guilda",
    ["Bate-papo da guilda"] = "Guilda",
    ["Yell"] = "Gritar",
    ["Whisper"] = "Sussurrar",
    ["Emote"] = "Emote",
    ["Emoção"] = "Emote",
    ["Reply"] = "Responder",
    ["Language"] = "Idioma",
    ["Língua"] = "Idioma",
    ["Voice Emote"] = "Emote de voz",
    ["Emosonido"] = "Emote de voz",
}
for source, translated in pairs(ChatMenuAliases) do
    APT.CustomUI[source] = translated
    APT.UIStringsByEN[source] = translated
end

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

-- Revisão de habilidades identificadas pela auditoria automática. Mantemos os
-- nomes próprios em inglês e corrigimos apenas as descrições exibidas.
local function OverridePairTranslations(target, indexes, translated)
    for _, index in ipairs(indexes) do
        if target[index] then target[index][2] = translated end
    end
end

OverridePairTranslations(APT.DescPairs, { 59291, 69735 },
    "Seus feitiços de dano direto e cura têm chance de aumentar sua aceleração em {{1}} durante {{2}}. (Recarga: 45 s)")

OverridePairTranslations(APT.DescPairs, { 5437, 64376 },
    "Faz |cffffffffGlyphic Ruin|r causar {{1}}% a mais de dano crítico e conceder |cffffffffCosmic Impact|r durante {{2}}.")

OverridePairTranslations(APT.DescPairs, { 50761, 80372 },
    "Golpeia com sua arma em arco, causando {{1}} de dano a todos os alvos até 8 metros à sua frente. Requer maças.")

OverridePairTranslations(APT.DescPairs, { 33779, 72909 },
    "Causar dano com Thrash e Lacerate tem chance de conceder |cFFFFFFFFUrsine Frenzy|r.")
OverridePairTranslations(APT.DescPairs, { 33780, 72910 },
    "Causar dano com Thrash e Lacerate tem {{1}}% de chance de conceder |cFFFFFFFFUrsine Frenzy|r.")

OverridePairTranslations(APT.DescPairs, { 18174, 67112 },
    "Ativar esta aura restaura {{1}} de mana a todos os membros próximos do grupo a cada segundo durante {{2}}. O valor aumenta com o nível.")
OverridePairTranslations(APT.DescPairs, { 18175, 67113 },
    "Ativar esta aura restaura {{1}} de mana a todos os membros próximos do grupo a cada 2 segundos durante {{2}}. O valor aumenta com o nível.")

local lethalBarragePT = "Seu próximo Aimed Shot, Kill Shot ou Arcane Shot causa {{1}}% a mais de dano e ricocheteia em {{2}} inimigos próximos, perdendo força a cada alvo atingido. Dura {{3}}.\n\nDepois de consumir Trick Shots, os acertos de Aimed Shot, Kill Shot e Arcane Shot aumentam, durante 8 segundos, o dano do seu próximo Multi-Shot."
OverridePairTranslations(APT.DescPairs, { 34722, 73395 }, lethalBarragePT)

local giganticTail = " causa 2% a mais de dano e tem chance de conceder |cFFFFFFFFGigantic Power|r durante 8 segundos.\n\nCada encantamento adicional aumenta em 100% a potência do bônus concedido."
for _, correction in ipairs({
    { { 46223, 78448 }, "Quando usada contra alvos com mais de 75% de vida, Hammer of the Righteous" },
    { { 46224, 78449 }, "Quando usada contra alvos com mais de 75% de vida, Lava Lash" },
    { { 46225, 78450 }, "Quando usada contra alvos com mais de 75% de vida, Envenom" },
    { { 46226, 78451 }, "Quando usada contra alvos com mais de 75% de vida, Glaive Toss" },
    { { 46558, 78781 }, "Quando usada contra alvos com mais de 75% de vida, Mangle" },
}) do
    OverridePairTranslations(APT.DescPairs, correction[1], correction[2] .. giganticTail)
end

OverridePairTranslations(APT.TipPairs, { 7664 },
    "Dano aumentado em {{1}}%. Regenera {{2}} de mana e {{3}} de vida a cada {{4}} segundos durante {{5}}.")
OverridePairTranslations(APT.TipPairs, { 11958, 19739 },
    "Suas habilidades e feitiços de dano não periódico têm chance de atingir a área do alvo com um raio, causando dano de Natureza e deixando uma área eletrificada. A área reduz em 25% a velocidade dos inimigos e causa dano a cada segundo durante 4 segundos.")
OverridePairTranslations(APT.TipPairs, { 19148 },
    "Aumenta sua chance de esquiva em 25%. Ao usar Chi Palm com mais de 50% de raiva, consome 25 de raiva; com menos de 50%, concede 25 de raiva. Aumenta sua velocidade de movimento em 10% e cura {{1}} a cada 5 segundos. Apenas um Fighting Style pode ficar ativo por vez, e não é possível trocá-lo durante o combate.")
OverridePairTranslations(APT.TipPairs, { 16415 },
    "Fortalece você com a essência da Revoada Dragônica Bronze. Seus ataques têm chance de criar uma tempestade de areia que causa dano de Natureza e reduz a velocidade dos inimigos próximos a cada segundo durante 6 segundos.")
OverridePairTranslations(APT.TipPairs, { 16078 },
    "Curar um alvo tem chance de conceder Blessing of the River, restaurando {{1}} de mana a cada 5 segundos durante {{2}}.")
OverridePairTranslations(APT.TipPairs, { 13991 },
    "\nPreenche o paladino com o espírito da justiça durante {{1}}, fazendo cada ataque corpo a corpo ter chance de atordoar por {{2}}. Este efeito tem recarga de 10 segundos. Apenas um Seal pode ficar ativo por vez.\n\nLiberar a energia deste Seal causa {{3}} de dano Sagrado a um inimigo.")
OverridePairTranslations(APT.TipPairs, { 13992 },
    "\nPreenche você com luz divina durante {{1}}, fazendo cada ataque automático corpo a corpo ter chance de curar {{2}}. Este efeito só pode ocorrer uma vez a cada 2 segundos. Apenas um Seal pode ficar ativo por vez.\n\nLiberar a energia deste Seal causa {{3}} de dano Sagrado a um inimigo.")

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

-- Descrição atual da habilidade Melt Reality. O servidor usa os valores da
-- habilidade em tempo real, então preservamos números e duração por capturas.
table.insert(APT.LinePatterns, 1, {
    "^Melt the target's reality, dealing ([%d%.,]+) Chromatic Damage over ([%d%.,]+) sec%.%s*While active, periodic damage dealt to the target is replicated for ([%d%.,]+)%% of the value to all enemies near them%.%s*$",
    "Derrete a realidade do alvo, causando %1 de dano cromático ao longo de %2 s.\n\nEnquanto estiver ativo, o dano periódico causado ao alvo é replicado em %3%% do valor para todos os inimigos próximos."
})
table.insert(APT.LinePatterns, 1, { "^Range (%d+)/(%d+)$", "Alcance %1/%2" })
table.insert(APT.LinePatterns, 1, {
    "^Use:%s+Restores%s+([%d%.,]+)%s+mana%s+every%s+([%d%.,]+)%s+sec%s+for%s+([%d%.,]+)%s+sec%.%s+%(([%d%.,]+)%s+Min%s+Cooldown%)%s*$",
    "Uso: Restaura %1 de mana a cada %2 s durante %3 s. (Recarga: %4 min)"
})

-- Mantém a mesma tradução nos caminhos de interface estática e dinâmica.
APT.CustomUI["Disenchant"] = "Desencantar"
APT.UIStringsByEN["Disenchant"] = "Desencantar"

-- Textos de navegacao do Avanco de Personagem aparecem em tooltips estreitos.
-- Estas versoes curtas evitam cortar linhas ou ultrapassar a caixa.
if APT.ServerUI then
    APT.ServerUI["Abilities, Spells, and Talents to enhance your character."] =
        "Feiticos e talentos\npara seu personagem."
    APT.ServerUI["Load a ready to play Archetype build, check out popular community builds, or create and share your own build!"] =
        "Use composicoes prontas,\nda comunidade ou crie a sua."
    APT.ServerUI["Unwrap packs of cards to add to your skill card collection discover new skill cards giving you the ability to steer fate."] =
        "Abra pacotes, obtenha Cartas\nde Pericia e crie seu destino."
    APT.ServerUI["Deliver items from the Ascension store directly to your inventory anywhere, anytime."] =
        "Itens da loja direto\nno inventario, onde estiver."
    APT.ServerUI["Manage your current outfit and transmogrification collection. View all sets and appearances available."] =
        "Gerencie roupas e transmog.\nVeja conjuntos e aparencias."

    -- Rotulos de recurso: a forma longa extrapola o painel pequeno.
    APT.ServerUI["ABILITY ESSENCE"] = "ESSENCIA"
    APT.ServerUI["Ability Essence"] = "Essencia"
    APT.ServerUI["Ability Essence: 0"] = "Essencia: 0"
    APT.ServerUI["Talent Essence"] = "Talento"
    APT.ServerUI["Talent Essence: 0"] = "Talento: 0"
end

-- Abas compactas do painel de Cartas de Perícia. Além das chaves inglesas,
-- os aliases corrigem textos que já tenham sido localizados pela base antes
-- de este módulo ser carregado.
local SkillCardTabLabels = {
    ["Starter Skill Cards"] = "Cartas Perícia Iniciais",
    ["Ability Cards"] = "Cartas Habilidade",
    ["Talent Cards"] = "Cartas Talento",
    ["Card Packs and Cards"] = "Pacotes Cartas",
}
local SkillCardTabAliases = {
    ["Cartas de Perícia iniciais"] = "Cartas Perícia Iniciais",
    ["Cartas de Perícia Iniciais"] = "Cartas Perícia Iniciais",
    ["Cartas de Habilidade"] = "Cartas Habilidade",
    ["Cartas de Talento"] = "Cartas Talento",
    ["Pacotes de cartas e cartões"] = "Pacotes Cartas",
}
for source, translated in pairs(SkillCardTabLabels) do
    APT.ServerUI[source] = translated
    APT.CustomUI[source] = translated
    APT.UIStringsByEN[source] = translated
    APT.TalentUIExact[source] = translated
end
for source, translated in pairs(SkillCardTabAliases) do
    APT.CustomUI[source] = translated
    APT.UIStringsByEN[source] = translated
    APT.TalentUIExact[source] = translated
end

local startingCardsFinalizedEN = "Starting abilities finalized: skill cards can no longer be slotted."
local startingCardsFinalizedPT = "Habilidades iniciais definidas: não é mais possível equipar Cartas Perícia."
APT.ServerUI[startingCardsFinalizedEN] = startingCardsFinalizedPT
APT.CustomUI[startingCardsFinalizedEN] = startingCardsFinalizedPT
APT.UIStringsByEN[startingCardsFinalizedEN] = startingCardsFinalizedPT
APT.TalentUIExact[startingCardsFinalizedEN] = startingCardsFinalizedPT
APT.ChatExact[startingCardsFinalizedEN] = startingCardsFinalizedPT
APT.ErrExact[startingCardsFinalizedEN] = startingCardsFinalizedPT

-- Descricoes customizadas enviadas pelo servidor. Sao aplicadas somente ao
-- texto de um tooltip ja aberto; nao existe varredura global nem trabalho por
-- quadro. Os nomes das habilidades ficam em ingles, como no cliente original.
APT.CustomDescriptionPatterns = APT.CustomDescriptionPatterns or {}
local CustomDescriptionPatterns = APT.CustomDescriptionPatterns
local function AddCustomDescriptionPattern(en, pt)
    CustomDescriptionPatterns[#CustomDescriptionPatterns + 1] = { en, pt }
end

-- Familia Seer / Shaman.
AddCustomDescriptionPattern(
    "Dealing damage with Lightning Bolt and Chain Lightning grants a charge of the Seer%.",
    "Causar dano com Lightning Bolt e Chain Lightning concede 1 carga de Seer.")
AddCustomDescriptionPattern(
    "Increases the damage of the next Arcane Missiles projectile by ([%d%.,]+)%%%. Holds up to ([%d%.,]+) charges%. Lasts ([%d%.,]+) sec%.",
    "Aumenta em %1%% o dano do proximo projetil de Arcane Missiles. Maximo: %2 cargas. Dura %3 s.")
AddCustomDescriptionPattern(
    "Increases the critical effect chance of your Shaman healing spells, Lightning Bolt and Chain Lightning by ([%d%.,]+)%% and reduces the cooldown of your Tidal Force by ([%d%.,]+) seconds%.",
    "Aumenta em %1%% a chance critica das curas de Shaman, Lightning Bolt e Chain Lightning. Reduz Tidal Force em %2 s.")
AddCustomDescriptionPattern(
    "Capstone Bonus: Healing Wave and Riptide direct criticals add ([%d%.,]+) seconds%. Lesser Healing Wave ([%d%.,]+) second and Chain Heal criticals ([%d%.,]+) sec to the duration of Tidal Force%.",
    "Bonus: criticos de Healing Wave e Riptide: +%1 s; Lesser Healing Wave: +%2 s; Chain Heal: +%3 s a Tidal Force.")

-- Familia Priest / cura direta.
AddCustomDescriptionPattern(
    "Casting Power Word: Shield on an ally below ([%d%.,]+)%% health also removes any Crowd Control effects on them%.",
    "Power Word: Shield em aliado abaixo de %1%% de vida tambem remove efeitos de controle.")
AddCustomDescriptionPattern(
    "Reduces your target's Physical damage taken by ([%d%.,]+)%% for ([%d%.,]+) sec after getting a critical effect from one of your direct healing spells%.",
    "Reduz em %1%% o dano Fisico recebido pelo alvo por %2 s apos um critico de cura direta.")
AddCustomDescriptionPattern(
    "Reduces your target's Physical damage taken by ([%d%.,]+)%% for ([%d%.,]+) sec after getting a critical effect from one of your healing spells%.",
    "Reduz em %1%% o dano Fisico recebido pelo alvo por %2 s apos um critico de cura.")
AddCustomDescriptionPattern(
    "Increases chance to block by ([%d%.,]+)%% for ([%d%.,]+) sec%. Each block expends a charge and deals ([%d%.,]+) holy damage to the attacker%.",
    "Aumenta em %1%% a chance de bloqueio por %2 s. Cada bloqueio consome 1 carga e causa %3 de dano Sagrado ao atacante.")

-- Formas frequentes das descricoes customizadas de combate. Mantem nomes de
-- magias, talentos e efeitos em ingles e traduz somente a explicacao.
AddCustomDescriptionPattern(
    "Instantly strike the enemy, causing ([%d%.,]+)%% weapon damage as ([%a%s]+) plus ([%d%.,]+), total damage increased by ([%d%.,]+)%% for each of your diseases on the target%.",
    "Golpeia o inimigo, causando %1%% do dano da arma como %2 + %3. O dano total aumenta em %4%% para cada doenca sua no alvo.")
AddCustomDescriptionPattern(
    "Instantly strike the enemy, causing ([%d%.,]+)%% weapon damage plus ([%d%.,]+), total damage increased by ([%d%.,]+)%% for each of your diseases on the target%.",
    "Golpeia o inimigo, causando %1%% do dano da arma + %2. O dano total aumenta em %3%% para cada doenca sua no alvo.")
AddCustomDescriptionPattern(
    "Strikes the target, dealing ([%d%.,]+)%% weapon damage plus ([%d%.,]+) as ([%a%s]+) damage and granting you ([%a%s]+) if known%.",
    "Atinge o alvo, causando %1%% do dano da arma + %2 de dano de %3 e concede %4, se conhecido.")
AddCustomDescriptionPattern(
    "Strike twice, dealing ([%d%.,]+) Physical damage per strike%.",
    "Ataca 2 vezes, causando %1 de dano Fisico por golpe.")

-- Sap e variantes entre servidores. A descrição pode chegar em um único
-- FontString ou dividida em várias linhas visuais; por isso mantemos uma regra
-- integral e regras independentes. O título "Sap" nunca é alterado.
AddCustomDescriptionPattern(
    "Incapacitates the target for up to ([%d%.,]+) sec %(([%d%.,]+) seconds on players%)%.%s+Must be stealthed%.%s+Only works on Humanoids that are not in combat%.%s+Any damage caused will revive the target%.%s+Only 1 target may be sapped at a time%.",
    "Incapacita o alvo por até %1 s (%2 s contra jogadores). Requer Furtividade. Funciona apenas contra Humanoides fora de combate. Qualquer dano desperta o alvo. Apenas um alvo pode ser afetado por vez.")

local SapDescriptionLines = {
    { "^Requires Stealth$", "Requer Furtividade" },
    { "^Requer Stealth$", "Requer Furtividade" },
    { "^Must be stealthed%.$", "Requer Furtividade." },
    { "^Incapacitates the target for up to ([%d%.,]+) sec %(([%d%.,]+) seconds on players%)%.$",
      "Incapacita o alvo por até %1 s (%2 s contra jogadores)." },
    { "^Only works on Humanoids that are not in combat%.$",
      "Funciona apenas contra Humanoides fora de combate." },
    { "^Any damage caused will revive the target%.$",
      "Qualquer dano desperta o alvo." },
    { "^Only 1 target may be sapped at a time%.$",
      "Apenas um alvo pode ser afetado por vez." },
}
for _, pattern in ipairs(SapDescriptionLines) do
    table.insert(APT.LinePatterns, 1, pattern)
end

-- Lote obtido do registro de descrições desconhecidas do próprio jogador.
-- São frases mecânicas independentes do ID e do nome da habilidade, portanto
-- também cobrem cópias customizadas e graus diferentes em outros servidores.
AddCustomDescriptionPattern(
    "The caster is surrounded by ([%d%.,]+) globes of water, granting ([%d%.,]+) mana per ([%d%.,]+) sec%. When a spell, melee or ranged attack hits the caster, ([%d%.,]+) mana is restored to the caster%. This expends one water globe%. Only one globe will activate every few seconds%. Lasts ([%d%.,]+) min%.",
    "O conjurador é cercado por %1 globos de água e recebe %2 de mana a cada %3 s. Quando um feitiço ou ataque corpo a corpo ou à distância o atinge, restaura %4 de mana e consome um globo. Apenas um globo pode ser ativado a cada poucos segundos. Dura %5 min.")
AddCustomDescriptionPattern(
    "Strike with both weapons, dealing weapon damage per combo point%.",
    "Ataca com as duas armas, causando dano com base nos pontos de combo:")
AddCustomDescriptionPattern(
    "([ ]*)([%d]+) point[s]?%s*: ([%d%.,]+)%% combined weapon damage",
    "%1%2 ponto: %3%% do dano combinado das armas")
AddCustomDescriptionPattern(
    "A steady shot charged with arcane force that causes ([%d%.,]+)%% weapon damage as Spellstrike damage and deals ([%d%.,]+) additional Spellstrike damage%. Causes an additional ([%d%.,]+) Spellstrike damage to slowed targets%.",
    "Um disparo carregado com força arcana que causa %1%% do dano da arma como dano de Spellstrike mais %2 de dano adicional. Causa mais %3 de dano de Spellstrike contra alvos desacelerados.")
AddCustomDescriptionPattern(
    "A steady shot that causes ([%d%.,]+)%% weapon damage plus ([%d%.,]+)%. Causes an additional ([%d%.,]+) to slowed targets%.",
    "Um disparo firme que causa %1%% do dano da arma mais %2. Causa %3 de dano adicional contra alvos desacelerados.")
AddCustomDescriptionPattern(
    "The hunter takes on the aspects of a monkey, increasing chance to dodge by ([%d%.,]+)%%%.",
    "O caçador assume os aspectos de um macaco, aumentando em %1%% a chance de esquiva.")
AddCustomDescriptionPattern(
    "The caster shouts, causing up to ([%d%.,]+) enemies within ([%d%.,]+) yards to cower in fear for ([%d%.,]+) seconds%. The targeted enemy will be unable to move while cowering%.",
    "O conjurador grita, fazendo até %1 inimigos em um raio de %2 m recuarem de medo por %3 s. O inimigo selecionado não pode se mover enquanto estiver amedrontado.")
AddCustomDescriptionPattern(
    "Instantly shocks the target with concussive force, dealing ([%d%.,]+) Physical damage%.",
    "Atinge instantaneamente o alvo com força concussiva, causando %1 de dano Físico.")
AddCustomDescriptionPattern(
    "Unleash frostfire that deals ([%d%.,]+) Frostfire damage and an additional ([%d%.,]+) Frostfire damage over ([%d%.,]+) seconds%.",
    "Libera fogo gélido que causa %1 de dano de Frostfire e mais %2 ao longo de %3 s.")
AddCustomDescriptionPattern(
    "Channel rapid Arcane Explosions in the area, dealing ([%d%.,]+) Arcane damage every ([%d%.,]+) sec%. Damage increases by ([%d%.,]+)%% each tick%.",
    "Canaliza explosões Arcanas rápidas na área, causando %1 de dano Arcano a cada %2 s. O dano aumenta em %3%% a cada pulso.")
AddCustomDescriptionPattern(
    "Casting damaging spells increases the channel duration by ([%d%.,]+) sec, up to ([%d%.,]+) sec%.",
    "Lançar feitiços de dano aumenta a duração da canalização em %1 s, até o máximo de %2 s.")
AddCustomDescriptionPattern(
    "You charge your off%-hand weapon with lava, instantly dealing ([%d%.,]+)%% off%-hand Weapon damage as Firestrike damage%.",
    "Carrega sua arma da mão secundária com lava e causa instantaneamente %1%% do dano dela como dano de Firestrike.")
AddCustomDescriptionPattern(
    "The damage increased by ([%d%.,]+)%% if your off%-hand weapon is enchanted with Flametongue%.",
    "O dano aumenta em %1%% se a arma da mão secundária estiver encantada com Flametongue.")
AddCustomDescriptionPattern(
    "Quickly unleash ([%d%.,]+) ranged attacks at your target and then fling yourself back a great distance, dealing ([%d%.,]+)%% Ranged Weapon Damage%.",
    "Dispara rapidamente %1 ataques à distância contra o alvo e salta para trás, causando %2%% do dano da arma de longo alcance.")
AddCustomDescriptionPattern(
    "Your Judgement spells now also increases the critical strike chance of all spells and attacks made against that target by ([%d%.,]+)%%%.",
    "Seus feitiços Judgement também aumentam em %1%% a chance de acerto crítico de todos os feitiços e ataques contra o alvo.")
AddCustomDescriptionPattern(
    "Stings the target, reducing chance to hit with melee and ranged attacks by ([%d%.,]+)%% for ([%d%.,]+) sec%. Only one Sting per Hunter can be active on any one target%.",
    "Ferroa o alvo, reduzindo em %1%% a chance de acerto dos ataques corpo a corpo e à distância por %2 s. Apenas um Sting de cada Hunter pode permanecer ativo no mesmo alvo.")
AddCustomDescriptionPattern(
    "While Aspect of the Hawk is active, all Ranged or Melee abilities have a ([%d%.,]+)%% chance of increasing ranged attack speed by ([%d%.,]+)%% for ([%d%.,]+) sec%.",
    "Enquanto Aspect of the Hawk estiver ativo, habilidades corpo a corpo ou à distância têm %1%% de chance de aumentar em %2%% a velocidade dos ataques à distância por %3 s.")
AddCustomDescriptionPattern(
    "Increases the critical strike chance of your Icy Touch and Obliterate by ([%d%.,]+)%%%.",
    "Aumenta em %1%% a chance de acerto crítico de Icy Touch e Obliterate.")
AddCustomDescriptionPattern(
    "Casting Obliterate has a ([%d%.,]+)%% chance to reset the cooldown on Howling Blast and cause your next Howling Blast to consume no runes%.",
    "Lançar Obliterate tem %1%% de chance de reiniciar a recarga de Howling Blast e fazer o próximo Howling Blast não consumir runas.")
AddCustomDescriptionPattern(
    "Path of Agility focuses on dealing rapid attacks and critical strikes, and is especially beneficial for Leather and Mail armor users or those who use Agility%.",
    "Path of Agility favorece ataques rápidos e acertos críticos, sendo especialmente útil para usuários de armaduras de Couro ou Malha e para quem utiliza Agilidade.")
AddCustomDescriptionPattern(
    "Visit a Trainer or Book of Ascension to level up your spells!",
    "Visite um treinador ou um Book of Ascension para aumentar o grau dos seus feitiços!")

-- Familias adicionais identificadas pela auditoria das descricoes realmente
-- exibidas. As regras preservam nomes proprios e valores dinamicos.
AddCustomDescriptionPattern(
    "Resting%.%.%. Once this buff expires, you will gain a buff that increases all experience gained from killing monsters by ([%d%.,]+)%% for ([%d%.,]+) hrs?%.",
    "Descansando... Quando este efeito terminar, você receberá um bônus que aumenta em %1%% a experiência obtida ao derrotar monstros por %2 h.")
AddCustomDescriptionPattern(
    "Grants you and your tethered elemental an effect based on its active element%.",
    "Concede a você e ao elemental vinculado um efeito baseado no elemento ativo dele.")
AddCustomDescriptionPattern(
    "([ ]*)([%d]+) point[s]?%s*: ([%d%.,]+) seconds",
    "%1%2 ponto: %3 s")
AddCustomDescriptionPattern(
    "Your direct damaging attacks have a chance %(greater than previous rank%) of allowing the use of Execute regardless of the target's health state%.",
    "Seus ataques de dano direto têm chance, maior que no grau anterior, de permitir o uso de Execute independentemente da vida do alvo.")
AddCustomDescriptionPattern(
    "When Wraith ends or is dispelled, it heals you for ([%d%.,]+)%% of the direct damage done%.",
    "Quando Wraith termina ou é dissipado, cura você em %1%% do dano direto causado.")
AddCustomDescriptionPattern(
    "Transform into a lich for ([%d%.,]+) sec, increasing Frost damage you deal by ([%d%.,]+)%%%.",
    "Transforma você em um lich por %1 s e aumenta em %2%% o dano de Gelo causado.")
AddCustomDescriptionPattern(
    "Gera ([%d%.,]+) rage, and then generates an additional ([%d%.,]+) rage over ([%d%.,]+) sec, but reduces base armor by ([%d%.,]+)%% in Bear Form and ([%d%.,]+)%% in Dire Bear Form%.",
    "Gera %1 de raiva e mais %2 ao longo de %3 s, mas reduz a armadura-base em %4%% em Bear Form e em %5%% em Dire Bear Form.")
AddCustomDescriptionPattern(
    "This occurs more often than Furious Attacks %(Rank ([%d%.,]+)%)%.",
    "Isso ocorre com mais frequência do que em Furious Attacks (Grau %1).")
AddCustomDescriptionPattern(
    "Impale the target with a Javelin, dealing ([%d%.,]+)%% armor%-piercing weapon damage%.",
    "Empala o alvo com uma Javelin, causando %1%% do dano da arma e ignorando armadura.")
AddCustomDescriptionPattern(
    "Use your full strength to slam the target with your weapon, dealing ([%d%.,]+)%% weapon damage to up to ([%d%.,]+) nearby enemies in a conal attack%.",
    "Golpeia com força total, causando %1%% do dano da arma a até %2 inimigos próximos em uma área cônica.")
AddCustomDescriptionPattern(
    "A strong attack that increases melee damage by ([%d%.,]+) as Spellstrike damage%.",
    "Um ataque poderoso que acrescenta %1 de dano de Spellstrike ao dano corpo a corpo.")
AddCustomDescriptionPattern(
    "Your block stops ([%d%.,]+) damage%.",
    "Seu bloqueio impede %1 de dano.")
AddCustomDescriptionPattern(
    "Pounce, stunning the target for ([%d%.,]+) sec and causing ([%d%.,]+) damage over ([%d%.,]+) sec%. Must be prowling%. Awards ([%d%.,]+) combo point%.",
    "Salta sobre o alvo, atordoando-o por %1 s e causando %2 de dano ao longo de %3 s. Requer Prowl. Concede %4 ponto de combo.")
AddCustomDescriptionPattern(
    "A short%-range shot that deals ([%d%.,]+)%% weapon damage and disorients the target for ([%d%.,]+) sec%.%s+Any damage caused except for Piercing Shots and Serpent Sting will remove the effect%. Turns off your attack when used%.",
    "Um disparo de curto alcance que causa %1%% do dano da arma e desorienta o alvo por %2 s. Qualquer dano, exceto o de Piercing Shots e Serpent Sting, remove o efeito. Interrompe seu ataque ao ser usado.")
AddCustomDescriptionPattern(
    "Finishing move that consumes combo points on your target to restore ([%d%.,]+)%% of your maximum health every ([%d%.,]+) sec%. Lasts longer per combo point:",
    "Finalização que consome os pontos de combo no alvo para restaurar %1%% da sua vida máxima a cada %2 s. Dura mais conforme os pontos de combo:")
AddCustomDescriptionPattern(
    "Finishing move that reduces healing done to that target by ([%d%.,]+)%% for ([%d%.,]+) seconds and deals ranged weapon damage:",
    "Finalização que reduz em %1%% a cura recebida pelo alvo por %2 s e causa dano da arma de longo alcance:")
AddCustomDescriptionPattern(
    "Finishing move that haunts your target, dealing damage and increasing the damage of your Physical damage%-over%-time effects against it%.",
    "Finalização que assombra o alvo, causa dano e aumenta o dano dos seus efeitos periódicos de dano Físico contra ele.")
AddCustomDescriptionPattern(
    "Combo Shot harnesses the damage dealt by your Compound Shot to pierce through enemies causing them to bleed over ([%d%.,]+) seconds%.",
    "Combo Shot aproveita o dano de Compound Shot para atravessar inimigos e fazê-los sangrar ao longo de %1 s.")
AddCustomDescriptionPattern(
    "If the target is a player, it also knocks them back%. Enemies the target collides with are knocked back slightly and take ([%d%.,]+)%% weapon damage%.",
    "Se o alvo for um jogador, também o repele. Inimigos atingidos por ele são levemente repelidos e recebem %1%% do dano da arma.")
AddCustomDescriptionPattern(
    "Increases the amount of armor increased by your Stoneskin Totem by ([%d%.,]+)%%%.",
    "Aumenta em %1%% a armadura concedida por Stoneskin Totem.")
AddCustomDescriptionPattern(
    "Reduces your energy generation by ([%d%.,]+)%%%.",
    "Reduz em %1%% sua geração de energia.")
AddCustomDescriptionPattern(
    "Increases damage with melee weapons by ([%d%.,]+) damage per second%.",
    "Aumenta em %1 o dano por segundo das armas corpo a corpo.")
AddCustomDescriptionPattern(
    "Increases Dodge Chance by ([%d%.,]+)%%",
    "Aumenta em %1%% a chance de esquiva")
AddCustomDescriptionPattern(
    "Increases Mana Regeneration by ([%d%.,]+) Per ([%d%.,]+) Seconds while not casting",
    "Aumenta em %1 a regeneração de mana a cada %2 s enquanto não estiver lançando feitiços")
AddCustomDescriptionPattern(
    "Increases Health Regeneration by ([%d%.,]+) Per Second while not in combat",
    "Aumenta em %1 por segundo a regeneração de vida fora de combate")
AddCustomDescriptionPattern(
    "This has a ([%d%.,]+) minute cooldown%.",
    "Possui recarga de %1 min.")
AddCustomDescriptionPattern(
    "Throw the bottle to the ground and shatter it into pieces%.",
    "Jogue a garrafa no chão para quebrá-la em pedaços.")
AddCustomDescriptionPattern(
    "Teaches you to summon and control your (.-) Racer%.",
    "Ensina a invocar e controlar seu %1 Racer.")
AddCustomDescriptionPattern(
    "Teaches you to summon Pepe the Frog at the selected location for a few minutes%. Kick it!",
    "Ensina a invocar Pepe the Frog no local selecionado por alguns minutos. Dê um chute nele!")
AddCustomDescriptionPattern(
    "([%d%.,]+)%% chance to hit is required to never miss a raid boss%.",
    "É necessário ter %1%% de acerto para nunca errar um chefe de raide.")
for _, attackType in ipairs({ "melee off%-hand", "melee", "ranged" }) do
    AddCustomDescriptionPattern(
        "Increases your " .. attackType .. " chance to hit a target of level ([%d%.,]+) by ([%d%.,]+)%%",
        "Aumenta em %2%% sua chance de acerto contra um alvo de nível %1")
end
AddCustomDescriptionPattern(
    "Reduces chance to be dodged or parried by ([%d%.,]+)%%",
    "Reduz em %1%% a chance de seus ataques serem esquivados ou aparados")
AddCustomDescriptionPattern(
    "Increases Critical Hit chance by ([%d%.,]+)%%|nIncreases Armor by ([%d%.,]+)",
    "Aumenta em %1%% a chance de acerto crítico.|nAumenta a armadura em %2")
AddCustomDescriptionPattern(
    "([%d%.,]+) point[s]?%s*:%s*([%d%.,]+)%% weapon damage plus ([%d%.,]+)",
    "%1 ponto: %2%% do dano da arma mais %3")
AddCustomDescriptionPattern(
    "Recarga: remaining: ([%d%.,]+) sec",
    "Recarga restante: %1 s")
AddCustomDescriptionPattern(
    "This ability can be recast within ([%d%.,]+) seconds to fire a |cFFFFFFFFCombo Shot|r%.",
    "Esta habilidade pode ser lançada novamente em até %1 s para disparar um |cFFFFFFFFCombo Shot|r.")
AddCustomDescriptionPattern(
    "Fire: Increases critical strike chance and hit chance for you and your elemental by ([%d%.,]+)%%%.",
    "Fogo: aumenta em %1%% sua chance de acerto e de acerto crítico e a do seu elemental.")
AddCustomDescriptionPattern(
    "Each stack increases |cFFFFFFFFEternity|r's healing by ([%d%.,]+)%% and its duration by ([%d%.,]+) sec%. Stacks up to ([%d%.,]+) times and lasts for ([%d%.,]+) sec or until you reach ([%d%.,]+) energy%.",
    "Cada acúmulo aumenta em %1%% a cura de |cFFFFFFFFEternity|r e em %2 s sua duração. Acumula até %3 vezes e dura %4 s ou até sua energia chegar a %5.")
AddCustomDescriptionPattern(
    "([%d%.,]+)%% chance to hit is required to never miss a player%.?",
    "É necessário ter %1%% de acerto para nunca errar um jogador.")
AddCustomDescriptionPattern(
    "Crit rating ([%d%.,]+) %(%+([%d%.,]+)%% crit chance%)",
    "Índice de crítico %1 (+%2%% de chance de crítico)")
AddCustomDescriptionPattern(
    "Armor penetration rating ([%d%.,]+) %(Enemy damage reduction from armor reduced by up to ([%d%.,]+)%%%)%.",
    "Índice de penetração de armadura %1 (reduz em até %2%% a mitigação de dano da armadura inimiga).")
AddCustomDescriptionPattern(
    "(|c%x%x%x%x%x%x%x%x%-?[%d%.,]+|r) Damage Per Second",
    "%1 de dano por segundo")
AddCustomDescriptionPattern(
    "Reduz a recarga de your Grounding Totem em ([%d%.,]+) s%.",
    "Reduz em %1 s a recarga de Grounding Totem.")
AddCustomDescriptionPattern(
    "Finishing move that consumes combo points on your target to restore ([%d%.,]+)%% of your maximum health a cada ([%d%.,]+) s%. Lasts longer per combo point:",
    "Finalização que consome os pontos de combo no alvo para restaurar %1%% da sua vida máxima a cada %2 s. Dura mais conforme os pontos de combo:")
AddCustomDescriptionPattern(
    "The array of talents available to enhance and specialize your character%.",
    "Conjunto de talentos disponíveis para fortalecer e especializar seu personagem.")
AddCustomDescriptionPattern(
    "The amount of experience %(XP%) you have earned%. The color of the XP bar indicates your rest state: light blue for Rested, and purple for Normal%. Rested players earn twice the experience they would normally gain from slaying a monster%. Characters become less rested when they kill monsters, and more rested by spending time at or logging out at an inn or city%.",
    "Quantidade de experiência (XP) obtida. A cor da barra indica seu descanso: azul-claro para Descansado e roxo para Normal. Personagens descansados recebem o dobro de experiência ao derrotar monstros. O descanso diminui ao derrotar inimigos e aumenta ao permanecer ou sair do jogo em uma estalagem ou cidade.")
AddCustomDescriptionPattern(
    "([ ]*)([%d]+) point[s]?%s*:%s*([%d%.,]+) Physical damage; ([%d%.,]+)%% increase for ([%d%.,]+) sec",
    "%1%2 ponto: %3 de dano Físico; aumento de %4%% por %5 s")
AddCustomDescriptionPattern(
    "Crit Chance scales Primarily from |cffFFFFFFCrit Rating|r, |cffFFFFFFAgility|r, and slightly from |cffFFFFFFIntellect|r",
    "A chance de crítico é determinada principalmente pelo |cffFFFFFFÍndice de Crítico|r e pela |cffFFFFFFAgilidade|r, e em menor grau pelo |cffFFFFFFIntelecto|r")
AddCustomDescriptionPattern(
    "Seus ataques de corpo a corpo têm uma chance de Reduz a cura recebida pelo alvo em ([%d%.,]+)%% durante ([%d%.,]+) s%. Esta acumulação pode alcançar até ([%d%.,]+) vezes%. This occurs more often than Furious Attacks %(Rank ([%d%.,]+)%)%.",
    "Seus ataques corpo a corpo têm chance de reduzir em %1%% a cura recebida pelo alvo por %2 s. Acumula até %3 vezes. Isso ocorre com mais frequência do que em Furious Attacks (Grau %4).")
AddCustomDescriptionPattern(
    "Water: Increases healing done for you and your elemental and reduces the mana cost of all spells by ([%d%.,]+)%%%.",
    "Água: aumenta em %1%% a cura realizada por você e seu elemental e reduz em %1%% o custo de mana de todos os feitiços.")
AddCustomDescriptionPattern(
    "Air: Increases haste for you and your elemental and reduces magical damage taken by ([%d%.,]+)%%%.",
    "Ar: aumenta em %1%% a aceleração de você e seu elemental e reduz em %1%% o dano mágico recebido.")
AddCustomDescriptionPattern(
    "Earth: Reduces damage taken by you and your elemental by ([%d%.,]+)%% and increases stamina by ([%d%.,]+)%%%.",
    "Terra: reduz em %1%% o dano recebido por você e seu elemental e aumenta em %2%% o Vigor.")
AddCustomDescriptionPattern(
    "Other Elementals: Increases all damage done by ([%d%.,]+)%% and decreases all damage taken by ([%d%.,]+)%%%.",
    "Outros elementais: aumenta em %1%% todo o dano causado e reduz em %2%% todo o dano recebido.")
AddCustomDescriptionPattern(
    "You keep at least ([%d%.,]+) rage after using Execute%.",
    "Você mantém pelo menos %1 de raiva após usar Execute.")
AddCustomDescriptionPattern(
    "Increases Spell Critical Hit by ([%d%.,]+)%%",
    "Aumenta em %1%% a chance de acerto crítico com feitiços")
AddCustomDescriptionPattern(
    "Block Rating of ([%d%.,]+) adds ([%d%.,]+)%% Block",
    "Um índice de bloqueio de %1 acrescenta %2%% de chance de bloqueio")
AddCustomDescriptionPattern(
    "This uses (.-) modifiers%.",
    "Usa os modificadores de %1.")
AddCustomDescriptionPattern(
    "Não é possível desaprender: You have locked this spell",
    "Não é possível desaprender: você bloqueou esta habilidade")
AddCustomDescriptionPattern(
    "Não é possível desaprender: You do not have a Scroll of Fortune",
    "Não é possível desaprender: você não possui um Scroll of Fortune")
AddCustomDescriptionPattern(
    "É necessário ter ([%d%.,]+)%% de acerto para nunca errar um jogador%. with your off%-hand weapon%.",
    "É necessário ter %1%% de acerto para nunca errar um jogador com a arma da mão secundária.")
AddCustomDescriptionPattern(
    "([%d%.,]+) to ([%d%.,]+)",
    "%1 a %2")
AddCustomDescriptionPattern(
    "Strikes fear in the enemy, causing it to run in fear for up to ([%d%.,]+) sec%.%s+Damage caused may interrupt the effect%. Only ([%d%.,]+) target can be feared at a time%.",
    "Amendronta o inimigo, fazendo-o fugir por até %1 s. O dano pode interromper o efeito. Apenas %2 alvo pode ser amedrontado por vez.")
AddCustomDescriptionPattern(
    "Transforms the enemy into a frog%. While hexed, the target cannot attack or cast spells%. Damage caused may interrupt the effect%. Lasts ([%d%.,]+) sec%. Only one target can be hexed at a time%. Only works on Humanoids and Beasts%.",
    "Transforma o inimigo em sapo. Enquanto transformado, o alvo não pode atacar nem lançar feitiços. O dano pode interromper o efeito. Dura %1 s. Apenas um alvo pode ser transformado por vez. Funciona somente contra Humanoides e Feras.")
AddCustomDescriptionPattern(
    "Pummel the target, interrupting spellcasting and preventing spells of that school from being cast for ([%d%.,]+) sec%.",
    "Golpeia o alvo, interrompendo o lançamento e impedindo feitiços da mesma escola por %1 s.")
AddCustomDescriptionPattern(
    "Fires a burst of missiles at the target, dealing ([%d%.,]+)%% weapon damage%.",
    "Dispara uma rajada de projéteis contra o alvo, causando %1%% do dano da arma.")
AddCustomDescriptionPattern(
    "Can trigger |cFFFFFFFFPiercing Shots|r%.",
    "Pode ativar |cFFFFFFFFPiercing Shots|r.")
AddCustomDescriptionPattern(
    "While wielding a single Two%-Handed weapon, this periodic damage can critically strike%.",
    "Enquanto estiver empunhando apenas uma arma de duas mãos, este dano periódico pode causar acerto crítico.")
AddCustomDescriptionPattern(
    "Dealing damage with Lava Lash grants |cFFFFFFFFEruption|r%.",
    "Causar dano com Lava Lash concede |cFFFFFFFFEruption|r.")
AddCustomDescriptionPattern(
    "Aumenta a Chance de Acerto Crítico de seu próximo Piroexplosão em ([%d%.,]+)%%%. Consuming this empowers your Flametongue Attacks to erupt onto nearby enemies%. Stacks up to ([%d%.,]+) times and lasts ([%d%.,]+) sec%.",
    "Aumenta em %1%% a chance de acerto crítico do próximo Pyroblast. Consumir este efeito fortalece seus Flametongue Attacks, fazendo-os irromper sobre inimigos próximos. Acumula até %2 vezes e dura %3 s.")

-- Padroes coletados diretamente dos tooltips customizados encontrados nos
-- servidores do Ascension. Sao frases mecanicas, independentes de ID e grau;
-- por isso cobrem variantes futuras sem tocar na primeira linha (nome).
AddCustomDescriptionPattern(
    "Dealing damage with Lightning Bolt and Chain Lightning grant |cFFFFFFFFThunder Seer|r%.",
    "Causar dano com Lightning Bolt e Chain Lightning concede |cFFFFFFFFThunder Seer|r.")
AddCustomDescriptionPattern(
    "Aumenta em ([%d%.,]+)%% a chance critica das curas de Shaman, Lightning Bolt e Chain Lightning%. Reduz Tidal Force em ([%d%.,]+) s%.",
    "Aumenta em %1%% a chance crítica das curas de Shaman, Lightning Bolt e Chain Lightning. Reduz a recarga de Tidal Force em %2 s.")
AddCustomDescriptionPattern(
    "Capstone Bonus: Healing Wave and Riptide direct criticals add ([%d%.,]+) seconds, Lesser Healing Wave ([%d%.,]+) second and Chain Heal criticals ([%d%.,]+) sec to the duration of Tidal Force%.",
    "Bônus final: críticos diretos de Healing Wave e Riptide acrescentam %1 s à duração de Tidal Force; Lesser Healing Wave acrescenta %2 s e críticos de Chain Heal, %3 s.")
AddCustomDescriptionPattern(
    "Does not stack with other similar effects%.",
    "Não acumula com outros efeitos semelhantes.")
AddCustomDescriptionPattern(
    "Whenever your Rend ability causes damage, you have a ([%d%.,]+)%% chance of allowing the use of your Overpower ability for ([%d%.,]+) sec%.",
    "Quando Rend causa dano, você tem %1%% de chance de poder usar Overpower durante %2 s.")
AddCustomDescriptionPattern(
    "Increases your Stamina by ([%d%.,]+)%%, and reduces the duration of movement slowing effects on you by ([%d%.,]+)%%%.",
    "Aumenta seu Vigor em %1%% e reduz em %2%% a duração dos efeitos de redução de movimento.")
AddCustomDescriptionPattern(
    "Aumenta seu Vigor em ([%d%.,]+)%%, and reduces the duration of movement slowing effects on you by ([%d%.,]+)%%%.",
    "Aumenta seu Vigor em %1%% e reduz em %2%% a duração dos efeitos de redução de movimento.")
AddCustomDescriptionPattern(
    "Consecration now deals instant Holy damage to nearby enemies, causing extra threat and slowing their melee attack speed by ([%d%.,]+)%% for ([%d%.,]+) sec%.",
    "Consecration agora causa dano Sagrado imediato aos inimigos próximos, gera ameaça adicional e reduz em %1%% a velocidade dos ataques corpo a corpo deles durante %2 s.")
AddCustomDescriptionPattern(
    "Reduces the mana cost of your Frost spells and abilities by ([%d%.,]+)%% and reduces their threat caused by ([%d%.,]+)%%%.",
    "Reduz em %1%% o custo de mana das suas habilidades e feitiços de Gelo e em %2%% a ameaça gerada por eles.")
AddCustomDescriptionPattern(
    "Capstone Bonus: Killing an enemy that yields experience or honor with Frost damage will restore ([%d%.,]+)%% of your mana%.",
    "Bônus final: derrotar com dano de Gelo um inimigo que conceda experiência ou honra restaura %1%% da sua mana.")
AddCustomDescriptionPattern(
    "Path of Healing enables you to fulfill the |cFFFFFFFFHealer Role|r%. This primary stat increases your Healing Power based on your Spell Power%.",
    "Path of Healing permite exercer a |cFFFFFFFFfunção de curador|r. Este atributo principal aumenta seu Poder de Cura com base no seu Poder Mágico.")
AddCustomDescriptionPattern(
    "Path of Intelligence focuses on empowering spell damage, increasing mana pool and is especially beneficial for those who use Spell Power and Intellect%.",
    "Path of Intelligence fortalece o dano de feitiços e aumenta a reserva de mana, sendo ideal para quem usa Poder Mágico e Intelecto.")
AddCustomDescriptionPattern(
    "Path of Strength focuses on dealing heavy hits and armor piercing attacks, and is especially beneficial for Plate armor users or those who use Strength%.",
    "Path of Strength favorece golpes pesados e ataques que perfuram armadura, sendo ideal para usuários de placas ou de Força.")
AddCustomDescriptionPattern(
    "A mocking attack, dealing weapon damage, that causes a moderate amount of threat and forces the target to focus attacks on you for ([%d%.,]+) sec%.",
    "Um ataque de provocação que causa dano da arma, gera uma quantidade moderada de ameaça e obriga o alvo a atacar você durante %1 s.")
AddCustomDescriptionPattern(
    "An instant strike that causes ([%d%.,]+) Spellstorm damage in addition to ([%d%.,]+)%% of your normal weapon damage %(([%d%.,]+)%% if a Two%-Handed weapon is equipped%)%. Awards ([%d%.,]+) combo point%.",
    "Um golpe instantâneo que causa %1 de dano de Spellstorm mais %2%% do dano normal da arma (%3%% com arma de duas mãos). Concede %4 ponto de combo.")
AddCustomDescriptionPattern(
    "|cFFFFFFFFThis spell belongs to |r(|c%x%x%x%x%x%x%x%x.-|r)",
    "|cFFFFFFFFEsta habilidade pertence a |r%1")
AddCustomDescriptionPattern(
    "Adquire a habilidade criar |cffffffffCuero crudo|r a partir do Couro obtido com o Desolhado%. Concede a .- e aumenta sua velocidade no Desolhado%.",
    "Aprende a criar |cffffffffRaw Leather|r usando o couro obtido com Skinning. Tambem permite encontra-lo ao esfolar feras e aumenta sua velocidade durante Skinning.")
AddCustomDescriptionPattern(
    "Permite que possa criar itens que requerem |cffffffffCuero crudo|r%.",
    "Permite criar itens que exigem |cffffffffRaw Leather|r.")
AddCustomDescriptionPattern(
    "Cura um alvo aliado em ([%d%.,]+) to ([%d%.,]+) e depois salta para outros alvos aliados .-%.",
    "Cura um alvo aliado em %1 a %2 e depois salta para outros alvos aliados próximos.")
AddCustomDescriptionPattern(
    "([%d%.,]+) charges%.",
    "%1 cargas.")
AddCustomDescriptionPattern(
    "Cost:",
    "Custo:")
AddCustomDescriptionPattern(
    "Level:",
    "Nível:")

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

-- Entradas pontuais adicionadas acima tambem obedecem a politica de nomes em
-- ingles. Esta passagem final e barata e ocorre apenas uma vez no carregamento.
for english in pairs(APT.SpellNameEN2PT or {}) do
    if type(english) == "string" then APT.SpellNameEN2PT[english] = english end
end
