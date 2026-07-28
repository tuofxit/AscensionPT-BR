--[[
  ItemNameTranslator.lua
  ============================================================================
  Tradutor inteligente de nomes completos de item (Fase 9 — Sprint 3)

  Responsabilidade:
    Interpretar a estrutura gramatical do nome antes de traduzir,
    produzindo traducoes naturais em portugues.

  Diferenca para o PatternDictionary:
    PatternDictionary traduz PADROES (expressoes regulares) em qualquer texto.
    ItemNameTranslator traduz NOMES DE ITEM completos com regras estruturais.

  Templates implementados (Sprint 3):
    P2: [Adjective] + [Base]       -> "Worn Shortsword" -> "Espada Curta Desgastada"
    P3: [Material] + [Base]        -> "Copper Shortsword" -> "Espada Curta de Cobre"
    P6: [Base] of [Target]         -> "Boots of Speed" -> "Botas de Velocidade"
    P7: [Base] of the [Target]     -> "Crown of the Hallowed" -> "Coroa dos Consagrados"

  Integracao:
    Quando ENABLE_ITEM_NAME_TRANSLATOR = true, este modulo e inserido
    no pipeline ANTES do PatternDictionary, fornecendo pre-traducao
    estrutural para nomes de item.

  Estado inicial: ENABLE_ITEM_NAME_TRANSLATOR = false (paralelo, nao ativo)
  ============================================================================
--]]

-- Feature flag — controla se o ITN esta ativo
ENABLE_ITEM_NAME_TRANSLATOR = false

-- ============================================================================
-- DICIONARIOS
-- ============================================================================

-- Tipos de item (Base)
local BaseDict = {
  -- Armas corpo a corpo
  Sword="Espada", Swords="Espadas",
  Blade="Lamina", Blades="Laminas",
  Spear="Lanca", Spears="Lancas",
  Staff="Cajado", Staves="Cajados",
  Mace="Maca", Maces="Macas",
  Axe="Machado", Axes="Machados",
  Waraxe="Machado de Guerra",
  Dagger="Adaga", Daggers="Adagas",
  Knife="Faca", Knives="Facas",
  Hammer="Martelo", Hammers="Martelos",
  Maul="Malho", Mauls="Malhos",
  Club="Clava", Clubs="Clavas",
  Cudgel="Cacetete",
  Fist="Punho", Fists="Punhos",
  Warblade="Lamina de Guerra",
  Greatsword="Grande Espada",
  Battleaxe="Machado de Batalha",
  Shortsword="Espada Curta",
  Scepter="Cetro", Scepters="Cetros",
  -- Armas de longo alcance
  Bow="Arco", Bows="Arcos",
  Gun="Arma de Fogo", Guns="Armas de Fogo",
  Rifle="Rifle", Rifles="Rifles",
  Wand="Varinha", Wands="Varinhas",
  -- Escudos
  Shield="Escudo", Shields="Escudos",
  Buckler="Broquel",
  Aegis="Egide",
  -- Cabeca
  Helm="Elmo", Helms="Elmos",
  Helmet="Capacete", Helmets="Capacetes",
  Hood="Capuz", Hoods="Capuzes",
  Cowl="Cogula", Cowls="Cogulas",
  Cap="Gorro", Caps="Gorros",
  Mask="Mascara", Masks="Mascaras",
  Crown="Coroa", Crowns="Coroas",
  Headguard="Protecao de Cabeca",
  Faceguard="Protecao Facial",
  Skullcap="Carapuca",
  -- Peito
  Robe="Tunica", Robes="Tunicas",
  Vest="Veste", Vests="Vestes",
  Tunic="Tunica", Tunics="Tunicas",
  Breastplate="Peitoral",
  Chestguard="Guarda-peito",
  Raiment="Vestimenta",
  Vestments="Vestes",
  Garb="Traje",
  Hauberk="Cota",
  Chainmail="Cota de Malha",
  -- Ombros
  Pauldron="Poldrao", Pauldrons="Poldroes",
  Spaulder="Ombreira", Spaulders="Ombreiras",
  Mantle="Ombreira", Mantles="Ombreiras",
  Shoulderpad="Ombreira", Shoulderpads="Ombreiras",
  -- Pescoco
  Necklace="Colar", Necklaces="Colares",
  Amulet="Amuleto", Amulets="Amuletos",
  Pendant="Pingente", Pendants="Pingentes",
  Collar="Colar",
  Gorget="Gorgoteira",
  -- Dedo
  Ring="Anel", Rings="Aneis",
  Band="Anel", Bands="Aneis",
  Signet="Sinet",
  Loop="Elo",
  -- Costas
  Cape="Capa", Capes="Capas",
  Cloak="Capa", Cloaks="Capas",
  Shroud="Mortalha",
  -- Cintura
  Belt="Cinto", Belts="Cintos",
  Waistguard="Cinturao", Waistguards="Cinturoes",
  Girdle="Cinto", Girdles="Cintos",
  Sash="Faixa", Sashes="Faixas",
  Waistband="Cinta",
  Cinch="Cinta",
  Cord="Cordao", Cords="Cordoes",
  -- Pescoco (duas categorias diferentes em WoW)
  -- (ja listado acima em Pescoco)
  -- Pernas
  Leggings="Perneiras",
  Legplates="Placas de Perna",
  Legwraps="Envoltorios de Perna",
  Pants="Calcas",
  Greaves="Grevas",
  Trousers="Calcas",
  -- Pes
  Boots="Botas", Boot="Bota",
  Sabatons="Sabatoes", Sabaton="Sabatao",
  Treads="Pisadas",
  Sandals="Sandalias",
  Slippers="Chinelos",
  -- Pulsos
  Bracer="Bracadeira", Bracers="Bracadeiras",
  Wristguard="Pulseira", Wristguards="Pulseiras",
  Armguard="Bracadeira", Armguards="Bracadeiras",
  Armlet="Bracadeira", Armlets="Bracadeiras",
  Bands="Bracadeiras",
  Bindings="Ataduras",
  -- Maos
  Gloves="Luvas", Gloves2="Luvas",
  Gauntlets="Manoplas",
  Handguards="Protetores",
  Grips="Pegas",
  Mitts="Mitenes",
  Cuffs="Punhos",
  -- Diversos
  Trinket="Talisma", Trinkets="Talismas",
  Talisman="Talisma", Talismans="Talismas",
  Libram="Livro", Librams="Livros",
  Totem="Totem",
  Idol="Idolo", Idols="Idolos",
  Relic="Reliquia", Relics="Reliquias",
  Charm="Amuleto", Charms="Amuletos",
  Medallion="Medalhao",
  Crest="Brasao",
  Emblem="Emblema",
  Icon="Icone",
  Focus="Foco",
  -- Materiais de crafting (itens)
  Cloth="Tecido",
  Leather="Couro",
  Ore="Minerio",
  Bar="Barra",
  Gem="Gema", Gems="Gemeras",
  Stone="Pedra",
  Potion="Pocao", Potions="Pocoes",
  Elixir="Elixir", Elixirs="Elixires",
  Flask="Frasco", Flasks="Frascos",
  Scroll="Pergaminho", Scrolls="Pergaminhos",
  Book="Livro", Books="Livros",
  Key="Chave", Keys="Chaves",
  Map="Mapa", Maps="Mapas",
  Bag="Bolsa", Bags="Bolsas",
  Quiver="Aljava",
  Ammo="Municao",
  Arrow="Flecha", Arrows="Flechas",
  Bullet="Bala", Bullets="Balas",
  Food="Comida",
  Drink="Bebida",
  Recipe="Receita", Recipes="Receitas",
  Pattern="Padrao", Patterns="Padroes",
  Formula="Formula", Formulas="Formulas",
  Design="Projeto", Designs="Projetos",
  Schematic="Esquematico",
  Dreams="Sonhos",
}

-- Adjetivos
local AdjDict = {
  Worn="Desgastado", Perilous="Perigoso", Fleeting="Fugaz",
  Deft="Agil", Brilliant="Brilhante",
  Iridescent="Iridescente", Elegant="Elegante",
  Valorous="Valoroso", Searing="Chamejante",
  Golden="Dourado", Magnificent="Magnifico",
  Resilient="Resistente", Phantom="Fantasma",
  Ceremonial="Cerimonial", Hardened="Endurecido",
  Heavy="Pesado", Light="Leve",
  Simple="Simples", Ancient="Antigo",
  Elder="Anciao", Mighty="Poderoso",
  Radiant="Radiante", Glowing="Brilhante",
  Burning="Ardente", Frozen="Congelado",
  Icy="Gelado", Fiery="Fogoso",
  Shadowy="Sombrio", Holy="Sagrado",
  Arcane="Arcano", Swift="Rapido",
  Quick="Veloz", Sturdy="Resistente",
  Robust="Robusto", Strong="Forte",
  Delicate="Delicado", Fine="Fino",
  Exquisite="Exquisito", Flawless="Impecavel",
  Perfect="Perfeito", Ornate="Ornado",
  Engraved="Gravado", Etched="Gravado",
  Gilded="Dourado", Polished="Polido",
  Shimmering="Cintilante", Glimmering="Cintilante",
  Awful="Horrivel", Lowly="Humilde",
  Minor="Menor", Lesser="Inferior",
  Greater="Superior", Major="Maior",
  Vicious="Ferino", Ferocious="Feróz",
  Savage="Selvagem", Barbaric="Barbaro",
  Fierce="Feroz", Bloody="Sangrento",
  Crimson="Carmim", Scarlet="Escarlate",
  Violet="Violeta", Emerald="Esmeralda",
  Crystal="Cristalino", Keen="Agucado",
  Sharp="Afiado", Dull="Cego",
  Intricate="Intrincado", Elaborate="Elaborado",
  Spiked="Espinhoso", Studded="Tachado",
  Ribbed="Canelado", Blessed="Abencoado",
  Cursed="Amaldicoado", Haunted="Assombrado",
  Barbed="Farpado", Serrated="Serrilhado",
  Jagged="Denteado", Balanced="Equilibrado",
  Weighted="Lastrado", Demonic="Demoníaco",
  Unstable="Instavel", Volatile="Volatil",
  Wicked="Perverso", Twisted="Torcido",
  Corrupted="Corrompido", Stalwart="Leal",
  Valiant="Valente", Noble="Nobre",
  Honorable="Honrado", Mystic="Mistico",
  Titanic="Titanico", Primordial="Primordial",
  Fractured="Fragmentado", Vibrant="Vibrante",
  Vivid="Vivido", Lively="Vivo",
  Spirited="Espiritual", Soulful="Cheio de Alma",
  Vengeful="Vingativo", Wrathful="Irado",
  Glorious="Glorioso", Victorious="Vitorioso",
  Furious="Furioso", Relentless="Incansavel",
  Grim="Sombrio", Dread="Temivel",
  Runic="Runico", Inscribed="Inscrito",
  Ghastly="Horripilante", Spectral="Espectral",
  Phantasmal="Fantasmagorico",
  Restored="Restaurado", Renewed="Renovado",
  Purified="Purificado", Hallowed="Sagrado",
  Consecrated="Consagrado", Voodoo="Vodu",
  Fel="Corrupto", Eldritch="Arcani",
  Verdant="Verdejante", Primal="Primordial",
  Prime="Primordial", Razor="Afiado",
  Slippery="Escorregadio", Slimy="Viscoso",
  Stiff="Rigido", Supple="Flexivel",
  Rigid="Rigido", Flexible="Flexivel",
  Lucky="Da Sorte",
  War="Guerra", Battle="Batalha",
  Grim="Sombrio", Vile="Vil",
  Fallen="Caido", Dark="Escuro",
  Twilight="Crepusculo",
  Abyssal="Abissal",
  Blazing="Chamejante",
  Bloodthirsty="Sanguinario",
  Brutal="Brutal",
  Cadaverous="Cadaverico",
  Celestial="Celestial",
  Charred="Carbonizado",
  Concentrated="Concentrado",
  Crafted="Artesanal",
  Crystallized="Cristalizado",
  Dashing="Arrojado",
  Deadly="Mortal",
  Decaying="Decadente",
  Desecrated="Profanado",
  Draconic="Dragonico",
  Dreadful="Temivel",
  Elemental="Elemental",
  Empowered="Potencializado",
  Enchanted="Encantado",
  Eternal="Eterno",
  Faithful="Fiel",
  Fanged="Dentado",
  Feral="Feroz",
  Funeral="Funerario",
  Glacial="Glacial",
  Gnomish="Gnomico",
  Harmonious="Harmonioso",
  Hateful="Odioso",
  Haunting="Assombroso",
  Imbued="Imbuido",
  Imperial="Imperial",
  Infused="Infundido",
  Living="Vivo",
  Luminous="Luminoso",
  Malefic="Malefico",
  Malevolent="Malevolente",
  Malignant="Maligno",
  Merciless="Impiedoso",
  Mutated="Mutuante",
  Mythical="Mitico",
  Petrified="Petrificado",
  Prismatic="Prismatico",
  Reinforced="Reforcado",
  Ritual="Ritualistico",
  Royal="Real",
  Runed="Runico",
  Ruthless="Impiedoso",
  Sacred="Sagrado",
  Sanctified="Santificado",
  Scaled="Escamado",
  Silent="Silencioso",
  Sinful="Pecaminoso",
  Slumbering="Adormecido",
  Smoldering="Fumegante",
  Tainted="Maculado",
  Tattered="Esfarrapado",
  Tempered="Temperado",
  Terminal="Terminal",
  Transient="Transitorio",
  Triumphant="Triunfante",
  Unyielding="Inflexivel",
  Volcanic="Vulcanico",
  Weathered="Gasto",
  Witching="Arcano",
  Withered="Definhado",
  Broken="Partido",
}

-- Materiais
local MatDict = {
  Copper="Cobre", Iron="Ferro", Steel="Aco",
  Silver="Prata", Gold="Ouro",
  Mithril="Mitril", Thorium="Torium",
  Fel="Fel", Adamantite="Adamantita",
  Cobalt="Cobalto", Titanium="Titanio",
  Saronite="Saronita",
  Bone="Osso", Leather="Couro",
  Cloth="Tecido", Silk="Seda",
  Mageweave="Tecido Magico",
  Runecloth="Tecido Runico",
  Bronze="Bronze", Ebony="Ebano",
  Green="Verde", Red="Vermelho",
  Blue="Azul", Black="Preto",
  White="Branco",
  Alexandrite="Alexandrita",
  Arcanite="Arcanita",
  Azurite="Azurita",
  Brightcloth="Tecido Brilhante",
  Broodsilk="Seda da Ninhada",
  Cindercloth="Tecido de Cinzas",
  Cinnabar="Cinabrio",
  Cryptsilk="Seda da Cripta",
  Demoncloth="Tecido Demonio",
  Demonsilk="Seda Demonica",
  Elementium="Elementium",
  Embersilk="Seda de Brasa",
  Eternium="Eternium",
  Felcloth="Tecido Vil",
  Flarecloth="Tecido Flamejante",
  Frostcloth="Tecido de Gelo",
  Granite="Granito",
  Hematite="Hematita",
  Icecloth="Tecido Gelido",
  Iridium="Iridio",
  Khorium="Khorium",
  Kunzite="Kunzita",
  Malachite="Malaquita",
  Moldavite="Moldavita",
  Mooncloth="Tecido Lunar",
  Obsidium="Obsidiana",
  Platinum="Platina",
  Pyrite="Pirita",
  Pyrium="Pyrium",
  Rubellite="Rubelita",
  Selenium="Selenio",
  Shadowcloth="Tecido das Sombras",
  Slumbersilk="Seda Adormecida",
  Sodalite="Sodalita",
  Soulcloth="Tecido de Alma",
  Spellcloth="Tecido Arcano",
  Spidersilk="Seda de Aranha",
  Stormcloth="Tecido de Tempestade",
  Tanzanite="Tanzanita",
  Thallium="Talio",
  Vanadium="Vanadio",
  Venomsilk="Seda Venenosa",
  Voidcloth="Tecido do Vazio",
  Whispersilk="Seda Sussurrante",
  Wraithcloth="Tecido Espectral",
}

-- Genero dos tipos de base (para concordancia)
local FeminineBase = {
  Espada=true, Lamina=true,
  Armadura=true, Capa=true,
  Bota=true, Botas=true,
  Luvas=true, Ombreira=true, Ombreiras=true,
  Calca=true, Calcas=true,
  Coroa=true, Adaga=true,
  Maca=true, Varinha=true,
  Tunica=true, Veste=true,
  Mascara=true, Coifa=true,
  Faixa=true, Cota=true,
  Perneira=true, Perneiras=true,
  Pulseiras=true, Bracadeiras=true,
  Grevas=true, Pisadas=true,
  Sandalias=true, Corrente=true,
  Cinta=true, Placas=true,
}

-- Nomes proprios que nao devem receber artigo definido na preposicao
local ProperNames = {
  Ragnaros=true, Azshara=true, Hyjal=true,
  Bloodforged=true, Jeklik=true, Everfrost=true,
}

-- ============================================================================
-- UTILITARIOS
-- ============================================================================

local function IsFeminine(ptWord)
  if not ptWord then return false end
  local last = ptWord:match("(%a+)$")
  if not last then return false end
  if FeminineBase[last] then return true end
  if last:match("[aá]s?$") or last:match("[aá]de$") then return true end
  return false
end

local function ConjugateAdj(adj, feminine, plural)
  if not adj then return adj end
  if not feminine then
    if plural then
      return adj:gsub("o$", "os"):gsub("ão$", "ãos"):gsub("ao$", "os")
    end
    return adj
  end
  local res = adj:gsub("o$", "a")
    :gsub("ado$", "ada")
    :gsub("ido$", "ida")
    :gsub("oso$", "osa")
    :gsub("udo$", "uda")
    :gsub("ão$", "ãa")
    :gsub("ao$", "a")
  if plural then
    res = res:gsub("a$", "as"):gsub("e$", "es"):gsub("ãa$", "ãas")
  end
  return res
end

-- ============================================================================
-- P6/P7: BASE OF TARGET
-- ============================================================================

--- Encontra o indice de "of" nos tokens.
local function FindOf(tokens)
  for i, t in ipairs(tokens) do
    if t == "of" then return i end
  end
  return nil
end

--- Determina a contração correta para a preposição.
--- Para P7 ("of the"): sempre contrai (do/da/dos/das)
--- Para P6 ("of"): contrai exceto para nomes proprios explicitos
local function GetPrep(lastWord, hasThe)
  if not lastWord then return hasThe and "do" or "de" end

  -- Nomes proprios conhecidos: nunca contraem
  if ProperNames[lastWord] then return "de" end

  -- Determina genero a partir da forma PT (se disponivel)
  local ptForm = BaseDict[lastWord] or AdjDict[lastWord] or MatDict[lastWord] or lastWord
  local fem = IsFeminine(ptForm)
  local plural = ptForm:match("s$") ~= nil

  if fem and plural then return "das" end
  if fem then return "da" end
  if plural then return "dos" end
  return "do"
end

--- Traduz o alvo (target) do P6/P7 usando o proprio ITN recursivamente.
--- Se o target for uma frase, tenta traduzir como um todo primeiro.
--- Se falhar, traduz palavra por palavra.
local function TranslateTarget(tokens)
  if #tokens == 0 then return "" end
  local phrase = table.concat(tokens, " ")
  local result, tmpl = ItemNameTranslator_Translate(phrase)
  if result and result ~= phrase then return result end
  -- Fallback: traduz cada palavra individualmente
  local words = {}
  for _, t in ipairs(tokens) do
    words[#words+1] = AdjDict[t] or MatDict[t] or BaseDict[t] or t
  end
  return table.concat(words, " ")
end

--- P6: [Base] of [Target]
--- EN: "Boots of Speed"  PT: "Botas de Velocidade"
local function TranslateP6(tokens, ofIndex)
  local baseToken = tokens[ofIndex - 1]
  local basePT = BaseDict[baseToken] or baseToken

  local targetTokens = {}
  for i = ofIndex + 1, #tokens do
    targetTokens[#targetTokens+1] = tokens[i]
  end
  local targetPT = TranslateTarget(targetTokens)
  local lastWord = targetTokens[#targetTokens]
  local prep = GetPrep(lastWord, false)

  return basePT .. " " .. prep .. " " .. targetPT
end

--- P7: [Base] of the [Target]
--- EN: "Crown of the Hallowed"  PT: "Coroa dos Consagrados"
local function TranslateP7(tokens, ofIndex)
  local baseToken = tokens[ofIndex - 1]
  local basePT = BaseDict[baseToken] or baseToken

  local targetTokens = {}
  for i = ofIndex + 2, #tokens do
    targetTokens[#targetTokens+1] = tokens[i]
  end
  local targetPT = TranslateTarget(targetTokens)
  local lastWord = targetTokens[#targetTokens]
  local prep = GetPrep(lastWord, true)

  return basePT .. " " .. prep .. " " .. targetPT
end

-- ============================================================================
-- TOKENIZER
-- ============================================================================

local function Tokenize(name)
  local tokens = {}
  if not name or name == "" then return tokens end
  for word in name:gmatch("[%w']+") do
    table.insert(tokens, word)
  end
  return tokens
end

-- ============================================================================
-- CLASSIFIER
-- ============================================================================

local function ClassifyToken(token)
  if AdjDict[token] then return "adjective" end
  if MatDict[token] then return "material" end
  if BaseDict[token] then return "base" end
  -- Check if it looks like a proper name (capitalized, not in dictionaries)
  if token:match("^[A-Z][a-z]") then return "proper" end
  return "unknown"
end

-- ============================================================================
-- TEMPLATE DETECTION
-- ============================================================================

local function HasPossessive(tokens)
  for _, t in ipairs(tokens) do
    if t:match("'[sS]$") then return true end
  end
  return false
end

local function DetectTemplate(tokens)
  if #tokens == 0 then return nil end
  if #tokens == 1 then
    if BaseDict[tokens[1]] then return "P1" end
    return nil
  end

  -- Possessivos ('s) nao sao P2/P3 — "Lord's Breastplate" deve ser ignorado
  if HasPossessive(tokens) then return nil end

  -- P7: [Base] of the [Target]
  local ofIdx = FindOf(tokens)
  if ofIdx and ofIdx >= 2 and ofIdx + 2 <= #tokens and tokens[ofIdx + 1] == "the" then
    local baseToken = tokens[ofIdx - 1]
    if BaseDict[baseToken] then return "P7" end
  end

  -- P6: [Base] of [Target]
  if ofIdx and ofIdx >= 2 then
    local baseToken = tokens[ofIdx - 1]
    if BaseDict[baseToken] then return "P6" end
  end

  local t1_type = ClassifyToken(tokens[1])
  local t2_type = ClassifyToken(tokens[#tokens])

  -- P2: Adjective + Base (last word is a base)
  if t1_type == "adjective" and t2_type == "base" then
    return "P2"
  end

  -- P3: Material + Base
  if t1_type == "material" and t2_type == "base" then
    return "P3"
  end

  -- P3: Material + ? + Base
  if t1_type == "material" and BaseDict[tokens[#tokens]] then
    return "P3"
  end

  -- P2: Adjective + unknown base (base might not be in dictionary)
  if t1_type == "adjective" then
    return "P2"
  end

  -- P2: Unknown first word + known base (apenas se nao for nome proprio)
  if t2_type == "base" and t1_type ~= "proper" then
    return "P2"
  end

  -- P3: Material conhecido + qualquer palavra
  if MatDict[tokens[1]] then
    return "P3"
  end

  return nil
end

-- ============================================================================
-- TRADUTORES DE TEMPLATE
-- ============================================================================

--- P2: [Adjective] + [Base]
--- EN: "Worn Shortsword"  PT: "Espada Curta Desgastada"
local function TranslateP2(tokens)
  local baseToken = tokens[#tokens]
  local basePT = BaseDict[baseToken] or baseToken
  local fem = IsFeminine(basePT)
  local plural = basePT:match("s$") ~= nil

  local result = basePT

  -- Adjetivos em PT vao DEPOIS do substantivo
  for i = 1, #tokens - 1 do
    local adjPT = AdjDict[tokens[i]] or tokens[i]
    result = result .. " " .. ConjugateAdj(adjPT, fem, plural)
  end

  return result
end

--- P3: [Material] + [Base]
--- EN: "Copper Shortsword"  PT: "Espada Curta de Cobre"
local function TranslateP3(tokens)
  local baseToken = tokens[#tokens]
  local matToken = tokens[1]

  local basePT = BaseDict[baseToken] or baseToken
  local matPT = MatDict[matToken] or matToken

  return basePT .. " de " .. matPT
end

-- ============================================================================
--- MAIN TRANSLATE
-- ============================================================================

--- Traduz um nome de item usando o ItemNameTranslator.
--- @param name string  Nome original do item em ingles
--- @return string, string  (traducao, template_used)
function ItemNameTranslator_Translate(name)
  if not name or name == "" then return name, nil end

  local tokens = Tokenize(name)
  if #tokens == 0 then return name, nil end

  local template = DetectTemplate(tokens)
  if not template then return name, nil end

  local result
  if template == "P2" then
    result = TranslateP2(tokens)
  elseif template == "P3" then
    result = TranslateP3(tokens)
  elseif template == "P6" then
    local ofIdx = FindOf(tokens)
    result = TranslateP6(tokens, ofIdx)
  elseif template == "P7" then
    local ofIdx = FindOf(tokens)
    result = TranslateP7(tokens, ofIdx)
  else
    return name, nil
  end

  return result, template
end

-- ============================================================================
-- REGISTRO (para integracao futura com o pipeline)
-- ============================================================================

-- O ItemNameTranslator sera integrado ao pipeline quando:
-- 1. ENABLE_ITEM_NAME_TRANSLATOR for ativado (true)
-- 2. O ItemNameTranslatorAdapter for carregado (em scripts/item_translator_adapter.lua)
--
-- Fluxo quando ativo:
--   Texto Original
--     -> ItemNameTranslator (traducao estrutural)
--     -> PatternDictionary (padroes repetitivos)
--     -> GlossarioPTBR (termos conhecidos)
--     -> translate_dict (casos restantes)
--     -> Texto Final

ItemNameTranslator = {
  Translate = ItemNameTranslator_Translate,
  Version = "2.0.0",
  Templates = {"P2", "P3", "P6", "P7"},
  BaseDict = BaseDict,
  AdjDict = AdjDict,
  MatDict = MatDict,
  FeminineBase = FeminineBase,
  ProperNames = ProperNames,
}

-- ============================================================================
-- RELATORIO (uso fora do jogo para validacao em lote)
-- ============================================================================

--- Processa uma lista de nomes e gera estatisticas.
--- @param names table  Lista de nomes {origem, traducao_pipeline}
--- @return table  {results, stats}
function ItemNameTranslator_BatchProcess(names)
  local results = {}
  local stats = {
    total = #names,
    p2 = 0, p3 = 0, p6 = 0, p7 = 0,
    unchanged = 0,
    improved = 0,
    total_time = 0,
  }

  for _, entry in ipairs(names) do
    local start = os.clock()
    local itn, template = ItemNameTranslator_Translate(entry.orig)
    local elapsed = os.clock() - start
    stats.total_time = stats.total_time + elapsed

    if template == "P2" then stats.p2 = stats.p2 + 1 end
    if template == "P3" then stats.p3 = stats.p3 + 1 end
    if template == "P6" then stats.p6 = stats.p6 + 1 end
    if template == "P7" then stats.p7 = stats.p7 + 1 end

    local improved = (itn ~= entry.orig)
    if improved then stats.improved = stats.improved + 1 end
    if itn == entry.orig then stats.unchanged = stats.unchanged + 1 end

    table.insert(results, {
      id = entry.id,
      orig = entry.orig,
      pipeline = entry.pipeline,
      itn = itn,
      template = template,
      improved = improved,
    })
  end

  stats.avg_time = stats.total_time / math.max(1, stats.total)

  return results, stats
end

-- ============================================================================
-- FIM
-- ============================================================================
print("[ItemNameTranslator] Carregado — ENABLE_ITEM_NAME_TRANSLATOR = " .. tostring(ENABLE_ITEM_NAME_TRANSLATOR))
