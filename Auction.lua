-- Pesquisa de itens em pt-BR na Casa de Leiloes.
-- Adaptada da ideia introduzida em GabrielBosco/AscensionPTBR 1.5.0.
-- Usa o indice criado junto com ItemNameEN2PT no carregamento do Core, evitando
-- uma segunda varredura do banco de itens ou buscas lineares durante o jogo.

local A = AscensionPTBR or {}
AscensionPTBR = A

local originalQueryAuctionItems
local hookInstalled = false

local function compact(text)
    if type(text) ~= "string" then return nil end
    text = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    text = text:match("^%s*(.-)%s*$") or ""
    return text:gsub("%s+", " ")
end

local function resolveAuctionSearchName(text)
    local clean = compact(text)
    if not clean or clean == "" then return nil end
    local translated = A.ItemNamePT2EN and A.ItemNamePT2EN[clean:lower()]
    return type(translated) == "string" and translated or nil
end

A.ResolveAuctionSearchName = resolveAuctionSearchName

local function queryAuctionItemsPTBR(name, ...)
    local serverName = resolveAuctionSearchName(name)
    return originalQueryAuctionItems(serverName or name, ...)
end

local function installAuctionSearchHook()
    if hookInstalled then return true end
    if type(_G.QueryAuctionItems) ~= "function" then return false end
    originalQueryAuctionItems = _G.QueryAuctionItems
    _G.QueryAuctionItems = queryAuctionItemsPTBR
    hookInstalled = true
    return true
end

if not installAuctionSearchHook() then
    local loader = CreateFrame("Frame")
    loader:RegisterEvent("PLAYER_LOGIN")
    loader:SetScript("OnEvent", function(self)
        if installAuctionSearchHook() then self:UnregisterEvent("PLAYER_LOGIN") end
    end)
end
