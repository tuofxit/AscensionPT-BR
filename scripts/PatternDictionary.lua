--[[
  PatternDictionary.lua
  ============================================================================
  GERADOR INTELIGENTE DE TRADUÇÃO - ASCENSION PT-BR

  Responsabilidade:
    Reconhecer padrões repetitivos e gerar traduções em português
    através de regras reutilizáveis com handler().

  Pipeline de localização:
    Texto Original
      -> PatternDictionary (padrões repetitivos)
      -> GlossarioPTBR (termos conhecidos)
      -> translate_dict (casos restantes)
      -> Texto Final

  Cada etapa possui uma responsabilidade diferente.
  O PatternDictionary NÃO duplica termos do glossário.
  ============================================================================
--]]

PatternDictionary = {
  Version = "2.0.0",
  DEBUG = false,
  rules = {},
  glossary = nil,
  compiled = false,
}

-- ============================================================================
-- GLOSSÁRIO
-- ============================================================================

--- Define a referência ao GlossarioPTBR para consulta de termos.
function PatternDictionary:SetGlossary(g)
  self.glossary = g
  self.lowerGlossary = {}
  if type(g) == "table" then
    for k, v in pairs(g) do
      if type(k) == "string" then
        self.lowerGlossary[k:lower()] = v
      end
    end
  end
end

--- Consulta um termo no glossário.
--- Se existir tradução, retorna-a; senão, retorna o termo original.
function PatternDictionary:GlossaryTranslate(term)
  if not term or term == "" then
    return term
  end
  if not self.glossary then
    return term
  end
  local trimmed = term:match("^%s*(.-)%s*$")
  if self.glossary[trimmed] then
    return self.glossary[trimmed]
  end
  -- Segunda tentativa: O(1) lookup ignorando capitalização
  if self.lowerGlossary then
    local low = trimmed:lower()
    if self.lowerGlossary[low] then
      return self.lowerGlossary[low]
    end
  end
  return trimmed
end

-- ============================================================================
-- GERENCIAMENTO DE REGRAS
-- ============================================================================

--- Adiciona uma regra única ao dicionário.
--- Cada regra possui:
---   name        = identificador único
---   description = explicação do que a regra faz
---   category    = categoria (Items, Stats, Combat, etc.)
---   priority    = 1 a 100 (maior = executada primeiro)
---   pattern     = padrão Lua (string.gsub)
---   handler     = function(self, ...) que retorna a string traduzida
function PatternDictionary:AddRule(rule)
  table.insert(self.rules, rule)
  self.compiled = false
end

--- Ordena as regras por prioridade (decrescente).
--- Converte o pattern string em um pattern compilado quando possível.
function PatternDictionary:Compile()
  table.sort(self.rules, function(a, b)
    return a.priority > b.priority
  end)
  self.compiled = true
end

-- ============================================================================
-- TRADUTOR PRINCIPAL
-- ============================================================================

--- Aplica todas as regras ao texto de entrada.
--- Percorre as regras em ordem de prioridade (maior primeiro).
--- Quando uma regra casa, substitui e continua com a próxima.
function PatternDictionary:Translate(text)
  if not text or text == "" then
    return text
  end

  if not self.compiled then
    self:Compile()
  end

  local result = text

  for _, rule in ipairs(self.rules) do
    local matched, count
    local ok, err = pcall(function()
      matched, count = result:gsub(rule.pattern, function(...)
        return rule.handler(self, ...)
      end)
    end)
    if ok and count and count > 0 then
      if self.DEBUG then
        print(string.format("[PatternDictionary] Regra: %s | Categoria: %s", rule.name, rule.category))
        print(string.format("  Original : %s", text))
        print(string.format("  Antes    : %s", result))
        print(string.format("  Depois   : %s", matched))
      end
      result = matched
    elseif not ok then
      if self.DEBUG then
        print(string.format("[PatternDictionary] ERRO na regra %s: %s", rule.name, tostring(err)))
      end
    end
  end

  return result
end

-- ============================================================================
-- CONSTRUÇÃO DAS REGRAS
-- ============================================================================

function PatternDictionary:Build()
  -- Limpa regras anteriores
  self.rules = {}

  -- ========================================================================
  -- CATEGORIA: Items (prioridade 100)
  -- Padrões obrigatórios para itens
  -- ========================================================================

  self:AddRule({
    name = "RequiresLevel",
    description = "Traduz requisito de nível",
    category = "Items",
    priority = 100,
    pattern = "^Requires Level (%d+)$",
    handler = function(self, level)
      return string.format("Requer nível %s", level)
    end,
  })

  self:AddRule({
    name = "RequiredLevel",
    description = "Traduz nível requerido com dois pontos",
    category = "Items",
    priority = 100,
    pattern = "^Required Level:?%s*(%d+)$",
    handler = function(self, level)
      return string.format("Requer nível: %s", level)
    end,
  })

  self:AddRule({
    name = "ItemLevel",
    description = "Traduz nível do item",
    category = "Items",
    priority = 100,
    pattern = "^Item Level (%d+)$",
    handler = function(self, level)
      return string.format("Nível do item %s", level)
    end,
  })

  self:AddRule({
    name = "SellPrice",
    description = "Traduz preço de venda",
    category = "Items",
    priority = 100,
    pattern = "^Sell Price:?%s*(.+)$",
    handler = function(self, value)
      return string.format("Preço de venda: %s", value)
    end,
  })

  self:AddRule({
    name = "BuyPrice",
    description = "Traduz preço de compra",
    category = "Items",
    priority = 100,
    pattern = "^Buy Price:?%s*(.+)$",
    handler = function(self, value)
      return string.format("Preço de compra: %s", value)
    end,
  })

  self:AddRule({
    name = "Durability",
    description = "Traduz durabilidade",
    category = "Items",
    priority = 100,
    pattern = "^Durability (%d+)%s*/%s*(%d+)$",
    handler = function(self, current, max)
      return string.format("Durabilidade %s / %s", current, max)
    end,
  })

  self:AddRule({
    name = "Unique",
    description = "Traduz item único",
    category = "Items",
    priority = 100,
    pattern = "^Unique$",
    handler = function(self)
      return "Único"
    end,
  })

  self:AddRule({
    name = "UniqueEquipped",
    description = "Traduz único equipado",
    category = "Items",
    priority = 100,
    pattern = "^Unique%-Equipped$",
    handler = function(self)
      return "Único - Equipado"
    end,
  })

  self:AddRule({
    name = "BindOnPickup",
    description = "Traduz ligado ao pegar",
    category = "Items",
    priority = 100,
    pattern = "^Bind on Pickup$",
    handler = function(self)
      return "Ligado ao pegar"
    end,
  })

  self:AddRule({
    name = "BindOnEquip",
    description = "Traduz ligado ao equipar",
    category = "Items",
    priority = 100,
    pattern = "^Bind on Equip$",
    handler = function(self)
      return "Ligado ao equipar"
    end,
  })

  self:AddRule({
    name = "Soulbound",
    description = "Traduz ligado (soulbound)",
    category = "Items",
    priority = 100,
    pattern = "^Soulbound$",
    handler = function(self)
      return "Ligado"
    end,
  })

  self:AddRule({
    name = "Cooldown",
    description = "Traduz recarga",
    category = "Items",
    priority = 90,
    pattern = "^Cooldown:?%s*(.+)$",
    handler = function(self, value)
      return string.format("Recarga: %s", value)
    end,
  })

  self:AddRule({
    name = "Charges",
    description = "Traduz cargas",
    category = "Items",
    priority = 90,
    pattern = "^Charges:?%s*(.+)$",
    handler = function(self, value)
      return string.format("Cargas: %s", value)
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Equipment (prioridade 95)
  -- ========================================================================

  self:AddRule({
    name = "EquipAction",
    description = "Traduz 'Equip:' para 'Equipar:'",
    category = "Equipment",
    priority = 95,
    pattern = "^Equip:%s*(.+)$",
    handler = function(self, bonus)
      return string.format("Equipar: %s", self:GlossaryTranslate(bonus:match("^%s*(.-)%s*$")))
    end,
  })

  self:AddRule({
    name = "EquipAlone",
    description = "Traduz 'Equip' isolado",
    category = "Equipment",
    priority = 95,
    pattern = "^Equip$",
    handler = function(self)
      return "Equipar"
    end,
  })

  self:AddRule({
    name = "UseAction",
    description = "Traduz 'Use:' para 'Usar:'",
    category = "Equipment",
    priority = 95,
    pattern = "^Use:%s*(.+)$",
    handler = function(self, effect)
      return string.format("Usar: %s", self:GlossaryTranslate(effect:match("^%s*(.-)%s*$")))
    end,
  })

  self:AddRule({
    name = "UseAlone",
    description = "Traduz 'Use' isolado",
    category = "Equipment",
    priority = 95,
    pattern = "^Use$",
    handler = function(self)
      return "Usar"
    end,
  })

  self:AddRule({
    name = "EquipColonOnly",
    description = "Traduz 'Equip:' isolado",
    category = "Equipment",
    priority = 96,
    pattern = "^Equip:%s*$",
    handler = function(self)
      return "Equipar:"
    end,
  })

  self:AddRule({
    name = "UseColonOnly",
    description = "Traduz 'Use:' isolado",
    category = "Equipment",
    priority = 96,
    pattern = "^Use:%s*$",
    handler = function(self)
      return "Usar:"
    end,
  })

  self:AddRule({
    name = "ChanceOnHitColonOnly",
    description = "Traduz 'Chance on hit:' isolado",
    category = "Equipment",
    priority = 96,
    pattern = "^Chance on hit:%s*$",
    handler = function(self)
      return "Chance ao acertar"
    end,
  })

  self:AddRule({
    name = "ChanceOnHit",
    description = "Traduz 'Chance on hit:' com efeito",
    category = "Equipment",
    priority = 95,
    pattern = "^Chance on hit:?%s*(.+)$",
    handler = function(self, effect)
      return string.format("Chance ao acertar: %s", self:GlossaryTranslate(effect:match("^%s*(.-)%s*$")))
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Stats (prioridade 90)
  -- Atributos e estatísticas
  -- ========================================================================

  self:AddRule({
    name = "PlusHitRating",
    description = "Traduz +N Hit Rating",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Hit Rating$",
    handler = function(self, value)
      return string.format("+%s de índice de acerto", value)
    end,
  })

  self:AddRule({
    name = "PlusCritRating",
    description = "Traduz +N Critical Strike Rating",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Critical Strike Rating$",
    handler = function(self, value)
      return string.format("+%s de índice de acerto crítico", value)
    end,
  })

  self:AddRule({
    name = "PlusHasteRating",
    description = "Traduz +N Haste Rating",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Haste Rating$",
    handler = function(self, value)
      return string.format("+%s de índice de aceleração", value)
    end,
  })

  self:AddRule({
    name = "PlusExpertiseRating",
    description = "Traduz +N Expertise Rating",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Expertise Rating$",
    handler = function(self, value)
      return string.format("+%s de índice de perícia", value)
    end,
  })

  self:AddRule({
    name = "PlusSpellPower",
    description = "Traduz +N Spell Power",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Spell Power$",
    handler = function(self, value)
      return string.format("+%s de poder dos feitiços", value)
    end,
  })

  self:AddRule({
    name = "PlusArmorPen",
    description = "Traduz +N Armor Penetration",
    category = "Stats",
    priority = 91,
    pattern = "^%+(%d+) Armor Penetration$",
    handler = function(self, value)
      return string.format("+%s de penetração de armadura", value)
    end,
  })

  self:AddRule({
    name = "PlusSpellPen",
    description = "Traduz +N Spell Penetration",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Spell Penetration$",
    handler = function(self, value)
      return string.format("+%s de penetração de feitiços", value)
    end,
  })

  self:AddRule({
    name = "PlusManaRegen",
    description = "Traduz +N Mana Regen",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Mana Regen$",
    handler = function(self, value)
      return string.format("+%s de regeneração de mana", value)
    end,
  })

  self:AddRule({
    name = "PlusHealthRegen",
    description = "Traduz +N Health Regen",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Health Regen$",
    handler = function(self, value)
      return string.format("+%s de regeneração de vida", value)
    end,
  })

  self:AddRule({
    name = "PlusAttackPower",
    description = "Traduz +N Attack Power",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Attack Power$",
    handler = function(self, value)
      return string.format("+%s de poder de ataque", value)
    end,
  })

  self:AddRule({
    name = "PlusMovementSpeed",
    description = "Traduz +N% Movement Speed",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+)%% Movement Speed$",
    handler = function(self, value)
      return string.format("+%s%% de velocidade de movimento", value)
    end,
  })

  self:AddRule({
    name = "PlusPvEPower",
    description = "Traduz +N PvE Power",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) PvE Power$",
    handler = function(self, value)
      return string.format("+%s de Poder PvE", value)
    end,
  })

  self:AddRule({
    name = "PlusPvPPower",
    description = "Traduz +N PvP Power",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) PvP Power$",
    handler = function(self, value)
      return string.format("+%s de Poder PvP", value)
    end,
  })

  -- Atributos primários (+Strength, +Agility, etc.)
  self:AddRule({
    name = "PlusStrength",
    description = "Traduz +N Strength",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Strength$",
    handler = function(self, value)
      return string.format("+%s de Força", value)
    end,
  })

  self:AddRule({
    name = "PlusAgility",
    description = "Traduz +N Agility",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Agility$",
    handler = function(self, value)
      return string.format("+%s de Agilidade", value)
    end,
  })

  self:AddRule({
    name = "PlusIntellect",
    description = "Traduz +N Intellect",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Intellect$",
    handler = function(self, value)
      return string.format("+%s de Intelecto", value)
    end,
  })

  self:AddRule({
    name = "PlusSpirit",
    description = "Traduz +N Spirit",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Spirit$",
    handler = function(self, value)
      return string.format("+%s de Espírito", value)
    end,
  })

  self:AddRule({
    name = "PlusStamina",
    description = "Traduz +N Stamina",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Stamina$",
    handler = function(self, value)
      return string.format("+%s de Vigor", value)
    end,
  })

  self:AddRule({
    name = "PlusArmor",
    description = "Traduz +N Armor",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+) Armor$",
    handler = function(self, value)
      return string.format("+%s de Armadura", value)
    end,
  })

  -- Atributos com porcentagem
  self:AddRule({
    name = "PlusCritPercent",
    description = "Traduz +N% Crit Chance",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+)%% Crit Chance$",
    handler = function(self, value)
      return string.format("+%s%% de chance crítica", value)
    end,
  })

  self:AddRule({
    name = "PlusDodgePercent",
    description = "Traduz +N% Dodge",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+)%% Dodge$",
    handler = function(self, value)
      return string.format("+%s%% de Esquiva", value)
    end,
  })

  self:AddRule({
    name = "PlusParryPercent",
    description = "Traduz +N% Parry",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+)%% Parry$",
    handler = function(self, value)
      return string.format("+%s%% de Aparo", value)
    end,
  })

  self:AddRule({
    name = "PlusBlockPercent",
    description = "Traduz +N% Block",
    category = "Stats",
    priority = 90,
    pattern = "^%+(%d+)%% Block$",
    handler = function(self, value)
      return string.format("+%s%% de Bloqueio", value)
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Tooltips (prioridade 85)
  -- Frases repetidas em tooltips de itens e feitiços
  -- ========================================================================

  self:AddRule({
    name = "IncreasesXbyY",
    description = "Traduz 'Increases X by Y.'",
    category = "Tooltips",
    priority = 85,
    pattern = "^Increases (.-) by (%d+)%.?$",
    handler = function(self, stat, value)
      stat = self:GlossaryTranslate(stat:match("^%s*(.-)%s*$"))
      return string.format("Aumenta em %s o seu %s.", value, stat)
    end,
  })

  self:AddRule({
    name = "IncreasesYourXbyY",
    description = "Traduz 'Increases your X by Y.'",
    category = "Tooltips",
    priority = 86,
    pattern = "^Increases your (.-) by (%d+)%.?$",
    handler = function(self, stat, value)
      stat = self:GlossaryTranslate(stat:match("^%s*(.-)%s*$"))
      return string.format("Aumenta em %s o seu %s.", value, stat)
    end,
  })

  self:AddRule({
    name = "ReducesXbyY",
    description = "Traduz 'Reduces X by Y.'",
    category = "Tooltips",
    priority = 85,
    pattern = "^Reduces (.-) by (%d+)%.?$",
    handler = function(self, stat, value)
      stat = self:GlossaryTranslate(stat:match("^%s*(.-)%s*$"))
      return string.format("Reduz em %s o seu %s.", value, stat)
    end,
  })

  self:AddRule({
    name = "ReducesYourXbyY",
    description = "Traduz 'Reduces your X by Y.'",
    category = "Tooltips",
    priority = 86,
    pattern = "^Reduces your (.-) by (%d+)%.?$",
    handler = function(self, stat, value)
      stat = self:GlossaryTranslate(stat:match("^%s*(.-)%s*$"))
      return string.format("Reduz em %s o seu %s.", value, stat)
    end,
  })

  self:AddRule({
    name = "ImprovesXbyY",
    description = "Traduz 'Improves X by Y.'",
    category = "Tooltips",
    priority = 85,
    pattern = "^Improves (.-) by (%d+)%.?$",
    handler = function(self, stat, value)
      stat = self:GlossaryTranslate(stat:match("^%s*(.-)%s*$"))
      return string.format("Melhora em %s o seu %s.", value, stat)
    end,
  })

  self:AddRule({
    name = "ImprovesYourXbyY",
    description = "Traduz 'Improves your X by Y.'",
    category = "Tooltips",
    priority = 86,
    pattern = "^Improves your (.-) by (%d+)%.?$",
    handler = function(self, stat, value)
      stat = self:GlossaryTranslate(stat:match("^%s*(.-)%s*$"))
      return string.format("Melhora em %s o seu %s.", value, stat)
    end,
  })

  self:AddRule({
    name = "IncreasesXbyYPercent",
    description = "Traduz 'Increases X by Y%.' (porcentagem)",
    category = "Tooltips",
    priority = 85,
    pattern = "^Increases (.-) by (%d+)%%%.?$",
    handler = function(self, stat, value)
      stat = self:GlossaryTranslate(stat:match("^%s*(.-)%s*$"))
      return string.format("Aumenta em %s%% o seu %s.", value, stat)
    end,
  })

  self:AddRule({
    name = "ReducesXbyYPercent",
    description = "Traduz 'Reduces X by Y%.' (porcentagem)",
    category = "Tooltips",
    priority = 85,
    pattern = "^Reduces (.-) by (%d+)%%%.?$",
    handler = function(self, stat, value)
      stat = self:GlossaryTranslate(stat:match("^%s*(.-)%s*$"))
      return string.format("Reduz em %s%% o seu %s.", value, stat)
    end,
  })

  -- PvE / PvP Power
  self:AddRule({
    name = "IncreasesPvEPowerBy",
    description = "Traduz 'Increases PvE Power by N.'",
    category = "Tooltips",
    priority = 88,
    pattern = "^Increases PvE Power by (%d+)%%?%.?$",
    handler = function(self, value)
      return string.format("Aumenta em %s o seu Poder PvE.", value)
    end,
  })

  self:AddRule({
    name = "IncreasesPvPPowerBy",
    description = "Traduz 'Increases PvP Power by N.'",
    category = "Tooltips",
    priority = 88,
    pattern = "^Increases PvP Power by (%d+)%%?%.?$",
    handler = function(self, value)
      return string.format("Aumenta em %s o seu Poder PvP.", value)
    end,
  })

  self:AddRule({
    name = "IncreasesPvEPowerByUpTo",
    description = "Traduz 'Increases PvE Power by up to N%.'",
    category = "Tooltips",
    priority = 88,
    pattern = "^Increases PvE Power by up to (%d+)%%%.?$",
    handler = function(self, value)
      return string.format("Aumenta em até %s%% o seu Poder PvE.", value)
    end,
  })

  self:AddRule({
    name = "IncreasesPvPandPvE",
    description = "Traduz 'Increases PvE and PvP Power by N.'",
    category = "Tooltips",
    priority = 88,
    pattern = "^Increases PvE and PvP Power by (%d+)%%?%.?$",
    handler = function(self, value)
      return string.format("Aumenta em %s o seu Poder PvE e PvP.", value)
    end,
  })

  -- Restore
  self:AddRule({
    name = "RestoresMana",
    description = "Traduz 'Restores N Mana.'",
    category = "Tooltips",
    priority = 85,
    pattern = "^Restores (%d+) Mana%.?$",
    handler = function(self, value)
      return string.format("Restaura %s de Mana.", value)
    end,
  })

  self:AddRule({
    name = "RestoresHealth",
    description = "Traduz 'Restores N Health.'",
    category = "Tooltips",
    priority = 85,
    pattern = "^Restores (%d+) Health%.?$",
    handler = function(self, value)
      return string.format("Restaura %s de Vida.", value)
    end,
  })

  self:AddRule({
    name = "RestoresRage",
    description = "Traduz 'Restores N Rage.'",
    category = "Tooltips",
    priority = 85,
    pattern = "^Restores (%d+) Rage%.?$",
    handler = function(self, value)
      return string.format("Restaura %s de Raiva.", value)
    end,
  })

  self:AddRule({
    name = "RestoresEnergy",
    description = "Traduz 'Restores N Energy.'",
    category = "Tooltips",
    priority = 85,
    pattern = "^Restores (%d+) Energy%.?$",
    handler = function(self, value)
      return string.format("Restaura %s de Energia.", value)
    end,
  })

  -- Damage / Healing percent
  self:AddRule({
    name = "IncreasesDamagePct",
    description = "Traduz 'Increases damage by N%.'",
    category = "Tooltips",
    priority = 87,
    pattern = "^Increases damage by (%d+)%%%.?$",
    handler = function(self, value)
      return string.format("Aumenta o dano causado em %s%%.", value)
    end,
  })

  self:AddRule({
    name = "IncreasesHealingPct",
    description = "Traduz 'Increases healing by N%.'",
    category = "Tooltips",
    priority = 87,
    pattern = "^Increases healing by (%d+)%%%.?$",
    handler = function(self, value)
      return string.format("Aumenta a cura realizada em %s%%.", value)
    end,
  })

  self:AddRule({
    name = "ReducesDamagePct",
    description = "Traduz 'Reduces damage by N%.'",
    category = "Tooltips",
    priority = 87,
    pattern = "^Reduces damage by (%d+)%%%.?$",
    handler = function(self, value)
      return string.format("Reduz o dano recebido em %s%%.", value)
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Sockets (prioridade 80)
  -- ========================================================================

  self:AddRule({
    name = "MetaSocket",
    description = "Traduz 'Meta Socket'",
    category = "Sockets",
    priority = 80,
    pattern = "^Meta Socket$",
    handler = function(self)
      return "Encaixe Meta"
    end,
  })

  self:AddRule({
    name = "RedSocket",
    description = "Traduz 'Red Socket'",
    category = "Sockets",
    priority = 80,
    pattern = "^Red Socket$",
    handler = function(self)
      return "Encaixe Vermelho"
    end,
  })

  self:AddRule({
    name = "YellowSocket",
    description = "Traduz 'Yellow Socket'",
    category = "Sockets",
    priority = 80,
    pattern = "^Yellow Socket$",
    handler = function(self)
      return "Encaixe Amarelo"
    end,
  })

  self:AddRule({
    name = "BlueSocket",
    description = "Traduz 'Blue Socket'",
    category = "Sockets",
    priority = 80,
    pattern = "^Blue Socket$",
    handler = function(self)
      return "Encaixe Azul"
    end,
  })

  self:AddRule({
    name = "PrismaticSocket",
    description = "Traduz 'Prismatic Socket'",
    category = "Sockets",
    priority = 80,
    pattern = "^Prismatic Socket$",
    handler = function(self)
      return "Encaixe Prismático"
    end,
  })

  self:AddRule({
    name = "SocketBonus",
    description = "Traduz 'Socket Bonus:'",
    category = "Sockets",
    priority = 80,
    pattern = "^Socket Bonus:?%s*(.+)$",
    handler = function(self, bonus)
      return string.format("Bônus do encaixe: %s", self:GlossaryTranslate(bonus:match("^%s*(.-)%s*$")))
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Equipment (parte 2 - bônus)
  -- ========================================================================

  self:AddRule({
    name = "SetBonus",
    description = "Traduz 'Set Bonus:'",
    category = "Equipment",
    priority = 80,
    pattern = "^Set Bonus:?%s*(.*)$",
    handler = function(self, bonus)
      if bonus and bonus ~= "" then
        return string.format("Bônus de conjunto: %s", self:GlossaryTranslate(bonus:match("^%s*(.-)%s*$")))
      end
      return "Bônus de conjunto"
    end,
  })

  self:AddRule({
    name = "EquipBonus",
    description = "Traduz 'Equip Bonus:'",
    category = "Equipment",
    priority = 80,
    pattern = "^Equip Bonus:?%s*(.*)$",
    handler = function(self, bonus)
      if bonus and bonus ~= "" then
        return string.format("Bônus ao equipar: %s", self:GlossaryTranslate(bonus:match("^%s*(.-)%s*$")))
      end
      return "Bônus ao equipar"
    end,
  })

  self:AddRule({
    name = "Gem",
    description = "Traduz 'Gem' em contexto de item",
    category = "Equipment",
    priority = 70,
    pattern = "^Gem:?%s*(.+)$",
    handler = function(self, name)
      return string.format("Gema: %s", self:GlossaryTranslate(name:match("^%s*(.-)%s*$")))
    end,
  })

  self:AddRule({
    name = "Enchant",
    description = "Traduz 'Enchant:'",
    category = "Equipment",
    priority = 70,
    pattern = "^Enchant:?%s*(.+)$",
    handler = function(self, name)
      return string.format("Encantamento: %s", self:GlossaryTranslate(name:match("^%s*(.-)%s*$")))
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Interface (prioridade 75)
  -- ========================================================================

  self:AddRule({
    name = "ClickHere",
    description = "Traduz '(Click Here!)'",
    category = "Interface",
    priority = 75,
    pattern = "^%([Cc]lick [Hh]ere!?%)$",
    handler = function(self)
      return "(Clique aqui!)"
    end,
  })

  self:AddRule({
    name = "LearnedSpell",
    description = "Traduz 'You have learned a new spell.'",
    category = "Interface",
    priority = 75,
    pattern = "^You have learned a new spell%.?$",
    handler = function(self)
      return "Você aprendeu um novo feitiço."
    end,
  })

  self:AddRule({
    name = "CollectedAppearance",
    description = "Traduz 'You have collected this appearance.'",
    category = "Interface",
    priority = 75,
    pattern = "^You have collected this appearance%.?$",
    handler = function(self)
      return "Você coletou esta aparência."
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Combat (prioridade 70)
  -- ========================================================================

  self:AddRule({
    name = "ChanceOnHitGeneric",
    description = "Traduz 'Chance on hit:' genérico",
    category = "Combat",
    priority = 70,
    pattern = "Chance on hit",
    handler = function(self)
      return "Chance ao acertar"
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Messages (prioridade 65)
  -- ========================================================================

  self:AddRule({
    name = "Requires",
    description = "Traduz 'Requires:'",
    category = "Messages",
    priority = 65,
    pattern = "^Requires:?%s*(.+)$",
    handler = function(self, value)
      return string.format("Requer: %s", self:GlossaryTranslate(value:match("^%s*(.-)%s*$")))
    end,
  })

  self:AddRule({
    name = "RequiresAlone",
    description = "Traduz 'Requires' isolado",
    category = "Messages",
    priority = 65,
    pattern = "^Requires$",
    handler = function(self)
      return "Requer"
    end,
  })

  self:AddRule({
    name = "Unavailable",
    description = "Traduz 'Unavailable'",
    category = "Messages",
    priority = 65,
    pattern = "^Unavailable$",
    handler = function(self)
      return "Indisponível"
    end,
  })

  self:AddRule({
    name = "Available",
    description = "Traduz 'Available'",
    category = "Messages",
    priority = 65,
    pattern = "^Available$",
    handler = function(self)
      return "Disponível"
    end,
  })

  self:AddRule({
    name = "Completed",
    description = "Traduz 'Completed'",
    category = "Messages",
    priority = 65,
    pattern = "^Completed$",
    handler = function(self)
      return "Concluído"
    end,
  })

  self:AddRule({
    name = "Incomplete",
    description = "Traduz 'Incomplete'",
    category = "Messages",
    priority = 65,
    pattern = "^Incomplete$",
    handler = function(self)
      return "Incompleto"
    end,
  })

  -- ========================================================================
  -- CATEGORIA: Quests (prioridade 60)
  -- ========================================================================

  self:AddRule({
    name = "KillBossBeforeLevel",
    description = "Traduz 'You must kill [Boss] before reaching level N.'",
    category = "Quests",
    priority = 60,
    pattern = "You must kill (.+) before reaching level (%d+)",
    handler = function(self, boss, level)
      return string.format("Você deve derrotar %s antes de atingir o nível %s.", boss, level)
    end,
  })

  -- ========================================================================
  -- CATEGORIA: System (prioridade 50)
  -- ========================================================================

  self:AddRule({
    name = "YouHaveCollected",
    description = "Traduz 'You have collected' genérico",
    category = "System",
    priority = 50,
    pattern = "^You have collected (.+)",
    handler = function(self, item)
      return string.format("Você coletou %s", item)
    end,
  })

  self:AddRule({
    name = "YouHaveLearned",
    description = "Traduz 'You have learned' genérico",
    category = "System",
    priority = 50,
    pattern = "^You have learned (.+)",
    handler = function(self, item)
      return string.format("Você aprendeu %s", item)
    end,
  })

  -- Compila tudo
  self:Compile()
end

-- ============================================================================
-- TESTES
-- ============================================================================

--- Executa a suíte de testes para validar as regras.
--- Cada teste contém { input, expected }.
function PatternDictionary:RunTests()
  if not self.compiled then
    self:Compile()
  end

  local tests = {
    -- Items
    { input = "Requires Level 60", expected = "Requer nível 60" },
    { input = "Required Level: 60", expected = "Requer nível: 60" },
    { input = "Required Level 60", expected = "Requer nível: 60" },
    { input = "Item Level 200", expected = "Nível do item 200" },
    { input = "Durability 75 / 75", expected = "Durabilidade 75 / 75" },
    { input = "Sell Price: 1 23 45", expected = "Preço de venda: 1 23 45" },
    { input = "Buy Price: 5 67 89", expected = "Preço de compra: 5 67 89" },
    { input = "Cooldown: 2 min", expected = "Recarga: 2 min" },
    { input = "Charges: 3", expected = "Cargas: 3" },
    { input = "Unique", expected = "Único" },
    { input = "Unique-Equipped", expected = "Único - Equipado" },
    { input = "Bind on Pickup", expected = "Ligado ao pegar" },
    { input = "Bind on Equip", expected = "Ligado ao equipar" },
    { input = "Soulbound", expected = "Ligado" },

    -- Equipment
    { input = "Equip:", expected = "Equipar:" },
    { input = "Equip", expected = "Equipar" },
    { input = "Use:", expected = "Usar:" },
    { input = "Use", expected = "Usar" },
    { input = "Chance on hit:", expected = "Chance ao acertar" },
    { input = "Chance on hit: +10 Strength", expected = "Chance ao acertar: +10 Strength" },

    -- Stats (+N)
    { input = "+12 Strength", expected = "+12 de Força" },
    { input = "+15 Agility", expected = "+15 de Agilidade" },
    { input = "+20 Intellect", expected = "+20 de Intelecto" },
    { input = "+18 Spirit", expected = "+18 de Espírito" },
    { input = "+25 Stamina", expected = "+25 de Vigor" },
    { input = "+500 Armor", expected = "+500 de Armadura" },
    { input = "+30 Hit Rating", expected = "+30 de índice de acerto" },
    { input = "+28 Critical Strike Rating", expected = "+28 de índice de acerto crítico" },
    { input = "+35 Haste Rating", expected = "+35 de índice de aceleração" },
    { input = "+20 Expertise Rating", expected = "+20 de índice de perícia" },
    { input = "+100 Spell Power", expected = "+100 de poder dos feitiços" },
    { input = "+40 Armor Penetration", expected = "+40 de penetração de armadura" },
    { input = "+30 Spell Penetration", expected = "+30 de penetração de feitiços" },
    { input = "+12 Mana Regen", expected = "+12 de regeneração de mana" },
    { input = "+8 Health Regen", expected = "+8 de regeneração de vida" },
    { input = "+50 Attack Power", expected = "+50 de poder de ataque" },
    { input = "+10 PvE Power", expected = "+10 de Poder PvE" },
    { input = "+15 PvP Power", expected = "+15 de Poder PvP" },
    { input = "+5% Movement Speed", expected = "+5% de velocidade de movimento" },
    { input = "+2% Crit Chance", expected = "+2% de chance crítica" },
    { input = "+1% Dodge", expected = "+1% de Esquiva" },
    { input = "+1% Parry", expected = "+1% de Aparo" },
    { input = "+1% Block", expected = "+1% de Bloqueio" },

    -- Tooltips - Increases
    { input = "Increases PvE Power by 20.", expected = "Aumenta em 20 o seu Poder PvE." },
    { input = "Increases PvE Power by 20", expected = "Aumenta em 20 o seu Poder PvE." },
    { input = "Increases PvP Power by 15.", expected = "Aumenta em 15 o seu Poder PvP." },
    { input = "Increases PvE and PvP Power by 10.", expected = "Aumenta em 10 o seu Poder PvE e PvP." },
    { input = "Increases PvE Power by up to 5%.", expected = "Aumenta em até 5% o seu Poder PvE." },
    { input = "Increases Hit Rating by 20.", expected = "Aumenta em 20 o seu Hit Rating." },
    { input = "Increases your Hit Rating by 20.", expected = "Aumenta em 20 o seu Hit Rating." },
    { input = "Increases Critical Strike Rating by 15.", expected = "Aumenta em 15 o seu Critical Strike Rating." },
    { input = "Increases Spell Power by 50.", expected = "Aumenta em 50 o seu Spell Power." },
    { input = "Increases damage by 5%.", expected = "Aumenta o dano causado em 5%." },
    { input = "Increases healing by 3%.", expected = "Aumenta a cura realizada em 3%." },

    -- Tooltips - Reduces
    { input = "Reduces damage by 2%.", expected = "Reduz o dano recebido em 2%." },
    { input = "Reduces Hit Rating by 10.", expected = "Reduz em 10 o seu Hit Rating." },
    { input = "Reduces your Hit Rating by 10.", expected = "Reduz em 10 o seu Hit Rating." },

    -- Tooltips - Restores
    { input = "Restores 500 Mana.", expected = "Restaura 500 de Mana." },
    { input = "Restores 200 Health.", expected = "Restaura 200 de Vida." },
    { input = "Restores 10 Rage.", expected = "Restaura 10 de Raiva." },
    { input = "Restores 20 Energy.", expected = "Restaura 20 de Energia." },

    -- Sockets
    { input = "Meta Socket", expected = "Encaixe Meta" },
    { input = "Red Socket", expected = "Encaixe Vermelho" },
    { input = "Yellow Socket", expected = "Encaixe Amarelo" },
    { input = "Blue Socket", expected = "Encaixe Azul" },
    { input = "Prismatic Socket", expected = "Encaixe Prismático" },
    { input = "Socket Bonus: +8 Spell Power", expected = "Bônus do encaixe: +8 Spell Power" },

    -- Set / Equip Bonus
    { input = "Set Bonus:", expected = "Bônus de conjunto" },
    { input = "Equip Bonus:", expected = "Bônus ao equipar" },
    { input = "Gem: Perfect Ruby", expected = "Gema: Perfect Ruby" },
    { input = "Enchant: Glowing Rune", expected = "Encantamento: Glowing Rune" },

    -- Messages
    { input = "Requires", expected = "Requer" },
    { input = "Unavailable", expected = "Indisponível" },
    { input = "Available", expected = "Disponível" },
    { input = "Completed", expected = "Concluído" },
    { input = "Incomplete", expected = "Incompleto" },

    -- Interface
    { input = "(Click Here)", expected = "(Clique aqui!)" },
    { input = "(Click Here!)", expected = "(Clique aqui!)" },
    { input = "You have learned a new spell.", expected = "Você aprendeu um novo feitiço." },
    { input = "You have learned a new spell", expected = "Você aprendeu um novo feitiço." },
    { input = "You have collected this appearance.", expected = "Você coletou esta aparência." },
    { input = "You have collected this appearance", expected = "Você coletou esta aparência." },

    -- Quests
    { input = "You must kill Ragnaros before reaching level 60", expected = "Você deve derrotar Ragnaros antes de atingir o nível 60." },

    -- System (genéricos, não capturados por regras mais específicas)
    { input = "You have learned Powerful Smite", expected = "Você aprendeu Powerful Smite" },
    { input = "You have collected 5 Gold", expected = "Você coletou 5 Gold" },
  }

  print("============================================================================")
  print("  PatternDictionary - Suíte de Testes")
  print(string.format("  Versão: %s", self.Version))
  print("============================================================================")

  local passed = 0
  local failed = 0
  local total = #tests

  for i, test in ipairs(tests) do
    local result = self:Translate(test.input)
    if result == test.expected then
      passed = passed + 1
    else
      failed = failed + 1
      print(string.format("  [FALHOU] #%d: %s", i, test.name or ""))
      print(string.format("    Input:    '%s'", test.input))
      print(string.format("    Esperado: '%s'", test.expected))
      print(string.format("    Obtido:   '%s'", result))
    end
  end

  print("============================================================================")
  print(string.format("  Resultado: %d de %d testes passaram", passed, total))
  if failed > 0 then
    print(string.format("  FALHAS: %d", failed))
  end
  print("============================================================================")

  return passed == total
end

-- Constrói o dicionário ao carregar
PatternDictionary:Build()

return PatternDictionary
