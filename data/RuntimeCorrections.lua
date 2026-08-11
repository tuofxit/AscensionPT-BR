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
