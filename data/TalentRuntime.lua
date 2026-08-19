local AES = AscensionPTBR or {}
AscensionPTBR = AES
local Runtime = AES.Runtime

local function TalentEnabled()
    local d = AscensionPTBRDB
    return not d or d.spells ~= false
end

-- Camada dedicada às árvores de classe, especialização e raça do CoA.
-- O painel do Ascension redesenha nomes e descrições depois de aberto; por
-- isso cada FontString relevante é traduzido no SetText e SetFormattedText.
local talentUIFSHooked = setmetatable({}, { __mode = "k" })
local talentUIRootHooked = setmetatable({}, { __mode = "k" })
local inTalentUIHook = false

local TALENT_UI_ROOT_NAMES = {
    "CharacterAdvancement", "CharacterAdvancementFrame",
    "AscensionCharacterAdvancement", "AscensionCharacterAdvancementFrame",
    "ClassTalentFrame", "PlayerTalentFrame", "TalentFrame",
    "RaceTalentFrame", "RacialTalentFrame", "AscensionRaceTalentFrame",
    "SpecializationFrame", "AscensionSpecializationFrame",
    "MentorFrame", "MentorSpecializationFrame", "AscensionMentorFrame",
    "ConquestCharacterFrame", "CoACharacterFrame", "HeroClassFrame",
    "SkillCardsFrame", "PathToAscensionFrame",
}

local function TranslateTalentDescriptionText(text)
    return AES.TranslateDescriptionString and AES.TranslateDescriptionString(text) or nil
end

-- Alguns nomes chegavam pretraduzidos pelo dicionario de UI do servidor antes
-- deste modulo receber o texto. Indexamos somente essas tabelas de interface e
-- restauramos o nome ingles no painel, sem tocar no corpo das descricoes.
local talentSpellPT2EN
local function CleanTalentLabel(text)
    if type(text) ~= "string" then return nil end
    return text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
        :gsub("^%s+", ""):gsub("%s+$", "")
end

local function GetTalentSpellPT2EN()
    if talentSpellPT2EN then return talentSpellPT2EN end
    talentSpellPT2EN = {}
    -- RuntimeCorrections captura as variantes que eram traduzidas antes de
    -- neutralizar os nomes. Elas precisam ser conhecidas aqui porque alguns
    -- paineis do servidor conservam o texto antigo ate serem redesenhados.
    for translated, source in pairs(AES.SpellNamePT2EN or {}) do
        if type(translated) == "string" and type(source) == "string" then
            talentSpellPT2EN[translated] = source
        end
    end
    local function add(source, translated)
        if type(source) ~= "string" or type(translated) ~= "string" then return end
        local en = CleanTalentLabel(source)
        local pt = CleanTalentLabel(translated)
        en = en and en:match("^([^\n]+)")
        pt = pt and pt:match("^([^\n]+)")
        if en and pt and AES.NameToIDs and AES.NameToIDs[en] and not talentSpellPT2EN[pt] then
            talentSpellPT2EN[pt] = en
        end
    end
    for _, dictionary in ipairs({ AES.ServerUI, AES.TalentUIExact, AES.CustomUI }) do
        for source, translated in pairs(dictionary or {}) do add(source, translated) end
    end
    return talentSpellPT2EN
end

local function RestoreTalentSpellName(text)
    if AES.RestoreOriginalSpellNameText then
        local restored = AES.RestoreOriginalSpellNameText(text)
        if restored and restored ~= text then return restored end
    end
    local plain = CleanTalentLabel(text)
    if not plain then return nil end
    local reverse = GetTalentSpellPT2EN()
    local direct = reverse[plain]
    if direct then return direct end
    local title, detail = plain:match("^([^\n]+)\n(.+)$")
    if title and detail and reverse[title]
        and detail:match("^%s*([Nn][ií]vel|[Gg]rau|[Ll]evel|[Rr]ank)%s+%d+") then
        return reverse[title] .. "\n" .. detail
    end
    return nil
end

local function TranslateTalentUIText(text)
    if not TalentEnabled() or type(text) ~= "string" or text == "" then return nil end
    local restored = RestoreTalentSpellName(text)
    if restored and restored ~= text then return restored end
    -- Esta tela mistura nomes e descricoes no mesmo fluxo. Nomes exatos (ou
    -- nome + nivel) nunca devem ser localizados; apenas o corpo explicativo.
    if AES.IsOriginalSpellName and AES.IsOriginalSpellName(text) then return nil end
    local exact = AES.TalentUIExact and AES.TalentUIExact[text]
    if exact and exact ~= text then return exact end
    local static = AES.TranslateStaticText and AES.TranslateStaticText(text)
    if static and static ~= text then return static end
    return TranslateTalentDescriptionText(text)
end
AES.TranslateTalentUIText = TranslateTalentUIText

local function HookTalentUIFS(fs)
    if not (fs and fs.SetText) or talentUIFSHooked[fs] then return end
    talentUIFSHooked[fs] = true
    for _, method in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[method] then
            pcall(hooksecurefunc, fs, method, function(self)
                if inTalentUIHook or not TalentEnabled() then return end
                local text = self.GetText and self:GetText()
                local pt = text and TranslateTalentUIText(text)
                if pt and pt ~= text then
                    inTalentUIHook = true
                    pcall(self.SetText, self, pt)
                    inTalentUIHook = false
                end
            end)
        end
    end
end

local function WalkTalentUI(root, depth, seen)
    if not root then return end
    depth = depth or 0
    if depth > 12 then return end
    seen = seen or {}
    if seen[root] then return end
    seen[root] = true

    if root.GetRegions then
        local ok, regions = pcall(function() return { root:GetRegions() } end)
        if ok then
            for _, region in ipairs(regions) do
                if region and region.IsObjectType and region:IsObjectType("FontString") then
                    HookTalentUIFS(region)
                    local text = region.GetText and region:GetText()
                    local pt = text and TranslateTalentUIText(text)
                    if pt and pt ~= text then pcall(region.SetText, region, pt) end
                end
            end
        end
    end
    if root.GetChildren then
        local ok, children = pcall(function() return { root:GetChildren() } end)
        if ok then
            for _, child in ipairs(children) do WalkTalentUI(child, depth + 1, seen) end
        end
    end
end

local function ApplyTalentGlobalStrings()
    for name, translated in pairs(AES.TalentUIGlobals or {}) do
        if type(rawget(_G, name)) == "string" then rawset(_G, name, translated) end
    end
end

local function HookTalentRoots()
    for _, name in ipairs(TALENT_UI_ROOT_NAMES) do
        local root = _G[name]
        if root and root.HookScript and not talentUIRootHooked[root] then
            talentUIRootHooked[root] = true
            local hookedRoot = root
            hookedRoot:HookScript("OnShow", function()
                if TalentEnabled() then pcall(WalkTalentUI, hookedRoot, 0, {}) end
            end)
        end
    end
end

local talentPassPending = false
local function TranslateTalentChrome()
    if not TalentEnabled() then return end
    ApplyTalentGlobalStrings()
    HookTalentRoots()
    local seen = {}
    for _, name in ipairs(TALENT_UI_ROOT_NAMES) do
        local root = _G[name]
        if root then pcall(WalkTalentUI, root, 0, seen) end
    end
end
AES.TranslateTalentChrome = TranslateTalentChrome

local function DelayedTalentPass()
    if talentPassPending then return end
    talentPassPending = true
    TranslateTalentChrome()
    Runtime.After("talent-visible-pass", 0.2, function()
        talentPassPending = false
        TranslateTalentChrome()
    end)
end

local HookTalentAPIs

local talentEventFrame = CreateFrame("Frame")
for _, event in ipairs({ "ADDON_LOADED", "PLAYER_ENTERING_WORLD", "PLAYER_TALENT_UPDATE",
                          "CHARACTER_POINTS_CHANGED", "ACTIVE_TALENT_GROUP_CHANGED",
                          "SPELLS_CHANGED", "LEARNED_SPELL_IN_TAB" }) do
    pcall(talentEventFrame.RegisterEvent, talentEventFrame, event)
end
talentEventFrame:SetScript("OnEvent", function()
    HookTalentAPIs()
    DelayedTalentPass()
end)

-- Nunca envolva as APIs de dados do Character Advancement. Alguns servidores
-- usam as strings retornadas como chaves internas de filtro e de disponibilidade;
-- localiza-las aqui pode esconder habilidades da lista. A camada visual acima e
-- os hooks de tooltip do Core traduzem somente a descricao que o jogador abriu,
-- preservando integralmente nomes, campos e resultados fornecidos pelo servidor.
HookTalentAPIs = function()
    -- Intencionalmente vazio: somente a interface visivel e traduzida.
end
AES.HookTalentAPIs = HookTalentAPIs
HookTalentAPIs()
