local APT = AscensionPTBR or {}
AscensionPTBR = APT

APT.SpellNameEN2PT = APT.SpellNameEN2PT or {}
APT.NameToIDs      = APT.NameToIDs or {}
APT.DescPairs      = APT.DescPairs or {}
APT.DescByPrefix   = APT.DescByPrefix or {}
APT.DescByID       = APT.DescByID or {}
APT.TipPairs       = APT.TipPairs or {}
APT.TipByID        = APT.TipByID or {}
APT.RankEN2PT      = APT.RankEN2PT or {}
APT.ItemName       = APT.ItemName or {}
APT.ItemNameEN     = APT.ItemNameEN or {}
APT.ItemDesc       = APT.ItemDesc or {}
APT.ItemDescEN     = APT.ItemDescEN or {}
APT.QuestTitle     = APT.QuestTitle or {}
APT.QuestTitleEN   = APT.QuestTitleEN or {}
APT.QuestData      = APT.QuestData or {}
APT.UnitName       = APT.UnitName or {}
APT.UnitNameEN     = APT.UnitNameEN or {}
APT.UnitSub        = APT.UnitSub or {}
APT.UnitSubEN      = APT.UnitSubEN or {}
APT.LinePatterns   = APT.LinePatterns or {}
APT.ValueWords     = APT.ValueWords or {}
APT.UIStrings      = APT.UIStrings or {}
APT.AchName        = APT.AchName or {}
APT.AchNameEN      = APT.AchNameEN or {}
APT.AchDesc        = APT.AchDesc or {}
APT.AchDescEN      = APT.AchDescEN or {}
APT.AchReward      = APT.AchReward or {}
APT.AchRewardEN    = APT.AchRewardEN or {}
APT.TalentUIExact  = APT.TalentUIExact or {}
APT.TalentUIGlobals = APT.TalentUIGlobals or {}

-- Aliases para compatibilidade com TalentRuntime.lua e QuestUI
APT.SpellNameEN2ES  = APT.SpellNameEN2PT
APT.QuestTitleEN2ES = APT.QuestTitleEN2PT

local db

local defaults = { spells = true, items = true, units = true, patterns = true, flavor = true,
                   ui = true, achievements = true, quests = true, gossip = true }

-- O proprio cliente usa estas constantes ao montar o rodape de itens. Defini-las
-- aqui evita a disputa entre atualizacoes nativas do tooltip e SetText do addon,
-- que fazia "Sell Price" alternar visualmente entre ingles e portugues.
SELL_PRICE = "Preco de venda:"
SALE_PRICE_COLON = "Preco de venda:"

-- Nomes de habilidades ficam no idioma original; somente os textos
-- explicativos sao localizados. Estas entradas vinham da camada de UI.
if APT.ServerUI then
    APT.ServerUI["|cffa336edDark Apotheosis|r"] = nil
    APT.ServerUI["Dark Apotheosis"] = nil
end

local function TranslateValue(v)
    local w = APT.ValueWords
    if w[v] then return w[v] end
    if APT.SpellNameEN2PT[v] then return APT.SpellNameEN2PT[v] end
    local num, word = v:match("^([%d%.,]+) (.+)$")
    if num and w[word] then return num .. " " .. w[word] end
    return v
end

local function ApplyTemplate(output, caps)
    return (output:gsub("{{(%d+)}}", function(n)
        local c = caps[tonumber(n)]
        if c == nil then return "" end
        return TranslateValue(c)
    end))
end

local subPatternCache = {}

local function SegmentPattern(anchored)
    local sub = subPatternCache[anchored]
    if sub == nil then
        sub = anchored
        if sub:sub(1, 1) == "^" then sub = sub:sub(2) end
        if sub:sub(-4) == "%s*$" then sub = sub:sub(1, -5) end
        subPatternCache[anchored] = sub
    end
    return sub
end

local function MatchPair(text, pair)
    local work = text
    local caps = { work:match(pair[1]) }
    if caps[1] == nil and (work:find("\r", 1, true) or work:find("|R", 1, true)) then
        work = work:gsub("\r", ""):gsub("|R", "|r")
        caps = { work:match(pair[1]) }
    end
    if caps[1] ~= nil then
        return ApplyTemplate(pair[2], caps)
    end

    local sub = SegmentPattern(pair[1])
    if #sub < 20 then return nil end
    local found = { work:find(sub) }
    local s, e = found[1], found[2]
    if not s or (e - s) < 15 then return nil end
    local segCaps = {}
    for i = 3, #found do segCaps[#segCaps + 1] = found[i] end
    if #segCaps == 0 then segCaps[1] = work:sub(s, e) end
    local translated = ApplyTemplate(pair[2], segCaps)
    return work:sub(1, s - 1) .. translated .. work:sub(e + 1)
end

local function TryPair(fs, text, pair)
    local nt = MatchPair(text, pair)
    if nt then
        pcall(fs.SetText, fs, nt)
        return true
    end
    return false
end

local function MatchPairSet(text, pairIndexes, pairsTable)
    if type(pairIndexes) == "number" then
        local pair = pairsTable[pairIndexes]
        return pair and MatchPair(text, pair) or nil
    end
    for _, idx in ipairs(pairIndexes) do
        local pair = pairsTable[idx]
        if pair then
            local nt = MatchPair(text, pair)
            if nt then return nt end
        end
    end
    return nil
end

local function NpcIdFromGUID(guid)
    if not guid then return nil end
    if guid:find("-", 1, true) then
        local unitType, rest = strsplit("-", guid, 2)
        if unitType == "Creature" or unitType == "Vehicle" or unitType == "Pet" then
            return tonumber((select(5, strsplit("-", rest))))
        end
    elseif guid:sub(1, 2) == "0x" then
        local hex = guid:sub(3)
        if #hex == 16 and hex:match("^F1[345]") then
            return tonumber(hex:sub(5, 10), 16)
        end
    end
    return nil
end

local function TooltipLines(tip)
    local name, lines = tip:GetName(), {}
    for i = 1, tip:NumLines() do
        local L = _G[name .. "TextLeft" .. i]
        local R = _G[name .. "TextRight" .. i]
        if L and L:GetText() then lines[#lines + 1] = L end
        if R and R:GetText() then lines[#lines + 1] = R end
    end
    return lines
end

local function TryPairSet(fs, text, pairIndexes, pairsTable)
    if type(pairIndexes) == "number" then
        local pair = pairsTable[pairIndexes]
        return pair and TryPair(fs, text, pair) or false
    end
    for _, idx in ipairs(pairIndexes) do
        local pair = pairsTable[idx]
        if pair and TryPair(fs, text, pair) then return true end
    end
    return false
end

local function TranslateBodyByPairs(tip, pairIndexes, pairsTable)
    if not pairIndexes then return end
    local name = tip:GetName()
    for i = 2, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if text and #text > 3 then
            if TryPairSet(fs, text, pairIndexes, pairsTable) then return true end
        end
    end
    return false
end

local function PrefijoDe(texto, cuantas)
    local s = texto:gsub("|c%x+", ""):gsub("|r", ""):gsub("|n", " ")
    local p, n = {}, 0
    for w in s:gmatch("%a+") do
        n = n + 1
        p[n] = w:lower()
        if n == cuantas then break end
    end
    return table.concat(p, " ")
end

local function TranslateBodyByPrefix(tip)
    local name = tip:GetName()
    local done = false
    for i = 2, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if text and #text > 12 then
            -- Bônus de conjuntos chegam como "(3) Set: ...". O índice da
            -- descrição começa no texto depois de "Set:", mas o matcher deve
            -- receber a linha inteira para preservar a contagem do conjunto.
            local lookup = text:gsub("^%s*%(%d+%)%s*[Ss]et:%s*", "")
            lookup = lookup:gsub("^%s*[Ss]et:%s*", "")
            for cuantas = 8, 3, -1 do
                local pref = PrefijoDe(lookup, cuantas)
                if #pref >= 8 then
                    local c = APT.DescByPrefix and APT.DescByPrefix[pref]
                    if c and TryPairSet(fs, text, c, APT.DescPairs) then
                        local shown = fs:GetText()
                        if shown then
                            local localized = shown:gsub("^(%s*%(%d+%)%s*)[Ss]et:%s*", "%1Conjunto: ")
                            localized = localized:gsub("^(%s*)[Ss]et:%s*", "%1Conjunto: ")
                            if localized ~= shown then pcall(fs.SetText, fs, localized) end
                        end
                        done = true
                        break
                    end
                    c = APT.TipByPrefix and APT.TipByPrefix[pref]
                    if c and TryPairSet(fs, text, c, APT.TipPairs) then
                        local shown = fs:GetText()
                        if shown then
                            local localized = shown:gsub("^(%s*%(%d+%)%s*)[Ss]et:%s*", "%1Conjunto: ")
                            localized = localized:gsub("^(%s*)[Ss]et:%s*", "%1Conjunto: ")
                            if localized ~= shown then pcall(fs.SetText, fs, localized) end
                        end
                        done = true
                        break
                    end
                end
            end
        end
    end
    return done
end
APT.TranslateBodyByPrefix = TranslateBodyByPrefix

local function TranslateSpellWord(w)
    local map = APT.SpellNameEN2PT
    return map[w] or map[w .. "s"] or (w:sub(-1) == "s" and map[w:sub(1, -2)]) or nil
end

local TranslateStaticText

local function MatchLinePatterns(text)
    local function apply(s)

        local exact = TranslateStaticText and TranslateStaticText(s)
        if exact then return exact end
        for _, p in ipairs(APT.LinePatterns) do
            if p[2] then
                local rep, n = s:gsub(p[1], p[2])
                if n > 0 and rep ~= s then return rep end
            end
        end
        -- Servidores diferentes podem enviar habilidades com IDs que nao
        -- existem na base. O dicionario cobre apenas frases mecanicas seguras
        -- e possui cache, portanto nao cria trabalho continuo na interface.
        local fallback = APT.TranslatePatternFallback
        if type(fallback) == "function" then
            local translated = fallback(s)
            if translated and translated ~= s then return translated end
        end
        return nil
    end
    local rep = apply(text)
    if rep then return rep end
    local pre, core, post = "", text, ""
    local peeling = true
    while peeling do
        peeling = false
        local sp, rest = core:match("^(%s+)(.*)$")
        if sp then pre, core, peeling = pre .. sp, rest, true end
        local c = core:match("^(|c%x%x%x%x%x%x%x%x)")
        if c then pre, core, peeling = pre .. c, core:sub(#c + 1), true end
        local body, spf = core:match("^(.-)(%s+)$")
        if spf then core, post, peeling = body, spf .. post, true end
        local bodyR = core:match("^(.-)|r$")
        if bodyR then core, post, peeling = bodyR, "|r" .. post, true end
    end
    if core ~= "" and core ~= text then
        rep = apply(core)
        if rep then return pre .. rep .. post end
    end
    return nil
end

APT.MatchRuntimeDescription = function(text)
    for _, pair in ipairs(APT.RuntimeDescriptionPairs or {}) do
        local captures = { text:match(pair[1]) }
        if #captures > 0 then
            return (pair[2]:gsub("{{(%d+)}}", function(index)
                return captures[tonumber(index)] or ""
            end))
        end
    end
end

local function TranslateMultilineText(text)
    local runtime = APT.MatchRuntimeDescription(text)
    if runtime then return runtime end
    local contexts = {}
    local lines = {}
    local touched = false
    for line in (text .. "\n"):gmatch("(.-)\n") do
        local l = line:gsub("\r", "")
        local icon, rest = l:match("^(%s*|T[^|]*|t%s*)(.+)$")
        local body = rest or l
        local pre, nm, post = body:match("^(%s*)(.-)(%s*)$")

        local c1, inner, c2 = "", nm or "", ""
        local wc1, winner, wc2 = (nm or ""):match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)$")
        if winner then
            c1, inner, c2 = wc1, winner, wc2
        end
        local key = (inner ~= "" and APT.SpellNameEN2PT[inner]) and inner
            or (nm and APT.SpellNameEN2PT[nm]) and nm or nil
        if key then
            local es = APT.SpellNameEN2PT[key]
            if key == inner then
                l = (icon or "") .. (pre or "") .. c1 .. es .. c2 .. (post or "")
            else
                l = (icon or "") .. (pre or "") .. es .. (post or "")
            end
            touched = true
        end
        local ctxKey = (inner ~= "" and APT.NameToIDs[inner] and inner)
            or (nm and APT.NameToIDs[nm] and nm) or nil
        if ctxKey then
            contexts[#contexts + 1] = APT.NameToIDs[ctxKey]
        end

        if not key then
            local rep = MatchLinePatterns(l)
            if rep then
                l = rep
                touched = true
            end
        end
        lines[#lines + 1] = l
    end
    local joined = table.concat(lines, "\n")
    for _, ctx in ipairs(contexts) do
        for _, id in ipairs(ctx) do
            for _, pt in ipairs({ { APT.TipByID[id], APT.TipPairs }, { APT.DescByID[id], APT.DescPairs } }) do
                if pt[1] then
                    local nt = MatchPairSet(joined, pt[1], pt[2])
                    if nt then
                        joined = nt
                        touched = true
                    end
                end
            end
        end
    end
    if touched and joined ~= text then
        return joined
    end
    return nil
end

local hookedEmbedFS = setmetatable({}, { __mode = "k" })
local inEmbedHook = false
local function HookEmbedFS(fs)
    if hookedEmbedFS[fs] or not fs.SetText then return end
    hookedEmbedFS[fs] = true
    hooksecurefunc(fs, "SetText", function(self, txt)
        if inEmbedHook or not db or not db.spells then return end
        if type(txt) ~= "string" or not txt:find("\n") then return end
        local nt = TranslateMultilineText(txt)
        if nt then
            inEmbedHook = true
            pcall(self.SetText, self, nt)
            inEmbedHook = false
        end
    end)
end

local function CollectTooltipFontStrings(tip)
    local tipName = tip and tip:GetName()
    if not tipName or not tip then return {} end

    local list = {}
    local lineCount = tip:NumLines() or 0
    for i = 1, lineCount do
        local left = _G[tipName .. "TextLeft" .. i]
        local right = _G[tipName .. "TextRight" .. i]
        if left and left:GetText() then list[#list + 1] = left end
        if right and right:GetText() then list[#list + 1] = right end
    end
    return list
end

-- Algumas fontes compactas usadas pelo cliente do Ascension cortam a parte
-- superior de glifos acentuados. Mantemos tamanho e contorno originais, mas
-- usamos a fonte padrão Friz Quadrata nas linhas que contêm caracteres PT-BR.
-- A troca é feita uma única vez por FontString.
local readablePTBRFontStrings = setmetatable({}, { __mode = "k" })
local function EnsureReadablePTBRFont(fs, text)
    if not fs or readablePTBRFontStrings[fs] or type(text) ~= "string"
        or not text:find("\195", 1, true) or not fs.GetFont or not fs.SetFont then
        return
    end
    local _, size, flags = fs:GetFont()
    if not size then return end
    local ok
    if flags and flags ~= "" then
        ok = pcall(fs.SetFont, fs, "Fonts\\FRIZQT__.TTF", size, flags)
    else
        ok = pcall(fs.SetFont, fs, "Fonts\\FRIZQT__.TTF", size)
    end
    if ok then readablePTBRFontStrings[fs] = true end
end

local QUEST_TOOLTIP_STATIC = {
    ["You are participating in this quest"] = "Você está participando desta missão",
    ["You are participating in this quest."] = "Você está participando desta missão.",
    ["You are not participating in this quest"] = "Você não está participando desta missão",
    ["You are not participating in this quest."] = "Você não está participando desta missão.",
    ["You do not meet the requirements for this quest"] = "Você não cumpre os requisitos desta missão",
    ["Requirements"] = "Requisitos",
    ["Requirements:"] = "Requisitos:",
}

local function TranslateQuestTooltipText(text)
    if not (db and db.quests) or type(text) ~= "string" or text == "" then return nil end
    local function render(v)
        return APT.QuestRenderPT and APT.QuestRenderPT(v) or v
    end
    local direct = (APT.QuestUIExact and APT.QuestUIExact[text])
        or QUEST_TOOLTIP_STATIC[text]
        or (APT.QuestTitleEN2PT and APT.QuestTitleEN2PT[text])
        or (APT.QuestObjectiveEN2PT and APT.QuestObjectiveEN2PT[text])
    if direct and direct ~= false then return render(direct) end
    local prefix, body = text:match("^(%s*[-•]%s*)(.-)%s*$")
    if body and body ~= "" then
        local translated = (APT.QuestUIExact and APT.QuestUIExact[body])
            or (APT.QuestTitleEN2PT and APT.QuestTitleEN2PT[body])
            or (APT.QuestObjectiveEN2PT and APT.QuestObjectiveEN2PT[body])
            or QUEST_TOOLTIP_STATIC[body]
        if translated and translated ~= false then return prefix .. render(translated) end
    end
    return nil
end

local inTooltipTranslate = false

local function TranslateTooltipLines(tip)
    if inTooltipTranslate or not db or not tip then return end
    inTooltipTranslate = true
    local ok, err = pcall(function()
    local tipName = tip:GetName()
    local first = _G[tipName .. "TextLeft1"]
    local firstText = first and first:GetText()
    local spellTitle = tip.GetSpell and tip:GetSpell()
    local firstQuestText = (not spellTitle) and firstText and TranslateQuestTooltipText(firstText)
    if firstQuestText then pcall(first.SetText, first, firstQuestText) end
    -- A primeira linha é o título e não faz parte de CollectTooltipFontStrings.
    -- Sem este passo, os tooltips ficavam com título em inglês e só o corpo
    -- era traduzido (ex.: Banco Pessoal, Desafios e Caminho da Ascensão).
    if not spellTitle and not firstQuestText and firstText and db.ui then
        local firstUI = (APT.CustomUI and APT.CustomUI[firstText])
            or (APT.UIStringsByEN and APT.UIStringsByEN[firstText])
            or (APT.ServerUI and APT.ServerUI[firstText])
        if firstUI and firstUI ~= firstText then pcall(first.SetText, first, firstUI) end
    end
    local contexts = {}
    local contextIds = nil
    for _, fs in ipairs(CollectTooltipFontStrings(tip)) do
        local text = fs and fs:GetText()
        if text and text ~= "" then
            local isSpellTitle = fs == first and spellTitle
            local changed = isSpellTitle and true or false

            local questText = TranslateQuestTooltipText(text)
            if questText then
                pcall(fs.SetText, fs, questText)
                text = questText
                changed = true
            end

            -- Textos de interface não dependem da opção de feitiços. Isso
            -- também cobre descrições de itens de conveniência do Ascension.
            if not changed and db.ui then
                local esUI = (APT.CustomUI and APT.CustomUI[text])
                    or (APT.UIStringsByEN and APT.UIStringsByEN[text])
                    or (APT.ServerUI and APT.ServerUI[text])
                if esUI and esUI ~= text then
                    pcall(fs.SetText, fs, esUI)
                    text = esUI
                    changed = true
                end
            end

            if db.spells and text:find("\n") then
                local nt = TranslateMultilineText(text)
                if nt then
                    pcall(fs.SetText, fs, nt)
                    text = nt
                    changed = false
                end
                HookEmbedFS(fs)
            end
            if db.spells then

                local icon, rest = text:match("^(|T.-|t%s*)(.+)$")
                local body = rest or text
                local pre, plainName, post = body:match("^(%s*)(.-)(%s*)$")

                local esCustom = db.ui and APT.CustomUI and plainName and APT.CustomUI[plainName]
                local esName = plainName and APT.SpellNameEN2PT[plainName]
                if esCustom then
                    pcall(fs.SetText, fs, (icon or "") .. (pre or "") .. esCustom .. (post or ""))
                    changed = true
                elseif esName then
                    pcall(fs.SetText, fs, (icon or "") .. (pre or "") .. esName .. (post or ""))
                    contextIds = APT.NameToIDs[plainName]
                    if contextIds then contexts[#contexts + 1] = contextIds end
                    changed = true
                elseif plainName and APT.NameToIDs[plainName] then
                    contextIds = APT.NameToIDs[plainName]
                    contexts[#contexts + 1] = contextIds
                end

                if not changed and db.ui then
                    local esUI = (APT.CustomUI and APT.CustomUI[text])
                        or (APT.UIStringsByEN and APT.UIStringsByEN[text])
                        or (APT.ServerUI and APT.ServerUI[text])
                    if esUI then
                        fs:SetText(esUI)
                        changed = true
                    end
                end

                if not changed and #contexts > 0 then
                    for _, ctx in ipairs(contexts) do
                        for _, id in ipairs(ctx) do
                            if (APT.TipByID[id] and TryPairSet(fs, text, APT.TipByID[id], APT.TipPairs))
                                or (APT.DescByID[id] and TryPairSet(fs, text, APT.DescByID[id], APT.DescPairs)) then
                                changed = true
                                break
                            end
                        end
                        if changed then break end
                    end
                end
            end
            if not changed and db.patterns then
                text = fs:GetText()

                local new = text
                for _, p in ipairs(APT.AnywherePlain or {}) do
                    local s = new:find(p[1], 1, true)
                    if s then
                        new = new:sub(1, s - 1) .. p[2] .. new:sub(s + #p[1])
                    end
                end
                new = new:gsub("Drains (%d+)%% Maximum Mana", "Drena %1%% da mana máxima")
                new = new:gsub("Applies (%d+) ([%a][%a%s':]*[%a])", function(n, aura)
                    return "Aplica " .. n .. " " .. (TranslateSpellWord(aura) or aura)
                end)
                new = new:gsub("Generates (%d+) ([%a][%a%s':]*[%a])", function(n, res)
                    return "Gera " .. n .. " " .. (TranslateSpellWord(res) or res)
                end)

                new = new:gsub("Restaura (%d+) health over (%d+) sec%.", "Restaura %1 p. de vida durante %2 s.")
                new = new:gsub("Restaura (%d+) mana over (%d+) sec%.", "Restaura %1 p. de mana durante %2 s.")
                new = new:gsub("Must remain seated while eating%.", "Você deve permanecer sentado enquanto come.")
                new = new:gsub("Must remain seated while drinking%.", "Você deve permanecer sentado enquanto bebe.")
                new = new:gsub("If you spend at least (%d+) seconds eating you will become well fed and gain (%d+) (%a+) and (%a+) for (%d+) min%.",
                    function(s, v, st1, st2, m)
                        local SW = { Stamina = "vigor", Spirit = "espírito", Intellect = "intelecto",
                                     Strength = "força", Agility = "agilidade" }
                        return "Se você passar pelo menos " .. s .. " s comendo, ficará bem alimentado e receberá "
                            .. v .. " p. de " .. (SW[st1] or TranslateSpellWord(st1) or st1)
                            .. " e " .. (SW[st2] or TranslateSpellWord(st2) or st2) .. " durante " .. m .. " min."
                    end)

                local function teachRepl(verb)
                    return function(thing)
                        local es = APT.SpellNameEN2PT[thing] or (APT.ItemNameEN2PT and APT.ItemNameEN2PT[thing]) or thing
                        return "Ensina a " .. verb .. " " .. es .. "."
                    end
                end
                new = new:gsub("Teaches you how to cook a delicious (.-)%.", teachRepl("cozinhar"))
                new = new:gsub("Teaches you how to (%a+) (.-)%.", function(verb, thing)
                    local V = { cook = "cozinhar", make = "fabricar", craft = "criar",
                                brew = "preparar", sew = "costurar", smelt = "fundir",
                                forge = "forjar", mix = "misturar", create = "criar",
                                conjure = "conjurar", cut = "lapidar", inscribe = "inscrever",
                                engrave = "gravar", transmute = "transmutar", summon = "evocar" }
                    local v = V[verb]
                    if not v then return nil end
                    return teachRepl(v)(thing)
                end)

                new = new:gsub("Rank (%d+)/(%d+)", "Grau %1/%2")
                new = new:gsub("Level: (%d+)", "Nível: %1")
                new = new:gsub("Lasts (%d+) sec?,? ?stacking (%d+) times", "Dura %1 s e acumula até %2 vezes")

                new = new:gsub("(|T[^|]*|t ?)([%a][%w' %-]+)", function(icon, nm)
                    local es = APT.SpellNameEN2PT[nm] or TranslateSpellWord(nm)
                    return icon .. (es or nm)
                end)

                new = new:gsub("Usable while in (|c%x%x%x%x%x%x%x%x)(%a[%a%s']*%a)(|r)", function(c, w, r)
                    return "Pode ser usado enquanto estiver em " .. c .. (TranslateSpellWord(w) or w) .. r
                end)
                new = new:gsub("Usable while in (%a[%a%s']*%a)", function(w)
                    return "Pode ser usado enquanto estiver em " .. (TranslateSpellWord(w) or w)
                end)

                new = new:gsub("^Requires (.+)$", function(list)
                    local parts = {}
                    for raw in list:gmatch("[^,]+") do
                        local w = raw:match("^%s*(.-)%s*$")
                        local lvl = w:match("^[Ll]evel (%d+)$")

                        local base, qty = w:match("^(.-)%s*%((%d+)%)$")
                        local core = base or w
                        local es = (lvl and ("nivel " .. lvl))
                            or (APT.ProfessionWords and APT.ProfessionWords[core])
                            or (APT.WeaponWords and APT.WeaponWords[core])
                            or TranslateSpellWord(core)
                            or (APT.ItemNameEN2PT and APT.ItemNameEN2PT[core])
                            or core
                        parts[#parts + 1] = es .. (qty and (" (" .. qty .. ")") or "")
                    end
                    return "Requer " .. table.concat(parts, ", ")
                end)

                do
                    local pre, preES
                    if new:sub(1, 9) == "Equipar: " then
                        pre, preES = "Equipar: ", "Equipar: "
                    elseif new:sub(1, 7) == "Equip: " then
                        pre, preES = "Equip: ", "Equipar: "
                    elseif new:sub(1, 6) == "Usar: " then
                        pre, preES = "Usar: ", "Uso: "
                    elseif new:sub(1, 5) == "Use: " then
                        pre, preES = "Use: ", "Uso: "
                    elseif new:sub(1, 19) == "Chance ao acertar: " then
                        pre, preES = "Chance ao acertar: ", "Chance ao acertar: "
                    elseif new:sub(1, 15) == "Chance on hit: " then
                        pre, preES = "Chance on hit: ", "Chance ao acertar: "
                    end
                    if pre and APT.TranslateSystemText then
                        local rest = new:sub(#pre + 1)

                        local body, cd = rest:match("^(.-)%s+(%(%d+ %a+%.? (?:Cooldown|Recarga)%)$)")
                        body = body or rest
                        local tr = APT.TranslateSystemText(body)
                        local cdES
                        if cd then
                            cdES = cd:gsub("%((%d+) Min (?:Cooldown|Recarga)%)", "(Recarga: %1 min)")
                            cdES = cdES:gsub("%((%d+) Sec (?:Cooldown|Recarga)%)", "(Recarga: %1 s)")
                            cdES = cdES:gsub("%((%d+) Hrs? (?:Cooldown|Recarga)%)", "(Recarga: %1 h)")
                            cdES = cdES:gsub("%((%d+) Days? (?:Cooldown|Recarga)%)", "(Recarga: %1 d)")
                        end
                        if tr ~= body or (cdES and cdES ~= cd) then
                            new = preES .. tr .. (cdES and (" " .. cdES) or "")
                        end
                    end
                end
                new = new:gsub("%((%d+)%s+[Mm]in%s+[Cc]ooldown%)", "(%1 min de recarga)")
                new = new:gsub("%((%d+)%s+[Ss]ec%s+[Cc]ooldown%)", "(%1 s de recarga)")
                new = new:gsub("%((%d+)%s+[Hh]rs?%s+[Cc]ooldown%)", "(%1 h de recarga)")
                new = new:gsub("%((%d+)%s+[Dd]ays?%s+[Cc]ooldown%)", "(%1 d de recarga)")
                if new ~= text then
                    fs:SetText(new)
                    text = new
                end

                local rep = MatchLinePatterns(text)
                if rep then
                    fs:SetText(rep)
                elseif APT.TranslateSystemTextStrict and not text:find("\n") then
                    local tr = APT.TranslateSystemTextStrict(text)
                    if tr ~= text then fs:SetText(tr) end
                end
            end
        end
    end

    if db.patterns then
        for i = 1, tip:NumLines() do
            local fs = _G[tipName .. "TextRight" .. i]
            local text = fs and fs:GetText()
            if text and text ~= "" then
                local rep = MatchLinePatterns(text)
                if rep then
                    fs:SetText(rep)
                elseif APT.TranslateSystemTextStrict and not text:find("\n") then
                    local tr = APT.TranslateSystemTextStrict(text)
                    if tr ~= text then fs:SetText(tr) end
                end
                if db.ui then
                    local esUI = (APT.CustomUI and APT.CustomUI[text])
                        or (APT.UIStringsByEN and APT.UIStringsByEN[text])
                        or (APT.ServerUI and APT.ServerUI[text])
                    if esUI then
                        fs:SetText(esUI)
                    end
                end
            end
        end
    end

    -- Aplica a normalização depois de todos os pares e padrões. Assim também
    -- alcança texto de item já traduzido por DescPairs e linhas do servidor.
    local normalizeTooltipText = APT.NormalizeTooltipText
    if type(normalizeTooltipText) == "function" then
        for i = 1, tip:NumLines() do
            local left = _G[tipName .. "TextLeft" .. i]
            local right = _G[tipName .. "TextRight" .. i]
            local function normalizeFontString(fs)
                local current = fs and fs.GetText and fs:GetText()
                local normalized = current and normalizeTooltipText(current)
                if normalized and normalized ~= current then
                    pcall(fs.SetText, fs, normalized)
                    current = normalized
                end
                EnsureReadablePTBRFont(fs, current)
            end
            normalizeFontString(left)
            normalizeFontString(right)
        end
    end

    end)
    inTooltipTranslate = false
    if not ok then return end
end

local ApplyLinePatterns = TranslateTooltipLines

local hookedFontStrings = setmetatable({}, { __mode = "k" })
local inAPTSet = false
local HookFSForTranslation

local latePassTip, latePassElapsed
local latePassDriver = CreateFrame("Frame")
local function RunLatePass(self, dt)
    if not latePassTip or not latePassTip:IsVisible() then
        latePassTip = nil
        latePassDriver:SetScript("OnUpdate", nil)
        return
    end
    latePassElapsed = (latePassElapsed or 0) + (dt or 0.02)
    if latePassElapsed < 0.08 then return end
    latePassElapsed = 0
    local nm = latePassTip:GetName()
    local ok, n = pcall(function() return latePassTip:NumLines() end)
    if ok and n then
        for i = 1, n do
            local fs = _G[nm .. "TextLeft" .. i]
            if fs and HookFSForTranslation then HookFSForTranslation(fs) end
            local fsr = _G[nm .. "TextRight" .. i]
            if fsr and HookFSForTranslation then HookFSForTranslation(fsr) end
        end
    end
    -- Alguns servidores preenchem o corpo do tooltip bem depois do evento
    -- inicial. Durante no maximo dois segundos, enquanto esta dica especifica
    -- fica aberta, reaplicamos as traducoes as linhas que acabaram de surgir.
    -- Fora desse intervalo nao existe varredura continua.
    pcall(APT.TranslateRuntimeSpellBody, latePassTip)
    pcall(TranslateTooltipLines, latePassTip)
    APT._latePassAttempts = (APT._latePassAttempts or 0) + 1
    if APT._latePassAttempts >= 25 then
        latePassTip = nil
        latePassDriver:SetScript("OnUpdate", nil)
    end
end

local function ScheduleLatePass(tip)
    if not (tip and tip.IsVisible) then return end
    latePassTip = tip
    latePassElapsed = 0
    APT._latePassAttempts = 0
    latePassDriver:SetScript("OnUpdate", RunLatePass)
end

local function SetWholeSpellTooltipBody(fields, translated)
    local lineCount = 0
    for line in (translated .. "\n"):gmatch("(.-)\n") do
        lineCount = lineCount + 1
        if fields[lineCount] then fields[lineCount]:SetText(line) end
    end
    -- Evita que a ultima linha antiga em ingles continue visivel quando a
    -- traducao possui menos linhas que a montagem original do cliente.
    for i = lineCount + 1, #fields do
        fields[i]:SetText("")
    end
    return true
end

local function MatchWholeSpellTooltipBody(text, spellID, englishName)
    local ids, seen = {}, {}
    local function addID(id)
        if id and not seen[id] then
            seen[id] = true
            ids[#ids + 1] = id
        end
    end

    addID(spellID)
    if englishName and APT.NameToIDs[englishName] then
        for _, id in ipairs(APT.NameToIDs[englishName]) do addID(id) end
    end

    for _, id in ipairs(ids) do
        local translated = APT.MatchExactPairSet(text, APT.DescByID[id], APT.DescPairs)
            or APT.MatchExactPairSet(text, APT.TipByID[id], APT.TipPairs)
        if translated and translated ~= text then return translated end
    end
end

APT.TranslateRuntimeSpellBody = function(tip, spellID, englishName)
    local name = tip and tip:GetName()
    if not name then return false end
    if not spellID and tip.GetSpell then
        local _, _, detectedID = tip:GetSpell()
        spellID = detectedID
    end
    if not englishName then
        local title = _G[name .. "TextLeft1"]
        englishName = title and title:GetText()
    end
    local lines, fields = {}, {}
    for i = 3, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if not text then return false end
        lines[#lines + 1] = text
        fields[#fields + 1] = fs
    end
    local source = table.concat(lines, "\n")
    local translated = MatchWholeSpellTooltipBody(source, spellID, englishName)
        or APT.MatchRuntimeDescription(source)
    if not translated then
        local changed = false
        for i, field in ipairs(fields) do
            local line = MatchLinePatterns(lines[i])
            if line and line ~= lines[i] then
                field:SetText(line)
                changed = true
            end
        end
        return changed
    end
    return SetWholeSpellTooltipBody(fields, translated)
end

local function OnSpellTooltip(tip)
    if not db or not db.spells then return end
    local _, _, spellID = tip:GetSpell()
    local name = tip:GetName()
    local L1 = _G[name .. "TextLeft1"]
    local enName = L1 and L1:GetText()

    local L2 = _G[name .. "TextLeft2"]
    local rankText = L2 and L2:GetText()
    if rankText and APT.RankEN2PT[rankText] then
        L2:SetText(APT.RankEN2PT[rankText])
    end

    APT.TranslateRuntimeSpellBody(tip, spellID, enName)
    if spellID and APT.DescByID[spellID] then
        TranslateBodyByPairs(tip, APT.DescByID[spellID], APT.DescPairs)
    end
    if enName and APT.NameToIDs[enName] then
        for _, id in ipairs(APT.NameToIDs[enName]) do
            if APT.DescByID[id] then
                TranslateBodyByPairs(tip, APT.DescByID[id], APT.DescPairs)
            end
            if APT.TipByID[id] then
                TranslateBodyByPairs(tip, APT.TipByID[id], APT.TipPairs)
            end
        end
    end

    pcall(TranslateBodyByPrefix, tip)

    ApplyLinePatterns(tip)
    ScheduleLatePass(tip)
end

local function OnAuraTooltip(tip, unit, index, filter)
    if not db or not db.spells then return end
    local spellID = select(11, UnitAura(unit, index, filter))
    local name = tip:GetName()
    local L1 = _G[name .. "TextLeft1"]
    local enName = L1 and L1:GetText()
    local translated = false
    if spellID and APT.TipByID[spellID] then
        translated = TranslateBodyByPairs(tip, APT.TipByID[spellID], APT.TipPairs)
    end
    if not translated and enName and APT.NameToIDs[enName] then
        for _, id in ipairs(APT.NameToIDs[enName]) do
            if APT.TipByID[id] and TranslateBodyByPairs(tip, APT.TipByID[id], APT.TipPairs) then
                break
            end
        end
    end

    ApplyLinePatterns(tip)
end

local function OnItemTooltip(tip)
    if not db or not db.items then return end
    local _, link = tip:GetItem()
    local itemID = link and tonumber(link:match("item:(%d+)"))
    local name = tip:GetName()
    if not itemID then return end

    if APT.ItemName[itemID] then
        local L1 = _G[name .. "TextLeft1"]
        local text = L1 and L1:GetText()
        local guard = APT.ItemNameEN[itemID]
        if text and text ~= "" then
            if (not guard) or guard == text then
                L1:SetText(APT.ItemName[itemID])
            elseif text:sub(1, #guard) == guard then

                local suf = text:sub(#guard + 1):match("^%s+(.-)%s*$")
                local sufES = suf and APT.SuffixWords and APT.SuffixWords[suf]
                if sufES then
                    L1:SetText(APT.ItemName[itemID] .. " " .. sufES)
                end
            end
        end
    end

    if itemID and GetItemSpell then
        local spellName = GetItemSpell(itemID)
        local sIds = spellName and APT.NameToIDs[spellName]
        if sIds then
            for i = 2, tip:NumLines() do
                local fs = _G[name .. "TextLeft" .. i]
                local t = fs and fs:GetText()
                if t and (t:find("^Use: ") or t:find("^Uso: ") or t:find("^Usar: ") or t:find("^Equip: ") or t:find("^Equipar: ") or t:find("^Chance on hit: ") or t:find("^Chance ao acertar: ")) then
                    local pref, body = t:match("^(%a+:%s*)(.+)$")
                    for _, sid in ipairs(sIds) do
                        if (APT.TipByID[sid] and TryPairSet(fs, t, APT.TipByID[sid], APT.TipPairs))
                            or (APT.DescByID[sid] and TryPairSet(fs, t, APT.DescByID[sid], APT.DescPairs)) then
                            break
                        end
                        if body then
                            local nt = MatchPairSet(body, APT.TipByID[sid], APT.TipPairs)
                                or MatchPairSet(body, APT.DescByID[sid], APT.DescPairs)
                            if nt then
                                pcall(fs.SetText, fs, pref .. nt)
                                break
                            end
                        end
                    end
                    break
                end
            end
        end
    end

    if db.flavor and itemID and APT.ItemDesc[itemID] then
        for i = 2, tip:NumLines() do
            local fs = _G[name .. "TextLeft" .. i]
            local text = fs and fs:GetText()
            if text and text:sub(1, 1) == '"' then
                local em = APT.ItemDescEN[itemID]

                local okGuard = not em
                if em then
                    local a = text:gsub("%s+", " ")
                    local b = ('"' .. em .. '"'):gsub("%s+", " ")
                    okGuard = (a == b)
                end
                if okGuard then
                    fs:SetText('"' .. APT.ItemDesc[itemID] .. '"')
                end
                break
            end
        end
    end

    pcall(TranslateBodyByPrefix, tip)
    ApplyLinePatterns(tip)
    ScheduleLatePass(tip)
end

local function OnUnitTooltip(tip)
    if not db then return end
    local _, unit = tip:GetUnit()
    local guid = unit and UnitGUID(unit)
    local npcID = db.units and NpcIdFromGUID(guid)
    if npcID then
        local name = tip:GetName()
        local L1 = _G[name .. "TextLeft1"]
        local text = L1 and L1:GetText()
        local guard = APT.UnitNameEN[npcID]
        if text and APT.UnitName[npcID] and (not guard or guard == text) then
            L1:SetText(APT.UnitName[npcID])
        end

        local L2 = _G[name .. "TextLeft2"]
        local t2 = L2 and L2:GetText()
        if t2 and APT.UnitSub[npcID] and not t2:match("^Level") and not t2:match("^Nivel") then
            local subGuard = APT.UnitSubEN[npcID]
            if not subGuard or subGuard == t2 then
                L2:SetText(APT.UnitSub[npcID])
            end
        end
    end

    ApplyLinePatterns(tip)
end

local function TranslateShortText(text)

    if APT.RankEN2PT[text] then return APT.RankEN2PT[text] end
    return MatchLinePatterns(text)
end

local function TranslateAscensionSpellButtons()
    local frame = AscensionSpellbookFrame
    local spells = frame and frame.Content and frame.Content.Spells
    if not spells then return end
    for i = 1, 12 do
        local b = spells["SpellButton" .. i]
        if b then
            local fs = b.SpellName
            local t = fs and fs:GetText()
            local es = t and APT.SpellNameEN2PT[t]
            if es then fs:SetText(es) end
            local sub = b.SubSpellName
            local st = sub and sub:GetText()
            if st and st ~= "" then
                local esSub = TranslateShortText(st)
                if esSub then sub:SetText(esSub) end
            end
        end
    end
end

-- Reparo direto das descricoes de feiticos exibidas pelo servidor. Alguns
-- servidores escrevem as linhas depois dos eventos normais de GameTooltip;
-- por isso este caminho revisa somente tooltips visiveis e somente sob demanda.
APT.RepairSpellbookTooltipText = function(text)
    if type(text) ~= "string" or text == "" then return nil end
    local repaired = text
    -- Versoes curtas: cada linha cabe no tooltip compacto do livro e no tooltip normal.
    repaired = repaired:gsub("Emanate an aura for ([%d]+) sec that", "Emana aura por %1 s:")
    repaired = repaired:gsub("grants party and raid members a", "grupo e raide:")
    repaired = repaired:gsub("([%d]+)%% chance when they cast a spell", "%1%% de chance ao lancarem")
    repaired = repaired:gsub("or ability to heal themselves for ([^%.]+)%.", "feitico/habilidade: cura %1.")
    repaired = repaired:gsub("reduces the resource costs of spells by ([%d]+)%%", "reduz o custo de recursos em %1%%")
    repaired = repaired:gsub("reduces the resource costs of spells", "reduz o custo de recursos")
    repaired = repaired:gsub("by ([%d]+)%% for party and raid members", "em %1%% para grupo e raide")
    repaired = repaired:gsub("for party and raid members within ([%d]+) yds", "para grupo e raide: raio de %1 m")
    repaired = repaired:gsub("within ([%d]+) yds%.?", "raio de %1 m.")
    repaired = repaired:gsub("While active, you generate ([%d]+) Focus every ([%d]+) sec%.", "Enquanto ativo: %1 Foco a cada %2 s.")
    repaired = repaired:gsub("While active, you generate ([%d]+) Focus", "Enquanto ativo: gera %1 Foco")
    repaired = repaired:gsub("every ([%d]+) sec%.?", "a cada %1 s.")
    repaired = repaired:gsub("Increase your chance to block and block value in ([%d%.,]+)%% during ([%d%.,]+) s%.", "Aumenta sua chance e valor de bloqueio em %1%% durante %2 s.")
    repaired = repaired:gsub("Increase your chance to block and block value by ([%d%.,]+)%% for ([%d%.,]+) s%.", "Aumenta sua chance e valor de bloqueio em %1%% durante %2 s.")
    repaired = repaired:gsub("Aumenta seu/sua chance to block and block value em ([%d%.,]+)%% durante ([%d%.,]+) s%.", "Aumenta sua chance de bloqueio e o valor de bloqueio em %1%% durante %2 s.")
    repaired = repaired:gsub("Your threat generated is significantly increased%.", "Sua ameaca gerada aumenta significativamente.")
    repaired = repaired:gsub("Teaches you%s+", "Ensina: ")
    repaired = repaired:gsub("Dark Apotheosis cannot cower behind a shield%.", "Dark Apotheosis: sem escudo.")
    repaired = repaired:gsub("Shields cannot be equipped while transformed%.", "Nao equipa escudos transformado.")
    repaired = repaired:gsub("Sua ameaca gerada aumenta significativamente%.", "Aumenta bastante a ameaca gerada.")
    repaired = repaired:gsub("Dark Apotheosis nao pode usar escudo%.", "Dark Apotheosis: sem escudo.")
    repaired = repaired:gsub("Escudos nao podem ser equipados durante a transformacao%.", "Nao equipa escudos transformado.")
    repaired = repaired:gsub("Ataca duas vezes, causando ([%d%.,]+) de dano Fisico por golpe%.", "Ataca 2 vezes: %1 de dano Fisico cada.")
    if repaired ~= text then return repaired end
    -- Tooltips customizados frequentemente acrescentam um rodape depois do
    -- corpo (SHIFT, modificadores, etc.). Retira-o apenas para a busca e o
    -- devolve intacto depois, permitindo que padroes completos sejam usados.
    local body, footer = text:match("^(.-)(\n\n|cff00DDFF.-|r)$")
    if not body then body, footer = text:match("^(.-)(\n\nThis uses .- modifiers%.)$") end
    if body and footer then
        footer = footer:gsub("This uses (.-) modifiers%.", "Usa modificadores de %1.")
        local bodyPattern = MatchLinePatterns(body)
        if bodyPattern and bodyPattern ~= body then return bodyPattern .. footer end
        local bodyTranslate = APT.TranslateDescriptionString
        local bodyTranslated = type(bodyTranslate) == "function" and bodyTranslate(body)
        if bodyTranslated and bodyTranslated ~= body then return bodyTranslated .. footer end
    end
    local linePattern = MatchLinePatterns(text)
    if linePattern and linePattern ~= text then return linePattern end
    -- Reusa os dicionarios completos para qualquer outra habilidade que chegue
    -- em um frame fora do fluxo normal de eventos.
    local translate = APT.TranslateDescriptionString
    local translated = type(translate) == "function" and translate(text)
    if translated and translated ~= text then return translated end
end

APT.ScanSpellbookTooltips = function()
    local frame = EnumerateFrames()
    local found = false
    while frame do
        local frameName = frame.GetName and frame:GetName()
        if frameName and frameName:find("Tooltip", 1, true) and frame.IsShown and frame:IsShown() then
            found = true
            -- O servidor pode preencher o corpo depois de OnTooltipSetSpell.
            -- Aqui o tooltip ja esta completo: tente primeiro os ~100 mil
            -- modelos de descricoes conhecidos, identificados pelo ID/nome do
            -- feitico, antes das regras genericas por linha.
            if type(APT.TranslateRuntimeSpellBody) == "function" then
                pcall(APT.TranslateRuntimeSpellBody, frame)
            end
            local fields, texts = {}, {}
            for _, region in ipairs({ frame:GetRegions() }) do
                if region and region.GetText and region.SetText then
                    local original = region:GetText()
                    if original and original ~= "" then
                        fields[#fields + 1] = region
                        texts[#texts + 1] = original
                    end
                end
            end
            -- O tooltip personalizado pode dividir uma descricao em varios
            -- FontStrings. Testamos blocos contiguos para pular titulo, rank
            -- e rodape e casar o corpo integral na base, sem depender do ID.
            local wholeTranslated = false
            for first = 1, #texts do
                for last = #texts, first, -1 do
                    local source = table.concat(texts, "\n", first, last)
                    local translated = APT.TranslateVisibleDescriptionExact(source)
                    if translated then
                        local targetFields = {}
                        for i = first, last do targetFields[#targetFields + 1] = fields[i] end
                        SetWholeSpellTooltipBody(targetFields, translated)
                        wholeTranslated = true
                        break
                    end
                end
                if wholeTranslated then break end
            end
            if not wholeTranslated then
                for _, region in ipairs(fields) do
                    local original = region:GetText()
                    local repaired = APT.RepairSpellbookTooltipText(original)
                    if repaired then
                        pcall(region.SetText, region, repaired)
                    elseif APT.RecordUnknownSpellDescription then
                        APT.RecordUnknownSpellDescription(original)
                    end
                end
            end
        end
        frame = EnumerateFrames(frame)
    end
    return found
end

APT.SpellbookRepairOnUpdate = function(self, elapsed)
    local spellbook = AscensionSpellbookFrame
    if not db or not db.spells or not spellbook or not spellbook:IsShown() then
        self:SetScript("OnUpdate", nil)
        return
    end
    APT._spellbookRepairElapsed = (APT._spellbookRepairElapsed or 0) + (elapsed or 0)
    if APT._spellbookRepairElapsed < 0.15 then return end
    APT._spellbookRepairElapsed = 0
    APT.ScanSpellbookTooltips()
end

APT._spellbookRepairDriver = APT._spellbookRepairDriver or CreateFrame("Frame")

-- Registra somente descricoes inglesas ainda desconhecidas. O WoW grava a
-- tabela de configuracao ao sair do jogo; ela permite gerar um lote completo
-- de novas traducoes depois, sem pedir screenshots um a um.
APT.RecordUnknownSpellDescription = function(text)
    if not db or type(text) ~= "string" or #text < 35 then return end
    local lower = text:lower()
    if not (lower:find(" damage", 1, true) or lower:find(" target", 1, true)
        or lower:find(" enemy", 1, true) or lower:find(" your ", 1, true)
        or lower:find(" dealing", 1, true) or lower:find(" causing", 1, true)
        or lower:find(" granting", 1, true) or lower:find(" increases", 1, true)) then return end
    db.UntranslatedSpellDescriptions = db.UntranslatedSpellDescriptions or {}
    if db.UntranslatedSpellDescriptions[text] then return end
    if (db.UntranslatedSpellDescriptionCount or 0) >= 12000 then return end
    db.UntranslatedSpellDescriptions[text] = true
    db.UntranslatedSpellDescriptionCount = (db.UntranslatedSpellDescriptionCount or 0) + 1
end

-- Busca exata independente do ID. Servidores alternativos nem sempre expõem
-- o ID do feitico ao addon, mas a base ja possui um indice pelo inicio de cada
-- descricao. O cache evita repetir a busca para o mesmo texto exibido.
APT.TranslateVisibleDescriptionExact = function(text)
    if type(text) ~= "string" or #text < 12 then return nil end
    APT._visibleDescriptionExactCache = APT._visibleDescriptionExactCache or {}
    local cached = APT._visibleDescriptionExactCache[text]
    if cached ~= nil then return cached or nil end
    local translated
    for words = 12, 3, -1 do
        local prefix = PrefijoDe(text, words)
        local indexes = prefix ~= "" and APT.DescByPrefix and APT.DescByPrefix[prefix]
        translated = indexes and APT.MatchExactPairSet and APT.MatchExactPairSet(text, indexes, APT.DescPairs)
        if translated and translated ~= text then break end
        indexes = prefix ~= "" and APT.TipByPrefix and APT.TipByPrefix[prefix]
        translated = indexes and APT.MatchExactPairSet and APT.MatchExactPairSet(text, indexes, APT.TipPairs)
        if translated and translated ~= text then break end
        translated = nil
    end
    if (APT._visibleDescriptionExactCacheSize or 0) >= 1024 then
        APT._visibleDescriptionExactCache = {}
        APT._visibleDescriptionExactCacheSize = 0
    end
    APT._visibleDescriptionExactCache[text] = translated or false
    APT._visibleDescriptionExactCacheSize = (APT._visibleDescriptionExactCacheSize or 0) + 1
    return translated
end

-- O mesmo reparo tambem vale para tooltips fora do livro (barra de acoes,
-- inventario, arvore de talentos etc.). Ele e iniciado pelo proprio tooltip e
-- para assim que nao houver tooltip visivel, sem varredura permanente da UI.
APT.VisibleTooltipRepairOnUpdate = function(self, elapsed)
    if not db or not db.spells then
        self:SetScript("OnUpdate", nil)
        return
    end
    APT._visibleTooltipRepairElapsed = (APT._visibleTooltipRepairElapsed or 0) + (elapsed or 0)
    if APT._visibleTooltipRepairElapsed < 0.12 then return end
    APT._visibleTooltipRepairElapsed = 0
    if not APT.ScanSpellbookTooltips() then
        self:SetScript("OnUpdate", nil)
    end
end

APT._visibleTooltipRepairDriver = APT._visibleTooltipRepairDriver or CreateFrame("Frame")
APT.StartVisibleTooltipRepair = function()
    if not db or not db.spells then return end
    APT._visibleTooltipRepairElapsed = 0
    APT._visibleTooltipRepairDriver:SetScript("OnUpdate", APT.VisibleTooltipRepairOnUpdate)
end

local function HookSpellbook()

    if type(SpellButton_UpdateButton) == "function" then
        hooksecurefunc("SpellButton_UpdateButton", function(self)
            if not db or not db.spells then return end
            local subFS = _G[self:GetName() .. "SubSpellName"]
            local sub = subFS and subFS:GetText()
            if sub and sub ~= "" then
                local esSub = TranslateShortText(sub)
                if esSub then subFS:SetText(esSub) end
            end
        end)
    end

    if AscensionSpellbookFrame and type(AscensionSpellbookFrame.UpdateSpells) == "function" then
        hooksecurefunc(AscensionSpellbookFrame, "UpdateSpells", function()
            if db and db.spells then TranslateAscensionSpellButtons() end
        end)
    end
    if AscensionSpellbookFrame and type(AscensionSpellbookFrame.UpdatePet) == "function" then
        hooksecurefunc(AscensionSpellbookFrame, "UpdatePet", function()
            if db and db.spells then TranslateAscensionSpellButtons() end
        end)
    end
end

local function ApplyUIStrings()
    -- Aplicar milhares de globais novamente a cada atualização provocava
    -- conflitos e custo desnecessário. Estas constantes são fontes estáveis
    -- usadas pelo próprio cliente para montar rótulos e sufixos de recarga. Ao
    -- localizá-las uma vez, o jogo deixa de alternar o texto com o hook.
    local stableGlobals = {
        "ROLL_DISENCHANT",
        "ITEM_COOLDOWN_TOTAL",
        "ITEM_COOLDOWN_TOTAL_DAYS",
        "ITEM_COOLDOWN_TOTAL_HOURS",
        "ITEM_COOLDOWN_TOTAL_MIN",
        "ITEM_COOLDOWN_TOTAL_SEC",
        "SAY_MESSAGE",
        "PARTY_MESSAGE",
        "RAID",
        "BATTLEGROUND",
        "BATTLEGROUND_LEADER",
        "GUILD_CHAT",
        "YELL_MESSAGE",
        "WHISPER",
        "EMOTE",
        "REPLY_MESSAGE",
        "LANGUAGE",
        "VOICEMACRO_LABEL",
    }
    local applied = 0
    for _, key in ipairs(stableGlobals) do
        local translated = APT.UIStrings and APT.UIStrings[key]
        if type(translated) == "string" and translated ~= "" then
            _G[key] = translated
            applied = applied + 1
        end
    end
    return applied
end

local function NormalizeStaticKey(text)
    if type(text) ~= "string" then return nil end
    return text:gsub("\r", "")
        :gsub("<br%s*/>", " ")
        :gsub("<br%s*>", " ")
        :gsub("<[^>]->", " ")
        :gsub("|c%x%x%x%x%x%x%x%x", "")
        :gsub("|r", "")
        :gsub("|H[^|]-|h(.-)|h", "%1")
        :gsub("\226\128\153", "'")
        :gsub("\194\160", " ")
        :gsub("%s+", " ")
        :gsub("^%s+", "")
        :gsub("%s+$", "")
end

local function RenderServerFragment(text)
    return text:gsub("\r", "")
        :gsub("<br%s*/>", "\n")
        :gsub("<br%s*>", "\n")
        :gsub("<[^>]->", "")
        :gsub("^%s+", "")
        :gsub("%s+$", "")
end

local function SplitServerParagraph(text)
    local parts = {}
    text = text:gsub("\r", "")
        :gsub("<br%s*/>", "\n")
        :gsub("<br%s*>", "\n")
    for part in (text .. "\n\n"):gmatch("(.-)\n%s*\n") do
        part = part:gsub("^%s+", ""):gsub("%s+$", "")
        if part ~= "" then parts[#parts + 1] = part end
    end
    return parts
end

local SERVER_UI_FRAGMENT_TAGS = { "h1", "p" }

local STATIC_TEXT_CACHE_MISS = {}
local staticTextCache = {}
local staticTextCacheSize = 0
local STATIC_TEXT_CACHE_LIMIT = 4096

local function TranslateStaticTextUncached(t)
    local es = (APT.TalentUIExact and APT.TalentUIExact[t])
        or (APT.CustomUI and APT.CustomUI[t])
        or (APT.ServerUI and APT.ServerUI[t])
        or (APT.UIStringsByEN and APT.UIStringsByEN[t])
    if es then return es end

    local base, tail = t:match("^(.-)%s*(:?)%s*$")
    if base and base ~= t and base ~= "" then
        es = (APT.TalentUIExact and APT.TalentUIExact[base])
            or (APT.CustomUI and APT.CustomUI[base])
            or (APT.ServerUI and APT.ServerUI[base])
            or (APT.UIStringsByEN and APT.UIStringsByEN[base])
        if es then return es .. (tail or "") end
    end

    local c0, inner, r0 = t:match("^(|c%x%x%x%x%x%x%x%x)(.-)(|r)%s*$")
    if inner and inner ~= "" and not inner:find("|c") then
        local es2 = (APT.TalentUIExact and APT.TalentUIExact[inner])
            or (APT.CustomUI and APT.CustomUI[inner])
            or (APT.ServerUI and APT.ServerUI[inner])
            or (APT.UIStringsByEN and APT.UIStringsByEN[inner])
        if es2 then return c0 .. es2 .. r0 end
    end

    local p1, p2 = t:match("^Page (%d+) of (%d+)$")
    if p1 then return "Página " .. p1 .. " de " .. p2 end

    local trialLevelPlain = NormalizeStaticKey(t)
    local currentTrialLevel = trialLevelPlain and trialLevelPlain:match("^Current Level:%s*(%d+)$")
    if currentTrialLevel then
        -- Preserva a cor aplicada ao número pelo cliente.
        return (t:gsub("Current Level:", "Nível atual:", 1))
    end

    -- Character-frame line built dynamically by the client. The race stays in
    -- its original form while the level and class are localized.
    local characterLevel, characterRace = t:match("^Level (%d+) (.-) Necromancer$")
    if characterLevel and characterRace and characterRace ~= "" then
        return "Nível " .. characterLevel .. " " .. characterRace .. " Necromante"
    end

    if APT.ServerUINoColor and t:find("|c", 1, true) then
        local limpio = t:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
        local es3 = APT.ServerUINoColor[limpio]
        if es3 then return es3 end
    end

    if not es then
        local normal = NormalizeStaticKey(t)
        local es4 = normal and ((APT.CustomUINorm and APT.CustomUINorm[normal])
            or (APT.ServerUIFragments and APT.ServerUIFragments[normal])
            or (APT.ServerUINorm and APT.ServerUINorm[normal]))
        if es4 then return es4 end
    end

    -- O servidor atualizou o texto introdutório do desafio Boss Blitz sem
    -- alterar as linhas dinâmicas dos chefes. Traduzimos o prefixo e mantemos
    -- nomes próprios e hyperlinks exatamente como o cliente os enviou.
    local trialIntroEN = "Seek out allies and delve into the deepest dungeons! Complete all Vanilla dungeons in order to overcome this savage Trial. The catch? You only have one life. Fall, and that member is out of the party. Will you overcome the darkest reaches of Azeroth and emerge victorious from the depths?"
    local trialIntroStart, trialIntroEnd = t:find(trialIntroEN, 1, true)
    if trialIntroStart then
        local trialIntroPT = "Reúna aliados e aventure-se nas masmorras mais profundas! Conclua todas as masmorras Vanilla para superar este Desafio implacável. O porém? Você só tem uma vida. Se cair, esse integrante ficará fora do grupo. Você conseguirá superar os confins mais sombrios de Azeroth e emergir vitorioso das profundezas?"
        local result = t:sub(1, trialIntroStart - 1) .. trialIntroPT .. t:sub(trialIntroEnd + 1)
        result = result:gsub("You must kill ", "Você deve derrotar ")
            :gsub(" before reaching level ", " antes de alcançar o nível ")
            :gsub("%(Click Here!%)", "(Clique aqui!)")
        return result
    end

    if not es and t:find("You must kill ", 1, true) and t:find(" before reaching level ", 1, true) and not t:find("Você deve derrotar") then
        local result = t:gsub("You must kill ", "Você deve derrotar ")
            :gsub(" before reaching level ", " antes de alcançar o nível ")
            :gsub("%(Click Here!%)", "(Clique aqui!)")
        return result
    end

    if db and db.spells and APT.SpellNameEN2PT and #t >= 4 and t:match("^%u") then
        local esSpell = APT.SpellNameEN2PT[t]
        if esSpell and esSpell ~= t then return esSpell end
    end

    return nil
end

-- O corpo inteiro de um tooltip nunca pode usar a busca parcial de MatchPair:
-- isso permite substituir apenas o comeco da descricao e esconder o restante.
-- Fica em APT para nao aumentar o limite de locais do arquivo Core.lua.
APT.MatchExactPairSet = function(text, pairIndexes, pairsTable)
    local function tryPair(pair)
        if not pair then return nil end
        local work = text
        local captures = { work:match(pair[1]) }
        if captures[1] == nil and (work:find("\r", 1, true) or work:find("|R", 1, true)) then
            work = work:gsub("\r", ""):gsub("|R", "|r")
            captures = { work:match(pair[1]) }
        end
        if captures[1] ~= nil then return ApplyTemplate(pair[2], captures) end
    end

    if type(pairIndexes) == "number" then
        return tryPair(pairsTable[pairIndexes])
    end
    for _, idx in ipairs(pairIndexes or {}) do
        local translated = tryPair(pairsTable[idx])
        if translated then return translated end
    end
    if AscensionSpellbookFrame and not APT._spellbookRepairHooked then
        APT._spellbookRepairHooked = true
        AscensionSpellbookFrame:HookScript("OnShow", function()
            APT._spellbookRepairElapsed = 0
            APT._spellbookRepairDriver:SetScript("OnUpdate", APT.SpellbookRepairOnUpdate)
        end)
        AscensionSpellbookFrame:HookScript("OnHide", function()
            APT._spellbookRepairDriver:SetScript("OnUpdate", nil)
        end)
        if AscensionSpellbookFrame:IsShown() then
            APT._spellbookRepairDriver:SetScript("OnUpdate", APT.SpellbookRepairOnUpdate)
        end
    end
end

function TranslateStaticText(t)
    if type(t) ~= "string" or t == "" then return nil end
    local cached = staticTextCache[t]
    if cached ~= nil then
        -- Em Lua, `condicao and nil or valor` sempre termina em `valor`.
        -- Portanto o sentinela precisa ser tratado explicitamente; caso
        -- contrário ele chega a FontString:SetText e apaga o texto exibido.
        if cached == STATIC_TEXT_CACHE_MISS then return nil end
        return cached
    end

    local translated = TranslateStaticTextUncached(t)
    if staticTextCacheSize >= STATIC_TEXT_CACHE_LIMIT then
        staticTextCache = {}
        staticTextCacheSize = 0
    end
    staticTextCache[t] = translated or STATIC_TEXT_CACHE_MISS
    staticTextCacheSize = staticTextCacheSize + 1
    return translated
end

APT.ClearStaticTextCache = function()
    staticTextCache = {}
    staticTextCacheSize = 0
end

APT.TranslateStaticText = TranslateStaticText

APT.TranslateDescriptionString = function(text)
    if type(text) ~= "string" or text == "" then return nil end
    local runtime = APT.MatchRuntimeDescription(text)
    if runtime then return runtime end
    if text:find("\n", 1, true) then
        local multi = TranslateMultilineText(text)
        if multi and multi ~= text then return multi end
    end
    for words = 8, 3, -1 do
        local pref = PrefijoDe(text, words)
        local indexes = pref ~= "" and APT.DescByPrefix and APT.DescByPrefix[pref]
        local translated = indexes and MatchPairSet(text, indexes, APT.DescPairs)
        if translated and translated ~= text then return translated end
        indexes = pref ~= "" and APT.TipByPrefix and APT.TipByPrefix[pref]
        translated = indexes and MatchPairSet(text, indexes, APT.TipPairs)
        if translated and translated ~= text then return translated end
    end
    local patternFallback = APT.TranslatePatternFallback
    if type(patternFallback) == "function" then
        local translated = patternFallback(text)
        if translated and translated ~= text then return translated end
    end
    return nil
end

local HookUIFS

local staticUIThrottle = 0
local function RetranslateStaticUI()
    if not db or not db.ui then return end
    local now = GetTime()
    if now < staticUIThrottle then return end
    staticUIThrottle = now + 0.25

    local frame = EnumerateFrames()
    while frame do
        local shown = frame.IsShown and frame:IsShown()
        if shown then
            local protected = frame.IsProtected and select(1, frame:IsProtected())
            local forbidden = frame.IsForbidden and frame:IsForbidden()
            if not protected and not forbidden then
                if frame.IsObjectType and (frame:IsObjectType("SimpleHTML") or frame:IsObjectType("Button")
                    or frame:IsObjectType("EditBox"))
                    and frame.GetText and frame.SetText then
                    local t = frame.GetText and frame:GetText()
                    local es = t and TranslateStaticText(t)
                    if es and es ~= t then pcall(frame.SetText, frame, es) end
                    if HookUIFS then pcall(HookUIFS, frame) end
                end
                local ok, regions = pcall(function() return { frame:GetRegions() } end)
                if ok and regions then
                    for _, r in ipairs(regions) do
                        if r and r.IsObjectType and (r:IsObjectType("FontString") or r:IsObjectType("SimpleHTML")) then
                            local t = r:GetText()
                            if t and t ~= "" then
                                local es = TranslateStaticText(t)
                                if es then
                                    pcall(r.SetText, r, es)
                                end
                            end
                            if HookUIFS then pcall(HookUIFS, r) end
                        end
                    end
                end
            end
        end
        frame = EnumerateFrames(frame)
    end
end

local LIVE_UI_FRAMES = { "PathToAscensionFrame", "AscensionLFGFrame",
                         "AscensionPVEFrame", "AscensionPVPFrame",
                         "AscensionRulesetFrame" }
local function TranslateLiveSubtree(fr, depth)
    if depth > 8 then return end
    if fr.IsObjectType and fr:IsObjectType("SimpleHTML") then
        local t = fr.GetText and fr:GetText()
        local es = t and TranslateStaticText(t)
        if es and es ~= t then pcall(fr.SetText, fr, es) end
        if HookUIFS then pcall(HookUIFS, fr) end
    end
    local ok, regions = pcall(function() return { fr:GetRegions() } end)
    if ok and regions then
        for _, r in ipairs(regions) do
            if r.IsObjectType and (r:IsObjectType("FontString") or r:IsObjectType("SimpleHTML")) then
                local t = r.GetText and r:GetText()
                if t and t ~= "" then
                    local es = TranslateStaticText(t)
                    if es and es ~= t then pcall(r.SetText, r, es) end
                end
                if HookUIFS then pcall(HookUIFS, r) end
            end
        end
    end
    local okc, children = pcall(function() return { fr:GetChildren() } end)
    if okc and children then
        for _, c in ipairs(children) do
            TranslateLiveSubtree(c, depth + 1)
        end
    end
end
local function TranslateLiveFramesOnce()
    if not (db and db.ui) then return end
    for _, fname in ipairs(LIVE_UI_FRAMES) do
        local f = _G[fname]
        if f then pcall(TranslateLiveSubtree, f, 0) end
    end
end

local function PrimeStaticSubtree(root, depth)
    if not root then return end
    if root.IsShown and not root:IsShown() then return end
    depth = depth or 0
    if depth > 10 then return end
    if root.IsObjectType and (root:IsObjectType("SimpleHTML") or root:IsObjectType("Button")
        or root:IsObjectType("EditBox"))
        and root.GetText and root.SetText then
        local t = root.GetText and root:GetText()
        local es = t and TranslateStaticText(t)
        if es and es ~= t then pcall(root.SetText, root, es) end
        if HookUIFS then pcall(HookUIFS, root) end
    end
    local ok, regions = pcall(function() return { root:GetRegions() } end)
    if ok and regions then
        for _, r in ipairs(regions) do
            if r and r.IsObjectType and (r:IsObjectType("FontString") or r:IsObjectType("SimpleHTML")) then
                local t = r.GetText and r:GetText()
                if type(t) == "string" and t ~= "" then
                    local es = TranslateStaticText(t)
                    if es and es ~= t then pcall(r.SetText, r, es) end
                end
                if HookUIFS then pcall(HookUIFS, r) end
            end
        end
    end
    local okc, children = pcall(function() return { root:GetChildren() } end)
    if okc and children then
        for _, child in ipairs(children) do
            PrimeStaticSubtree(child, depth + 1)
        end
    end
end

local staticPassTimer
local staticPassPanel
local staticPassNeedsGlobal = false
local StaticPassSoon
local trialsPanelRoot
local trialsInteractiveHooked = setmetatable({}, { __mode = "k" })

-- O Trials monta parte dos controles como frames de nível superior ancorados
-- visualmente na janela, mas fora da árvore de filhos dela. Detectamos apenas
-- esse painel pelo título para permitir duas passagens globais e limitadas.
local function ContainsTrialsTitle(root, depth)
    if not root then return false end
    depth = depth or 0
    if depth > 4 then return false end

    local function isTrialsText(obj)
        if not (obj and obj.GetText) then return false end
        local ok, text = pcall(obj.GetText, obj)
        if not ok or type(text) ~= "string" then return false end
        text = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
            :gsub("^%s+", ""):gsub("%s+$", "")
        return text == "Trials" or text == "Desafios"
    end

    if isTrialsText(root) then return true end
    local okRegions, regions = pcall(function() return { root:GetRegions() } end)
    if okRegions and regions then
        for _, region in ipairs(regions) do
            if isTrialsText(region) then return true end
        end
    end
    local okChildren, children = pcall(function() return { root:GetChildren() } end)
    if okChildren and children then
        for _, child in ipairs(children) do
            if ContainsTrialsTitle(child, depth + 1) then return true end
        end
    end
    return false
end

-- Alguns cartões e abas do Trials são frames separados visualmente colocados
-- dentro da janela. Ligamos somente os controles que ficam dentro dos limites
-- do painel; depois de um clique, executamos a mesma rajada curta de tradução.
local function HookTrialsInteractiveFrames(root)
    if not (root and EnumerateFrames) then return end
    local okBounds, left, right, bottom, top = pcall(function()
        return root:GetLeft(), root:GetRight(), root:GetBottom(), root:GetTop()
    end)
    if not okBounds or not (left and right and bottom and top) then return end

    local frame = EnumerateFrames()
    while frame do
        if not trialsInteractiveHooked[frame] and frame.HookScript
            and frame.IsShown and frame:IsShown() and frame.GetCenter then
            local okCenter, x, y = pcall(frame.GetCenter, frame)
            if okCenter and x and y and x >= left and x <= right and y >= bottom and y <= top then
                local scriptName
                if frame.IsObjectType and frame:IsObjectType("Button") then
                    scriptName = "OnClick"
                elseif frame.GetScript then
                    local okUp, onMouseUp = pcall(frame.GetScript, frame, "OnMouseUp")
                    local okDown, onMouseDown = pcall(frame.GetScript, frame, "OnMouseDown")
                    if okUp and onMouseUp then
                        scriptName = "OnMouseUp"
                    elseif okDown and onMouseDown then
                        scriptName = "OnMouseDown"
                    end
                end
                if scriptName then
                    local hooked = pcall(frame.HookScript, frame, scriptName, function()
                        local panel = trialsPanelRoot
                        if panel and StaticPassSoon
                            and (not panel.IsShown or panel:IsShown()) then
                            StaticPassSoon(panel)
                        end
                    end)
                    if hooked then trialsInteractiveHooked[frame] = true end
                end
            end
        end
        frame = EnumerateFrames(frame)
    end
end

StaticPassSoon = function(panel)
    staticPassPanel = panel or staticPassPanel
    if panel then
        local ok, isTrials = pcall(ContainsTrialsTitle, panel, 0)
        staticPassNeedsGlobal = staticPassNeedsGlobal or (ok and isTrials)
        if ok and isTrials then trialsPanelRoot = panel end
    end
    if staticPassPanel then pcall(PrimeStaticSubtree, staticPassPanel, 0) end
    if staticPassNeedsGlobal and trialsPanelRoot then
        pcall(HookTrialsInteractiveFrames, trialsPanelRoot)
    end
    if not staticPassTimer then staticPassTimer = CreateFrame("Frame") end
    local elapsed, shots = 0, 0
    -- Alguns painéis do servidor, especialmente Trials, criam o conteúdo
    -- interno depois do OnShow. Estas quatro tentativas com atraso progressivo
    -- terminam em menos de um segundo e percorrem somente o painel aberto.
    local waits = { 0.03, 0.12, 0.25, 0.45 }
    staticPassTimer:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + (dt or 0)
        local wait = waits[shots + 1] or waits[#waits]
        if elapsed < wait then return end
        elapsed = 0
        shots = shots + 1
        if staticPassPanel then pcall(PrimeStaticSubtree, staticPassPanel, 0) end
        if staticPassNeedsGlobal and (shots == 2 or shots == #waits) then
            pcall(RetranslateStaticUI)
            if trialsPanelRoot then pcall(HookTrialsInteractiveFrames, trialsPanelRoot) end
        end
        if shots >= #waits then
            staticPassPanel = nil
            staticPassNeedsGlobal = false
            self:SetScript("OnUpdate", nil)
        end
    end)
end

local staticHooked = {}
local function HookStaticPanels()
    pcall(TranslateLiveFramesOnce)
    for _, name in ipairs({ "GameMenuFrame", "VideoOptionsFrame", "InterfaceOptionsFrame",
                            "AchievementFrame", "SpellBookFrame",

                            "AscensionLFGFrame", "AscensionPVEFrame", "AscensionPVPFrame",
                            "AscensionRulesetFrame", "PathToAscensionFrame",
                            "WarmodeMapFrame", "AscensionWeeklyKeystoneFrame",
                            "ChannelFrame",

                            "CharacterAdvancement", "CharacterAdvancementFrame", "AscensionCharacterAdvancement",
                            "ClassTalentFrame", "RaceTalentFrame", "RacialTalentFrame",
                            "SpecializationFrame", "MentorSpecializationFrame", "Collections",
                            "WildCardRapidRollingFrame", "DraftHelpFrame",
                            "SkillCardsFrame", "VanityCollectionFrame" }) do
        local f = _G[name]
        if f then
            pcall(PrimeStaticSubtree, f, 0)
            if not staticHooked[name] and f.HookScript and f:HasScript("OnShow") then
                staticHooked[name] = true
                f:HookScript("OnShow", StaticPassSoon)
            end
        end
    end
end

-- Descobre somente janelas grandes de nível superior e instala um gancho no
-- OnShow. A enumeração acontece em eventos de carregamento, nunca em OnUpdate;
-- quando uma janela abre, apenas a sua própria árvore visível é percorrida.
-- Isso cobre painéis personalizados como Trials e Customer Support sem trazer
-- de volta a varredura global que causava quedas de FPS.
local discoveredStaticRoots = setmetatable({}, { __mode = "k" })
local function DiscoverStaticPanelRoots()
    if not (db and db.ui and EnumerateFrames) then return end
    local frame = EnumerateFrames()
    while frame do
        if not discoveredStaticRoots[frame] and frame.GetParent and frame.GetWidth
            and frame.GetHeight and frame.HookScript then
            local ok, parent, width, height = pcall(function()
                return frame:GetParent(), frame:GetWidth(), frame:GetHeight()
            end)
            local topLevel = ok and (parent == UIParent or parent == nil)
            local largePanel = topLevel and (tonumber(width) or 0) >= 220
                and (tonumber(height) or 0) >= 120
            if largePanel then
                local protected = frame.IsProtected and select(1, frame:IsProtected())
                local forbidden = frame.IsForbidden and frame:IsForbidden()
                if not protected and not forbidden then
                    local hooked = pcall(frame.HookScript, frame, "OnShow", StaticPassSoon)
                    if hooked then
                        discoveredStaticRoots[frame] = true
                        if frame.IsShown and frame:IsShown() then
                            pcall(PrimeStaticSubtree, frame, 0)
                        end
                    end
                end
            end
        end
        frame = EnumerateFrames(frame)
    end
end

local discoveryDriver
local discoveryPending = false
local function ScheduleStaticRootDiscovery()
    if discoveryPending then return end
    discoveryPending = true
    if not discoveryDriver then discoveryDriver = CreateFrame("Frame") end
    local elapsed = 0
    discoveryDriver:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + (dt or 0)
        if elapsed < 0.05 then return end
        self:SetScript("OnUpdate", nil)
        discoveryPending = false
        pcall(DiscoverStaticPanelRoots)
    end)
end

if type(ShowUIPanel) == "function" then
    pcall(hooksecurefunc, "ShowUIPanel", function(panel)
        if db and db.ui and panel then StaticPassSoon(panel) end
    end)
end
if type(ToggleFrame) == "function" then
    pcall(hooksecurefunc, "ToggleFrame", function(panel)
        if db and db.ui and panel and panel.IsShown and panel:IsShown() then
            StaticPassSoon(panel)
        end
    end)
end

-- Painéis adicionais do cliente podem nascer quando outro addon é carregado.
-- A descoberta agora é orientada a eventos e consulta apenas a lista de frames
-- conhecidos, sem percorrer todos os frames do jogo periodicamente.
local staticPanelWatcher = CreateFrame("Frame")
staticPanelWatcher:RegisterEvent("ADDON_LOADED")
staticPanelWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
staticPanelWatcher:SetScript("OnEvent", function()
    if db and db.ui then
        pcall(HookStaticPanels)
        ScheduleStaticRootDiscovery()
    end
end)

-- Algumas janelas do Ascension são criadas depois do login. Atualiza somente
-- textos visíveis, em baixa frequência, para alcançar esses painéis dinâmicos.
-- Path to Ascension gets its page body from C_Tutorial before it creates
-- SimpleHTML regions. Translate that source payload at the API boundary too.
if type(C_Tutorial) == "table" then
    APT._tutorialWrapped = APT._tutorialWrapped or {}
    local function TranslateTutorialValue(value)
        if type(value) ~= "string" or value == "" then return value end
        local translated = TranslateStaticText(value)
        return translated or value
    end
    for _, fname in ipairs({ "GetKeywordAtIndex", "GetKeywordInfo",
                             "GetTutorialAtIndex", "GetTutorialByID",
                             "GetTutorialDisplay", "GetCategoryInfo",
                             "GetObjectiveInfo", "GetMentorSpecializationInfo" }) do
        local original = C_Tutorial[fname]
        if type(original) == "function" and not APT._tutorialWrapped[fname] then
            APT._tutorialWrapped[fname] = true
            C_Tutorial[fname] = function(...)
                local a, b, c, d, e, f, g, h = original(...)
                if db and not db.ui then return a, b, c, d, e, f, g, h end
                return TranslateTutorialValue(a), TranslateTutorialValue(b),
                    TranslateTutorialValue(c), TranslateTutorialValue(d),
                    TranslateTutorialValue(e), TranslateTutorialValue(f),
                    TranslateTutorialValue(g), TranslateTutorialValue(h)
            end
        end
    end
end

-- dynamicUIDriver disabled: EnumerateFrames() every 0.4s caused severe freezing/FPS drops.
-- Static and dynamic UI translation is handled by RetranslateStaticUI() and HookUIFS on SetText.
-- local dynamicUIDriver = CreateFrame("Frame")


local function TranslateAchievementFS(fs, id, esTable, enTable)
    if not fs or not id then return end
    local es = esTable[id]
    if not es then return end
    local text = fs:GetText()
    local guard = enTable[id]
    if text and (not guard or guard == text) then
        fs:SetText(es)
    end
end

local function TranslateAchButton(button)
    if not button or not button.id then return end
    TranslateAchievementFS(button.label, button.id, APT.AchName, APT.AchNameEN)
    TranslateAchievementFS(button.description, button.id, APT.AchDesc, APT.AchDescEN)
    TranslateAchievementFS(button.reward, button.id, APT.AchReward, APT.AchRewardEN)
end

local function AchTooltipPass(tip, achID)
    if not db or not db.achievements then return end
    local name = tip:GetName()
    for i = 1, tip:NumLines() do
        local fs = _G[name .. "TextLeft" .. i]
        local text = fs and fs:GetText()
        if text and text ~= "" then
            local es = (APT.AchNameEN2PT and APT.AchNameEN2PT[text])
                or (APT.AchCritEN2PT and APT.AchCritEN2PT[text])
            if not es and achID and APT.AchDescEN[achID] == text then
                es = APT.AchDesc[achID]
            end
            if es then fs:SetText(es) end
        end
        local fsr = _G[name .. "TextRight" .. i]
        local textr = fsr and fsr:GetText()
        if textr and APT.AchCritEN2PT and APT.AchCritEN2PT[textr] then
            fsr:SetText(APT.AchCritEN2PT[textr])
        end
    end
    tip:Show()
end

local function HookAchievementUI()
    if type(AchievementButton_DisplayAchievement) == "function" then
        hooksecurefunc("AchievementButton_DisplayAchievement", function(button)
            if not db or not db.achievements then return end
            TranslateAchButton(button)
        end)
    end

    if type(AchievementFrameSummary_UpdateAchievements) == "function" then
        hooksecurefunc("AchievementFrameSummary_UpdateAchievements", function()
            if not db or not db.achievements then return end
            for i = 1, 20 do
                local b = _G["AchievementFrameSummaryAchievement" .. i]
                if not b then break end
                TranslateAchButton(b)
                if b.HookScript and not b.__aesHooked then
                    b.__aesHooked = true
                    b:HookScript("OnEnter", function(btn) AchTooltipPass(GameTooltip, btn.id) end)
                end
            end
        end)
    end

    if type(AchievementFrameCategories_DisplayButton) == "function" then
        hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button)
            if not db or not db.achievements then return end
            local fs = button and button.label
            local t = fs and fs:GetText()
            if not t then return end
            local es = (APT.AchCatEN2PT and APT.AchCatEN2PT[t]) or (APT.CustomUI and APT.CustomUI[t])
            if es then fs:SetText(es) end
        end)
    end

    if type(AchievementFrameCategories_UpdateTooltip) == "function" then
        hooksecurefunc("AchievementFrameCategories_UpdateTooltip", function()
            AchTooltipPass(GameTooltip)
        end)
    end
    if type(AchievementMeta_OnEnter) == "function" then
        hooksecurefunc("AchievementMeta_OnEnter", function()
            AchTooltipPass(GameTooltip)
        end)
    end
end

local function HookAchievementAlerts()
    if type(AchievementAlertFrame_ShowAlert) ~= "function" then return end
    hooksecurefunc("AchievementAlertFrame_ShowAlert", function()
        if not db or not db.achievements then return end
        for i = 1, 2 do
            local frame = _G["AchievementAlertFrame" .. i]
            if frame and frame:IsShown() and frame.id then
                TranslateAchievementFS(_G["AchievementAlertFrame" .. i .. "Name"],
                    frame.id, APT.AchName, APT.AchNameEN)
            end
        end
    end)
end

local function HookAchievementLinks()
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(tip, link)
        if not db or not db.achievements then return end
        local id = link and tonumber(link:match("achievement:(%d+)"))
        if not id then return end
        local name = tip:GetName()
        TranslateAchievementFS(_G[name .. "TextLeft1"], id, APT.AchName, APT.AchNameEN)
        for i = 2, tip:NumLines() do
            local fs = _G[name .. "TextLeft" .. i]
            local text = fs and fs:GetText()
            if text and text == APT.AchDescEN[id] and APT.AchDesc[id] then
                fs:SetText(APT.AchDesc[id])
                break
            end
        end
        tip:Show()
    end)
end

local function TranslateTrainerList()
    local n = CLASS_TRAINER_SKILLS_DISPLAYED or 11
    for i = 1, n do
        local btn = _G["ClassTrainerSkill" .. i]
        if btn and btn.GetText then
            local t = btn:GetText()
            if t and t ~= "" then
                local prefix, name = t:match("^(%s*)(.+)$")
                local es = name and APT.SpellNameEN2PT[name]
                if es then btn:SetText((prefix or "") .. es) end
            end
        end
        local sub = _G["ClassTrainerSkill" .. i .. "SubText"]
        local st = sub and sub:GetText()
        if st and st ~= "" then
            local new = st:gsub("%(Rank (%d+)%)", "(Rango %1)")
            new = APT.SpellNameEN2PT[new] or new
            if new ~= st then sub:SetText(new) end
        end
    end
end

local function TranslateTrainerDetail()
    local nameFS = ClassTrainerSkillName
    local enName = nameFS and nameFS:GetText()
    if enName then
        local es = APT.SpellNameEN2PT[enName]
        if es then nameFS:SetText(es) end
    end
    local subFS = ClassTrainerSubSkillName
    local st = subFS and subFS:GetText()
    if st and st ~= "" then
        local new = st:gsub("%(Rank (%d+)%)", "(Rango %1)")
        if new ~= st then subFS:SetText(new) end
    end

    local reqFS = ClassTrainerSkillRequirements
    local rt = reqFS and reqFS:GetText()
    if rt and rt ~= "" then
        local new = rt:gsub("Requires: ", "Requer: ")
        new = new:gsub("Level (%d+)", "nivel %1")
        new = new:gsub("%(Rank (%d+)%)", "(Rango %1)")
        new = new:gsub("[%a][%a' %-]*%a", function(w)
            return TranslateSpellWord(w) or w
        end)
        if new ~= rt then reqFS:SetText(new) end
    end

    local descFS = ClassTrainerSkillDescription
    local dt = descFS and descFS:GetText()
    if dt and #dt > 3 and enName and APT.NameToIDs[enName] then
        for _, id in ipairs(APT.NameToIDs[enName]) do
            if APT.DescByID[id] and TryPairSet(descFS, dt, APT.DescByID[id], APT.DescPairs) then
                break
            end
        end
    end
end

local function HookTrainerUI()
    if type(ClassTrainerFrame_Update) ~= "function" then return end
    hooksecurefunc("ClassTrainerFrame_Update", function()
        if db and db.spells then
            TranslateTrainerList()
            TranslateTrainerDetail()
        end
    end)
    if type(ClassTrainer_SetSelection) == "function" then
        hooksecurefunc("ClassTrainer_SetSelection", function()
            if db and db.spells then TranslateTrainerDetail() end
        end)
    end
    if ClassTrainerFrame and ClassTrainerFrame.HookScript and ClassTrainerFrame:HasScript("OnShow") then
        ClassTrainerFrame:HookScript("OnShow", RetranslateStaticUI)
    end
end

local function TradeSkillWord(t)
    return APT.SpellNameEN2PT[t]
        or (APT.ItemNameEN2PT and APT.ItemNameEN2PT[t])
        or (APT.CustomUI and APT.CustomUI[t])
        or (APT.UIStringsByEN and APT.UIStringsByEN[t])
end

local function TranslateTradeSkillFrame()

    local title = _G["TradeSkillFrameTitleText"]
    local tt = title and title.GetText and title:GetText()
    if tt then
        local es = (APT.ProfessionWords and APT.ProfessionWords[tt]) or TradeSkillWord(tt)
        if es then pcall(title.SetText, title, es) end
    end

    for i = 1, 30 do
        local b = _G["TradeSkillSkill" .. i]
        if b and b.GetText then
            local t = b:GetText()
            if t and t ~= "" then
                local base, count = t:match("^(.-)%s*(%[%d+%])$")
                base = base or t
                local es = TradeSkillWord(base)
                if es then pcall(b.SetText, b, es .. (count and (" " .. count) or "")) end
            end
        end
    end
end

local function TranslateTradeSkillDetail()
    local nameFS = _G["TradeSkillSkillName"]
    local em = nameFS and nameFS.GetText and nameFS:GetText()
    if em then
        local es = TradeSkillWord(em)
        if es then pcall(nameFS.SetText, nameFS, es) end
    end

    local descFS = _G["TradeSkillDescription"]
    local dt = descFS and descFS.GetText and descFS:GetText()
    if dt and dt ~= "" and em then
        local ids = APT.NameToIDs[em]
        if ids then
            for _, id in ipairs(ids) do
                if (APT.DescByID[id] and TryPairSet(descFS, dt, APT.DescByID[id], APT.DescPairs))
                    or (APT.TipByID[id] and TryPairSet(descFS, dt, APT.TipByID[id], APT.TipPairs)) then
                    break
                end
            end
        end
    end

    local reqFS = _G["TradeSkillRequirementText"]
    local rt = reqFS and reqFS.GetText and reqFS:GetText()
    if rt and rt ~= "" then
        local new = rt:gsub("^Requires:%s*(.+)$", function(st)
            return "Requer: " .. (TradeSkillWord(st) or st)
        end)
        if new ~= rt then pcall(reqFS.SetText, reqFS, new) end
    end
    local lbl = _G["TradeSkillReagentLabel"]
    if lbl and lbl.GetText and lbl:GetText() == "Reagents:" then
        pcall(lbl.SetText, lbl, "Reactivos:")
    end
    for i = 1, 8 do
        local fs = _G["TradeSkillReagent" .. i .. "Name"]
        local t = fs and fs.GetText and fs:GetText()
        if t and t ~= "" then
            local es = TradeSkillWord(t)
            if es then pcall(fs.SetText, fs, es) end
        end
    end
end

local function HookTradeSkillUI()
    if type(TradeSkillFrame_Update) ~= "function" then return end
    hooksecurefunc("TradeSkillFrame_Update", function()
        if db and db.spells then
            TranslateTradeSkillFrame()
            TranslateTradeSkillDetail()
        end
    end)
    if type(TradeSkillFrame_SetSelection) == "function" then
        hooksecurefunc("TradeSkillFrame_SetSelection", function()
            if db and db.spells then TranslateTradeSkillDetail() end
        end)
    end
    if TradeSkillFrame and TradeSkillFrame.HookScript and TradeSkillFrame:HasScript("OnShow") then
        TradeSkillFrame:HookScript("OnShow", StaticPassSoon)
    end
end

APT.TranslateTradeSkillFrame = TranslateTradeSkillFrame
APT.TranslateTradeSkillDetail = TranslateTradeSkillDetail

HookFSForTranslation = function(fs)
    if not fs or not fs.SetText or hookedFontStrings[fs] then return end
    hookedFontStrings[fs] = true
    hooksecurefunc(fs, "SetText", function(self, txt)
        if inAPTSet or not db or type(txt) ~= "string" or txt == "" then return end
        local translated = TranslateStaticText(txt)
            or (db.patterns and MatchLinePatterns(txt))
        if not translated and APT.TranslateSystemTextStrict and not txt:find("\n") then
            local tr = APT.TranslateSystemTextStrict(txt)
            if tr ~= txt then translated = tr end
        end
        local normalizeTooltipText = APT.NormalizeTooltipText
        if type(normalizeTooltipText) == "function" then
            local candidate = translated or txt
            local normalized = normalizeTooltipText(candidate)
            if normalized and normalized ~= candidate then translated = normalized end
        end
        if translated and translated ~= txt then
            inAPTSet = true
            pcall(self.SetText, self, translated)
            inAPTSet = false
            EnsureReadablePTBRFont(self, translated)
        end
    end)
end

local function HookTooltip(tip)
    if not tip then return end

    APT._spellBookTooltipHooked = APT._spellBookTooltipHooked or setmetatable({}, { __mode = "k" })
    if tip.SetSpellBookItem and not APT._spellBookTooltipHooked[tip] then
        APT._spellBookTooltipHooked[tip] = true
        hooksecurefunc(tip, "SetSpellBookItem", function(self)
            if db and db.spells then
                APT.TranslateRuntimeSpellBody(self)
            end
        end)
    end

    if tip:HasScript("OnShow") then
        tip:HookScript("OnShow", function(t)
            if not db then return end
            if db.spells then APT.TranslateRuntimeSpellBody(t) end
            if db.spells and APT.StartVisibleTooltipRepair then APT.StartVisibleTooltipRepair() end
            pcall(TranslateTooltipLines, t)
            ScheduleLatePass(t)
            local ok, n = pcall(function() return t:NumLines() end)
            if ok and n then
                local nm = t:GetName()
                local shownSpell = t.GetSpell and t:GetSpell()
                for i = 1, n do
                    local fs = _G[nm .. "TextLeft" .. i]
                    if fs and (i > 1 or not shownSpell) then HookFSForTranslation(fs) end
                    local fsr = _G[nm .. "TextRight" .. i]
                    if fsr then HookFSForTranslation(fsr) end
                end
            end
        end)
    end
    if tip:HasScript("OnTooltipSetSpell") then
        tip:HookScript("OnTooltipSetSpell", function(t)
            OnSpellTooltip(t)
            if db and db.spells and APT.StartVisibleTooltipRepair then APT.StartVisibleTooltipRepair() end
        end)
    end
    if tip:HasScript("OnTooltipSetItem") then
        tip:HookScript("OnTooltipSetItem", OnItemTooltip)
    end
    if tip:HasScript("OnTooltipSetUnit") then
        tip:HookScript("OnTooltipSetUnit", OnUnitTooltip)
    end
end

local function HookAuras()
    if GameTooltip.SetUnitAura then
        hooksecurefunc(GameTooltip, "SetUnitAura", OnAuraTooltip)
    end
    if GameTooltip.SetUnitBuff then
        hooksecurefunc(GameTooltip, "SetUnitBuff", function(tip, unit, index)
            OnAuraTooltip(tip, unit, index, "HELPFUL")
        end)
    end
    if GameTooltip.SetUnitDebuff then
        hooksecurefunc(GameTooltip, "SetUnitDebuff", function(tip, unit, index)
            OnAuraTooltip(tip, unit, index, "HARMFUL")
        end)
    end
end

local OPTIONS_LIST = {
    { key = "spells", text = "Feitiços, talentos e auras" },
    { key = "items", text = "Itens (nomes e descrições)" },
    { key = "flavor", text = "Textos adicionais de itens (linhas amarelas)" },
    { key = "units", text = "Nomes de NPCs" },
    { key = "quests", text = "Missões (descrição, objetivos, progresso e conclusão)" },
    { key = "gossip", text = "Diálogos de NPCs (janelas, chat e balões)" },
    { key = "achievements", text = "Conquistas" },
    { key = "patterns", text = "Linhas genéricas de tooltip (custo, alcance e graus)" },
    { key = "ui", text = "Interface e menus (alterações exigem /reload)" },
    { key = "errores", text = "Mensagens de erro na tela", setter = "SetErrorsEnabled" },
    { key = "chat", text = "Mensagens do chat (saque, experiência e sistema)", setter = "SetChatEnabled" },
    }

local function BuildOptionsPanel()
    if not InterfaceOptions_AddCategory then return end
    local panel = CreateFrame("Frame", "AscensionPTBROptionsPanel", UIParent)
    panel.name = "AscensionPTBR"

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("AscensionPTBR |cff33ff99— Português (Brasil)|r")

    local sub = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    sub:SetJustifyH("LEFT")
    sub:SetText("As alterações são aplicadas imediatamente, salvo indicação. Comando: /ases")

    local prev
    for i, opt in ipairs(OPTIONS_LIST) do
        local cb = CreateFrame("CheckButton", "AscensionPTBROptCheck" .. i, panel, "InterfaceOptionsCheckButtonTemplate")
        if prev then
            cb:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -4)
        else
            cb:SetPoint("TOPLEFT", sub, "BOTTOMLEFT", -2, -14)
        end
        local label = _G[cb:GetName() .. "Text"]
        if label then
            label:SetText(opt.text)
        end
        cb.optKey = opt.key
        cb:SetScript("OnClick", function(self)
            local on = self:GetChecked() and true or false
            if opt.setter and APT[opt.setter] then
                APT[opt.setter](on)
            elseif db then
                db[opt.key] = on
            end
            if opt.key == "ui" then
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r: use /reload para aplicar a alteração da interface.")
            end
        end)
        prev = cb
    end

    panel:SetScript("OnShow", function()
        for i = 1, #OPTIONS_LIST do
            local cb = _G["AscensionPTBROptCheck" .. i]
            if cb and db then
                cb:SetChecked(db[cb.optKey] and true or false)
            end
        end
    end)

    InterfaceOptions_AddCategory(panel)
end

-- QuestData usa estes marcadores para personalizar textos. Eles precisam ser
-- PT-BR também; caso contrário uma missão já traduzida podia reintroduzir
-- palavras em espanhol ao substituir <class>, <race>, $C ou $R.
local QUEST_CLASS_PT = {
    Warrior = "Guerreiro", Paladin = "Paladino", Hunter = "Caçador", Rogue = "Ladino",
    Priest = "Sacerdote", ["Death Knight"] = "Cavaleiro da Morte", Shaman = "Xamã",
    Mage = "Mago", Warlock = "Bruxo", Druid = "Druida",
}
local QUEST_RACE_PT = {
    Human = "Humano", Dwarf = "Anão", ["Night Elf"] = "Elfo Noturno", Gnome = "Gnomo",
    Draenei = "Draenei", Orc = "Orc", Undead = "Morto-vivo", Tauren = "Tauren",
    Troll = "Troll", ["Blood Elf"] = "Elfo Sangrento",
}

local function CollapseWS(t)
    t = t:gsub("%s+", " ")
    return (t:gsub("^%s+", ""):gsub("%s+$", ""))
end

-- Quest-log headers are sometimes rendered in uppercase, while the stored
-- title keeps its original capitalization. Normalize both forms before using
-- the title as a fallback identifier.
local function QuestTitleKey(t)
    if type(t) ~= "string" then return nil end
    t = t:gsub("\r", "")
        :gsub("|c%x%x%x%x%x%x%x%x", "")
        :gsub("|r", "")
    return CollapseWS(t):lower()
end

local function LookupQuestIDByTitle(title)
    if type(title) ~= "string" or title == "" then return nil end
    local exact = (APT.QuestTitleEN2ID and APT.QuestTitleEN2ID[title])
        or (APT.QuestTitlePT2ID and APT.QuestTitlePT2ID[title])
    if exact and exact ~= false then return exact end

    local key = QuestTitleKey(title)
    local candidates = key and ((APT.QuestTitleEN2IDsByKey and APT.QuestTitleEN2IDsByKey[key])
        or (APT.QuestTitlePT2IDsByKey and APT.QuestTitlePT2IDsByKey[key]))
    if candidates and #candidates == 1 then return candidates[1] end
    return nil
end

local function LookupQuestTitlePT(title)
    if type(title) ~= "string" or title == "" then return nil end
    local exact = APT.QuestTitleEN2PT and APT.QuestTitleEN2PT[title]
    if exact and exact ~= false then return exact end
    local key = QuestTitleKey(title)
    local translated = key and APT.QuestTitleEN2PTByKey and APT.QuestTitleEN2PTByKey[key]
    if translated and translated ~= false then return translated end
    return nil
end

-- Mantemos a API original para obter o ID mesmo depois de traduzir os títulos
-- devolvidos por GetQuestLogTitle.
local RawGetQuestLogTitle = type(GetQuestLogTitle) == "function" and GetQuestLogTitle or nil

local function QuestLogSelectedID()
    local titleGetter = RawGetQuestLogTitle or GetQuestLogTitle
    if not (GetQuestLogSelection and titleGetter) then return nil end
    local selection = GetQuestLogSelection()
    if not selection or selection <= 0 then return nil end

    local info = { titleGetter(selection) }
    -- Different 3.x clients expose questID in position 8 or 9.
    for _, position in ipairs({ 9, 8 }) do
        local id = tonumber(info[position])
        if id and id > 0 and APT.QuestData and APT.QuestData[id] then return id end
    end
    return LookupQuestIDByTitle(info[1])
end

local function QuestNormalizeShown(t)
    t = t:gsub("\r", "")
    local n = UnitName and UnitName("player")
    if n and #n > 1 then t = t:gsub(n, "<name>") end
    local c = UnitClass and UnitClass("player")
    if c then
        t = t:gsub(c, "<class>")
        t = t:gsub(c:lower(), "<class>")
    end
    local r = UnitRace and UnitRace("player")
    if r then
        t = t:gsub(r, "<race>")
        t = t:gsub(r:lower(), "<race>")
    end
    return CollapseWS(t)
end

local function QuestRenderPT(t)
    local male = not (UnitSex and UnitSex("player") == 3)

    t = t:gsub("%$[Gg]([^:;]*):([^;]*);", function(m, f)
        local pick = male and m or f
        return (pick:gsub("^%s+", ""):gsub("%s+$", ""))
    end)
    local name = (UnitName and UnitName("player")) or "aventurero"
    local c = UnitClass and UnitClass("player")
    local cPT = (c and (QUEST_CLASS_PT[c] or c)) or "aventureiro"
    local r = UnitRace and UnitRace("player")
    local rPT = (r and (QUEST_RACE_PT[r] or r)) or ""
    t = t:gsub("%$[Nn]", name):gsub("%$[Cc]", cPT):gsub("%$[Rr]", rPT)

    t = t:gsub("<name>", name):gsub("<class>", cPT):gsub("<race>", rPT)
    return t
end

local function GuardEq(shown, guardEN)
    return guardEN ~= nil
        and QuestNormalizeShown(shown):lower() == CollapseWS(guardEN:gsub("\r", "")):lower()
end

-- O servidor pode atualizar o texto de uma missão sem mudar sua ID. Cada
-- variante é guardada com o inglês exato, portanto nunca trocamos um texto
-- desconhecido por engano.
local function QuestTranslationForShown(qd, field, shown)
    if not (qd and shown and shown ~= "") then return nil end
    local es, guard = qd[field], qd[field .. "EN"]
    if es and guard and GuardEq(shown, guard) then return es end
    for _, variant in ipairs(qd[field .. "Variants"] or {}) do
        if variant and variant.pt and variant.en and GuardEq(shown, variant.en) then
            return variant.pt
        end
    end
    return nil
end

local function ResolveQuestIDByShown(title, shown, fields)
    if not (title and shown and shown ~= "" and APT.QuestData) then return nil end
    local cands = (APT.QuestTitleEN2IDs and APT.QuestTitleEN2IDs[title])
        or (APT.QuestTitlePT2IDs and APT.QuestTitlePT2IDs[title])
    if not cands then
        local key = QuestTitleKey(title)
        cands = key and ((APT.QuestTitleEN2IDsByKey and APT.QuestTitleEN2IDsByKey[key])
            or (APT.QuestTitlePT2IDsByKey and APT.QuestTitlePT2IDsByKey[key]))
    end
    if not cands then return nil end
    for _, id in ipairs(cands) do
        local qd = APT.QuestData[id]
        if qd then
            for _, f in ipairs(fields) do
                if QuestTranslationForShown(qd, f, shown) then return id end
                local es = qd[f]
                if es and CollapseWS(shown) == CollapseWS(QuestRenderPT(es)) then
                    return id
                end
            end
        end
    end
end

local QUEST_PANEL_FIELDS = {
    { "QuestInfoDescriptionText", "d" },
    { "QuestLogQuestDescription", "d" },
    { "QuestInfoObjectivesText", "o" },
    { "QuestLogObjectivesText", "o" },
    { "QuestInfoRewardText", "c" },
    { "QuestLogRewardText", "c" },
    { "QuestProgressText", "p" },
}
local function ResolveQuestIDByPanels(title)
    if not title or title == "" then return nil end
    for _, pf in ipairs(QUEST_PANEL_FIELDS) do
        local fs = _G[pf[1]]
        if fs and fs.GetText and (not fs.IsVisible or fs:IsVisible()) then
            local shown = fs:GetText()
            if shown and shown ~= "" then
                local id = ResolveQuestIDByShown(title, shown, { pf[2] })
                if id then return id end
            end
        end
    end
end
APT.ResolveQuestIDByPanels = ResolveQuestIDByPanels

local function QuestGuardSet(fs, es, em, variants)
    if not (fs and es and em) then return end
    local shown = fs.GetText and fs:GetText()
    if not shown or shown == "" then return end
    local translated
    if GuardEq(shown, em) then
        translated = es
    else
        for _, variant in ipairs(variants or {}) do
            if variant and variant.pt and variant.en and GuardEq(shown, variant.en) then
                translated = variant.pt
                break
            end
        end
    end
    if translated then pcall(fs.SetText, fs, QuestRenderPT(translated)) end
end

APT.QuestRenderPT = QuestRenderPT

-- Alguns clientes 3.3.5 usam os nomes QuestLog* no Registro de Missões;
-- outros expõem as mesmas FontStrings como QuestInfo*. Aplicamos a tradução
-- aos dois sem assumir qual variante a interface carregou.
local QUEST_INFO_TITLE_FIELDS = { "QuestInfoTitleHeader", "QuestLogQuestTitle" }
local QUEST_INFO_DESCRIPTION_FIELDS = { "QuestInfoDescriptionText", "QuestLogQuestDescription" }
local QUEST_INFO_OBJECTIVE_FIELDS = { "QuestInfoObjectivesText", "QuestLogObjectivesText" }
local QUEST_INFO_REWARD_FIELDS = { "QuestInfoRewardText", "QuestLogRewardText" }

local function FirstQuestFontString(names)
    for _, name in ipairs(names) do
        local fs = _G[name]
        if fs and fs.GetText then return fs end
    end
end

local function QuestGuardSetFields(names, es, em, variants)
    for _, name in ipairs(names) do
        QuestGuardSet(_G[name], es, em, variants)
    end
end

-- Missões novas do servidor podem aparecer antes de seus IDs entrarem no banco
-- local. Para esses casos, aplicamos somente substituições exatas cadastradas em
-- Corrections.lua. Isso mantém o custo constante e evita traduções parciais.
local function TranslateKnownQuestText()
    local exact = APT.QuestTextEN2PT
    if type(exact) ~= "table" then return end

    local function LookupExact(text)
        local translated = exact[text]
        if translated then return translated end

        -- O servidor pode variar apenas quebras de linha/espaços entre builds.
        -- A comparação continua exigindo que todo o conteúdo seja igual.
        local normalized = CollapseWS(text)
        for source, candidate in pairs(exact) do
            if type(source) == "string" and CollapseWS(source) == normalized then
                return candidate
            end
        end
    end

    local groups = {
        QUEST_INFO_TITLE_FIELDS,
        QUEST_INFO_DESCRIPTION_FIELDS,
        QUEST_INFO_OBJECTIVE_FIELDS,
        QUEST_INFO_REWARD_FIELDS,
    }
    for _, names in ipairs(groups) do
        for _, name in ipairs(names) do
            local fs = _G[name]
            local shown = fs and fs.GetText and fs:GetText()
            local translated = shown and LookupExact(shown)
            if type(translated) == "string" and translated ~= "" and translated ~= shown then
                pcall(fs.SetText, fs, QuestRenderPT(translated))
            end
        end
    end
end

local function TranslateQuestInfo()
    if not (db and db.quests) then return end
    local id
    if QuestInfoFrame and QuestInfoFrame.questLog then
        id = QuestLogSelectedID()
    elseif GetQuestID then
        id = GetQuestID()
    end
    id = tonumber(id)

    local titleFS = FirstQuestFontString(QUEST_INFO_TITLE_FIELDS)
    if titleFS then
        local t = titleFS:GetText()
        local es = LookupQuestTitlePT(t)
        if es then pcall(titleFS.SetText, titleFS, es) end
        if (not id or id == 0) then id = LookupQuestIDByTitle(t) end
    end
    if (not id or id == 0) and titleFS then
        local t = titleFS:GetText()
        if t then
            id = LookupQuestIDByTitle(t)

            if not id then id = ResolveQuestIDByPanels(t) end
        end
    end
    TranslateKnownQuestText()
    if not id or id == 0 then

        if db.capture and _G["QuestInfoTitleHeader"] then
            local t = _G["QuestInfoTitleHeader"].GetText and _G["QuestInfoTitleHeader"]:GetText()
            if t and t ~= "" then
                db.qcaptured = db.qcaptured or {}
                local dFS = _G["QuestInfoDescriptionText"]
                local oFS = _G["QuestInfoObjectivesText"]
                db.qcaptured[t] = {
                    d = dFS and dFS.GetText and dFS:GetText() or nil,
                    o = oFS and oFS.GetText and oFS:GetText() or nil,
                }
            end
        end
        return
    end
    local es_t = APT.QuestTitle[id]
    if es_t then
        QuestGuardSetFields(QUEST_INFO_TITLE_FIELDS, es_t, APT.QuestTitleEN[id])
    end

    for _, fsName in ipairs({ "QuestInfoItemReceiveText", "QuestInfoItemChooseText",
                              "QuestInfoRewardsHeader", "QuestInfoSpellReceiveText" }) do
        local fs = _G[fsName]
        local t = fs and fs.GetText and fs:GetText()
        local es = t and ((APT.UIStringsByEN and APT.UIStringsByEN[t])
            or (APT.CustomUI and APT.CustomUI[t]))
        if es then pcall(fs.SetText, fs, es) end
    end
    local qd = APT.QuestData[id]
    if not qd then return end
    QuestGuardSetFields(QUEST_INFO_DESCRIPTION_FIELDS, qd.d, qd.dEN, qd.dVariants)
    QuestGuardSetFields(QUEST_INFO_OBJECTIVE_FIELDS, qd.o, qd.oEN, qd.oVariants)
    QuestGuardSetFields(QUEST_INFO_REWARD_FIELDS, qd.c, qd.cEN, qd.cVariants)
end

local function TranslateQuestItemButtons()
    if not (db and db.items and APT.ItemName) then return end
    local function apply(fsName, link)
        local fs = _G[fsName]
        if not (fs and fs.GetText and link) then return end
        local id = tonumber(link:match("item:(%d+)"))
        local es = id and APT.ItemName[id]
        if not es then return end
        local guard = APT.ItemNameEN and APT.ItemNameEN[id]
        local shown = fs:GetText()
        if shown and (not guard or guard == shown) and shown ~= es then
            pcall(fs.SetText, fs, es)
        end
    end
    for i = 1, 8 do
        local btn = _G["QuestInfoItem" .. i]
        if btn and btn.IsShown and btn:IsShown() and btn.type and btn.GetID
            and GetQuestItemLink then
            apply("QuestInfoItem" .. i .. "Name",
                  select(1, GetQuestItemLink(btn.type, btn:GetID())))
        end
        local pbtn = _G["QuestProgressItem" .. i]
        if pbtn and pbtn.IsShown and pbtn:IsShown() and GetQuestItemLink then
            apply("QuestProgressItem" .. i .. "Name",
                  select(1, GetQuestItemLink("required", i)))
        end
    end
end

local function TranslateQuestProgress()
    if not (db and db.quests) then return end
    local id = GetQuestID and tonumber(GetQuestID())
    if (not id or id == 0) and _G["QuestProgressTitleText"] then
        local t = _G["QuestProgressTitleText"].GetText and _G["QuestProgressTitleText"]:GetText()
        if t then
            local es = LookupQuestTitlePT(t)
            if es then pcall(_G["QuestProgressTitleText"].SetText, _G["QuestProgressTitleText"], es) end
            id = LookupQuestIDByTitle(t)

            if not id then id = ResolveQuestIDByPanels(t) end
        end
    end
    if not id or id == 0 then return end
    local es_t = APT.QuestTitle[id]
    if es_t then
        QuestGuardSet(_G["QuestProgressTitleText"], es_t, APT.QuestTitleEN[id])
    end
    local qd = APT.QuestData[id]
    if qd then
        QuestGuardSet(_G["QuestProgressText"], qd.p, qd.pEN)
    end
end

local function TranslateQuestButtons(prefix, count)
    if not (db and db.quests and APT.QuestTitleEN2PT) then return end
    for i = 1, count do
        local b = _G[prefix .. i]
        if b and b.GetText then
            local t = b:GetText()
            local es = t and LookupQuestTitlePT(t)
            if es then pcall(b.SetText, b, es) end
        end
    end
end

local function TranslateTitlesIn(root)
    if not (root and root.GetRegions and root.GetChildren) then return end
    local function visit(fr, depth)
        if depth > 5 then return end
        for _, r in ipairs({ fr:GetRegions() }) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                local t = r.GetText and r:GetText()
                local es = t and LookupQuestTitlePT(t)
                if es then pcall(r.SetText, r, es) end
            end
        end
        for _, c in ipairs({ fr:GetChildren() }) do
            visit(c, depth + 1)
        end
    end
    pcall(visit, root, 0)
end

local function TranslateQuestLog()
    if not (db and db.quests) then return end
    TranslateQuestButtons("QuestLogTitle", 32)
    TranslateTitlesIn(_G["QuestLogFrame"])
    TranslateQuestInfo()
end

local greetDelay
local function TranslateGreetings()
    TranslateQuestButtons("QuestTitleButton", 32)
    TranslateQuestButtons("GossipTitleButton", 32)
    TranslateTitlesIn(GossipFrame)
    TranslateTitlesIn(QuestFrameGreetingPanel)

    if not greetDelay then
        greetDelay = CreateFrame("Frame")
    end
    local elapsed = 0
    greetDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.3 then return end
        self:SetScript("OnUpdate", nil)
        TranslateQuestButtons("QuestTitleButton", 32)
        TranslateQuestButtons("GossipTitleButton", 32)
        TranslateTitlesIn(GossipFrame)
        TranslateTitlesIn(QuestFrameGreetingPanel)
    end)
end

local function ReflowQuestPanels()

    for _, name in ipairs({ "QuestFrameRewardPanel", "QuestFrameDetailPanel",
                            "QuestFrameProgressPanel" }) do
        local panel = _G[name]
        if panel and panel.IsShown and panel:IsShown()
            and type(_G[name .. "_OnShow"]) == "function" then
            pcall(_G[name .. "_OnShow"], panel)
        end
    end
    for _, name in ipairs({ "QuestRewardScrollFrame", "QuestDetailScrollFrame",
                            "QuestProgressScrollFrame" }) do
        local sf = _G[name]
        if sf and sf.IsShown and sf:IsShown() then
            if sf.UpdateScrollChildRect then
                pcall(sf.UpdateScrollChildRect, sf)
            end
            local sb = _G[name .. "ScrollBar"]
            if sb and sb.SetValue and sb.GetValue then
                local v = sb:GetValue() or 0
                pcall(sb.SetValue, sb, v + 1)
                pcall(sb.SetValue, sb, v)
            end
        end
    end
end
APT.ReflowQuestPanels = ReflowQuestPanels

local questDelay
local function DelayedQuestPass()
    if not questDelay then
        questDelay = CreateFrame("Frame")
    end
    local elapsed, shots = 0, 0
    questDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if (shots == 0 and elapsed < 0.3) or (shots == 1 and elapsed < 1.0) then
            return
        end
        shots = shots + 1
        TranslateQuestInfo()
        TranslateQuestProgress()
        pcall(TranslateQuestLog)
        pcall(ReflowQuestPanels)
        pcall(TranslateQuestItemButtons)
        if shots >= 2 then
            self:SetScript("OnUpdate", nil)
        end
    end)
end

local function CaptureGiverSex()
    if not (db and UnitSex) then return end
    local id
    if GetQuestID then id = tonumber(GetQuestID()) end
    if not id or id == 0 then id = QuestLogSelectedID() end
    if (not id or id == 0) and _G["QuestInfoTitleHeader"] then
        local t = _G["QuestInfoTitleHeader"].GetText and _G["QuestInfoTitleHeader"]:GetText()
        id = LookupQuestIDByTitle(t)
        if not id then id = ResolveQuestIDByPanels(t) end
    end
    if not id or id == 0 then return end
    local sex = UnitExists and UnitExists("npc") and UnitSex("npc") or 0
    db.qsex = db.qsex or {}
    if db.qsex[id] == nil then
        db.qsex[id] = sex
    end
end

local questFrame = CreateFrame("Frame")
questFrame:RegisterEvent("QUEST_DETAIL")
questFrame:RegisterEvent("QUEST_PROGRESS")
questFrame:RegisterEvent("QUEST_COMPLETE")
questFrame:RegisterEvent("QUEST_GREETING")
questFrame:RegisterEvent("GOSSIP_SHOW")
questFrame:RegisterEvent("QUEST_ITEM_UPDATE")
questFrame:SetScript("OnEvent", function(self, event)
    if not (db and db.quests) then return end
    if event == "QUEST_DETAIL" or event == "QUEST_COMPLETE" then
        local elapsed = 0
        local sexer = CreateFrame("Frame")
        sexer:SetScript("OnUpdate", function(sf, dt)
            elapsed = elapsed + dt
            if elapsed < 0.4 then return end
            sf:SetScript("OnUpdate", nil)
            pcall(CaptureGiverSex)
        end)
    end
    if event == "QUEST_PROGRESS" then
        TranslateQuestProgress()
        DelayedQuestPass()
    elseif event == "QUEST_GREETING" or event == "GOSSIP_SHOW" then
        TranslateGreetings()
    elseif event == "QUEST_ITEM_UPDATE" then

        TranslateQuestInfo()
        pcall(ReflowQuestPanels)
        DelayedQuestPass()
    else
        TranslateQuestInfo()
        DelayedQuestPass()
    end
end)
if type(QuestInfo_Display) == "function" then
    hooksecurefunc("QuestInfo_Display", TranslateQuestInfo)
end
if type(QuestLog_Update) == "function" then
    hooksecurefunc("QuestLog_Update", function()
        TranslateQuestLog()
        DelayedQuestPass()
    end)
end
if QuestLogFrame and QuestLogFrame.HookScript then
    QuestLogFrame:HookScript("OnShow", function()
        TranslateQuestLog()
        DelayedQuestPass()
    end)
end
if type(GossipFrameUpdate) == "function" then
    hooksecurefunc("GossipFrameUpdate", function()
        TranslateQuestButtons("GossipTitleButton", 32)
    end)
end

APT.TranslateQuestInfo = TranslateQuestInfo
APT.TranslateQuestProgress = TranslateQuestProgress

local gossipIdx
local gossipApplied = {}

local function GossipRenderEN(t)
    local male = not (UnitSex and UnitSex("player") == 3)

    t = t:gsub("%$[Gg]([^:;]*):([^;]*);", function(m, f)
        local pick = male and m or f
        return (pick:gsub("^%s+", ""):gsub("%s+$", ""))
    end)
    local name = (UnitName and UnitName("player")) or ""
    local c = (UnitClass and UnitClass("player")) or ""
    local r = (UnitRace and UnitRace("player")) or ""
    return (t:gsub("%$[Nn]", name):gsub("%$[Cc]", c):gsub("%$[Rr]", r))
end

local function GossipLookup(shown)
    local map = APT.GossipEN2PT
    if not (map and shown and shown ~= "") then return nil end
    local key = shown:gsub("\r", ""):gsub("%s+$", "")
    local es = map[key]
    -- Try with and without "G::" prefix (migrated entries use G:: prefix)
    if es == nil then
        local prefix = "G::"
        if key:sub(1, #prefix) == prefix then
            es = map[key:sub(#prefix + 1)]
        else
            es = map[prefix .. key]
        end
    end
    if es == nil then
        if not gossipIdx then
            gossipIdx = {}
            for em, v in pairs(map) do
                if em:find("%$") then gossipIdx[GossipRenderEN(em)] = v end
            end
        end
        es = gossipIdx[key]
    end
    if es then
        es = QuestRenderPT(es)
        gossipApplied[es] = true
        return es
    end
    return nil
end
APT.GossipLookup = GossipLookup

local capCount = {}
local function GossipCapture(store, t)
    if not db or gossipApplied[t] or #t > 3000 then return end
    db[store] = db[store] or {}
    if db[store][t] then return end
    if capCount[store] == nil then
        local n = 0
        for _ in pairs(db[store]) do n = n + 1 end
        capCount[store] = n
    end
    if capCount[store] >= 400 then return end
    capCount[store] = capCount[store] + 1
    db[store][t] = {
        n = (UnitName and UnitName("player")) or "",
        c = (UnitClass and UnitClass("player")) or "",
        r = (UnitRace and UnitRace("player")) or "",
    }
end

local function TranslateGossipGreeting()
    if not (db and db.gossip) then return end
    for _, fsName in ipairs({ "GossipGreetingText", "GreetingText" }) do
        local fs = _G[fsName]
        local t = fs and fs.GetText and fs:GetText()
        if t and t ~= "" and not gossipApplied[t] then
            local es = GossipLookup(t)
            if es then
                pcall(fs.SetText, fs, es)
            else
                GossipCapture("gcaptured", t)
            end
        end
    end
    for i = 1, 32 do
        local b = _G["GossipTitleButton" .. i]
        if b and b.GetText and b:IsShown() then
            local t = b:GetText()
            if t and not gossipApplied[t] then
                local es = GossipLookup(t)
                if es then pcall(b.SetText, b, es) end
            end
        end
    end
end
APT.TranslateGossipGreeting = TranslateGossipGreeting

local gossipDelay
local gossipFrame = CreateFrame("Frame")
gossipFrame:RegisterEvent("GOSSIP_SHOW")
gossipFrame:RegisterEvent("QUEST_GREETING")
gossipFrame:SetScript("OnEvent", function()
    if not (db and db.gossip) then return end
    TranslateGossipGreeting()

    if not gossipDelay then gossipDelay = CreateFrame("Frame") end
    local elapsed = 0
    gossipDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.3 then return end
        self:SetScript("OnUpdate", nil)
        TranslateGossipGreeting()
    end)
end)

local bubblePending, bubbleScanner = {}, nil

local function ScanBubbles()
    local now = GetTime()
    local any = false
    for em, info in pairs(bubblePending) do
        if now - info.t0 > 3 then bubblePending[em] = nil else any = true end
    end
    if not (any and WorldFrame) then return false end
    for _, f in ipairs({ WorldFrame:GetChildren() }) do
        if not (f.GetName and f:GetName()) then
            for _, r in ipairs({ f:GetRegions() }) do
                if r.IsObjectType and r:IsObjectType("FontString") then
                    local t = r.GetText and r:GetText()
                    local info = t and bubblePending[t]
                    if info then
                        pcall(r.SetText, r, info.es)

                        if r.GetStringWidth and f.SetWidth then
                            pcall(function()
                                f:SetWidth(math.min(330, r:GetStringWidth() + 28))
                                f:SetHeight(r:GetStringHeight() + 28)
                            end)
                        end
                    end
                end
            end
        end
    end
    return true
end

local function StartBubbleScan()
    if not bubbleScanner then bubbleScanner = CreateFrame("Frame") end
    local elapsed = 0
    bubbleScanner:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.1 then return end
        elapsed = 0
        if not ScanBubbles() then self:SetScript("OnUpdate", nil) end
    end)
end

local function GossipChatFilter(self, event, msg, ...)
    if not (db and db.gossip) or type(msg) ~= "string" then return false end
    local es = GossipLookup(msg)
    if es then
        bubblePending[msg] = { es = es, t0 = GetTime() }
        StartBubbleScan()
        return false, es, ...
    end
    GossipCapture("scaptured", msg)
    return false
end
APT.GossipChatFilter = GossipChatFilter

if ChatFrame_AddMessageEventFilter then
    for _, ev in ipairs({ "CHAT_MSG_MONSTER_SAY", "CHAT_MSG_MONSTER_YELL",
                          "CHAT_MSG_MONSTER_WHISPER", "CHAT_MSG_MONSTER_EMOTE",
                          "CHAT_MSG_RAID_BOSS_EMOTE", "CHAT_MSG_RAID_BOSS_WHISPER" }) do
        ChatFrame_AddMessageEventFilter(ev, GossipChatFilter)
    end
end

local origGetTitleText = type(GetTitleText) == "function" and GetTitleText or nil

local function CurrentQuestID()
    local id = GetQuestID and tonumber(GetQuestID())
    if id and id ~= 0 then return id end
    id = QuestLogSelectedID()
    if id then return id end
    local t = origGetTitleText and origGetTitleText()
    id = LookupQuestIDByTitle(t)
    if id then return id end
    return nil
end

local function WrapQuestGetter(name, field)
    local orig = _G[name]
    if type(orig) ~= "function" then return end
    _G[name] = function(...)
        local em = orig(...)
        if not (db and db.quests) or type(em) ~= "string" or em == "" then
            return em
        end
        local id = CurrentQuestID()
        local qd = id and APT.QuestData and APT.QuestData[id]
        local es = QuestTranslationForShown(qd, field, em)
        if not es then

            local t = origGetTitleText and origGetTitleText()
            local rid = t and ResolveQuestIDByShown(t, em, { field })
            qd = rid and APT.QuestData and APT.QuestData[rid]
            es = QuestTranslationForShown(qd, field, em)
        end
        if es then return QuestRenderPT(es) end
        return em
    end
end
WrapQuestGetter("GetQuestText", "d")
WrapQuestGetter("GetObjectiveText", "o")
WrapQuestGetter("GetProgressText", "p")
WrapQuestGetter("GetRewardText", "c")

-- O Registro de MissÃµes clÃ¡ssico consulta estas APIs diretamente, sem passar
-- pelos FontStrings QuestInfo*. Traduzimos a saÃ­da preservando a API original
-- e aplicando a mesma guarda exata usada nas outras telas de missÃ£o.
RawGetQuestLogTitle = RawGetQuestLogTitle
    or (type(GetQuestLogTitle) == "function" and GetQuestLogTitle or nil)

local function QuestDataFromLogIndex(index)
    if not RawGetQuestLogTitle then return nil end
    index = tonumber(index)
    if not index and GetQuestLogSelection then index = GetQuestLogSelection() end
    if not index or index <= 0 then return nil end
    local row = { RawGetQuestLogTitle(index) }
    for _, position in ipairs({ 9, 8 }) do
        local id = tonumber(row[position])
        if id and id > 0 and APT.QuestData and APT.QuestData[id] then
            return APT.QuestData[id], id
        end
    end
    local id = LookupQuestIDByTitle(row[1])
    return id and APT.QuestData and APT.QuestData[id] or nil, id
end

if RawGetQuestLogTitle then
    GetQuestLogTitle = function(...)
        local row = { RawGetQuestLogTitle(...) }
        if db and db.quests and type(row[1]) == "string" then
            row[1] = LookupQuestTitlePT(row[1]) or row[1]
        end
        return unpack(row)
    end
end

local rawGetQuestLogQuestText = type(GetQuestLogQuestText) == "function"
    and GetQuestLogQuestText or nil
if rawGetQuestLogQuestText then
    GetQuestLogQuestText = function(...)
        local description, objectives = rawGetQuestLogQuestText(...)
        if not (db and db.quests) then return description, objectives end
        local qd = QuestDataFromLogIndex(select(1, ...))
        if qd then
            local translated = QuestTranslationForShown(qd, "d", description)
            if translated then description = QuestRenderPT(translated) end
            translated = QuestTranslationForShown(qd, "o", objectives)
            if translated then objectives = QuestRenderPT(translated) end
        end
        return description, objectives
    end
end

local rawGetQuestLogLeaderBoard = type(GetQuestLogLeaderBoard) == "function"
    and GetQuestLogLeaderBoard or nil
if rawGetQuestLogLeaderBoard then
    GetQuestLogLeaderBoard = function(...)
        local text, objectiveType, isFinished = rawGetQuestLogLeaderBoard(...)
        if db and db.quests and type(text) == "string" then
            local translated = (APT.QuestObjectiveEN2PT and APT.QuestObjectiveEN2PT[text])
                or (APT.QuestUIExact and APT.QuestUIExact[text])
            if translated and translated ~= false then text = QuestRenderPT(translated) end
        end
        return text, objectiveType, isFinished
    end
end

if origGetTitleText then
    GetTitleText = function(...)
        local em = origGetTitleText(...)
        if not (db and db.quests) or type(em) ~= "string" or em == "" then
            return em
        end

        local es = LookupQuestTitlePT(em)
        if es then return es end
        return em
    end
end

for _, name in ipairs({ "GetGossipText", "GetGreetingText" }) do
    local orig = _G[name]
    if type(orig) == "function" then
        _G[name] = function(...)
            local em = orig(...)
            if not (db and db.gossip) or type(em) ~= "string" then return em end
            return GossipLookup(em) or em
        end
    end
end

local function WrapTitleList(fname)
    local orig = _G[fname]
    if type(orig) ~= "function" then return end
    _G[fname] = function(...)
        local r = { orig(...) }
        if db and db.quests and APT.QuestTitleEN2PT then
            for i = 1, #r do
                if type(r[i]) == "string" then
                    local es = LookupQuestTitlePT(r[i])
                    if es then r[i] = es end
                end
            end
        end
        return unpack(r)
    end
end
WrapTitleList("GetGossipAvailableQuests")
WrapTitleList("GetGossipActiveQuests")

local function WrapTitleGetter(fname)
    local orig = _G[fname]
    if type(orig) ~= "function" then return end
    _G[fname] = function(...)
        local t = orig(...)
        if db and db.quests and type(t) == "string" and APT.QuestTitleEN2PT then
            local es = LookupQuestTitlePT(t)
            if es then return es end
        end
        return t
    end
end
WrapTitleGetter("GetAvailableTitle")
WrapTitleGetter("GetActiveTitle")

local uiFSHooked = setmetatable({}, { __mode = "k" })
local inUIFSHook = false
function HookUIFS(fs)
    if uiFSHooked[fs] or not fs.SetText then return end
    uiFSHooked[fs] = true

    for _, metodo in ipairs({ "SetText", "SetFormattedText" }) do
        if fs[metodo] then
            pcall(hooksecurefunc, fs, metodo, function(self)
                if inUIFSHook or not (db and db.ui) then return end
                local txt = self.GetText and self:GetText()
                if type(txt) ~= "string" or txt == "" then return end
                local es = TranslateStaticText(txt)
                if es and es ~= txt then
                    inUIFSHook = true
                    pcall(self.SetText, self, es)
                    inUIFSHook = false
                end
            end)
        end
    end
end

local function WalkUIExact(root, depth, hookFS)
    if not (root and root.GetRegions and root.GetChildren) then return end
    depth = depth or 0
    if depth > 7 then return end
    for _, r in ipairs({ root:GetRegions() }) do
        if r.IsObjectType and r:IsObjectType("FontString") then
            local t = r.GetText and r:GetText()
            local es = t and (TranslateStaticText(t) or (db and db.patterns and MatchLinePatterns(t)))
            if es then pcall(r.SetText, r, es) end
            if hookFS then pcall(HookUIFS, r) end
        end
    end
    for _, c in ipairs({ root:GetChildren() }) do
        WalkUIExact(c, depth + 1, hookFS)
    end
end

local charDelay
local function TranslateCharacterFrame()
    if not (db and db.ui) then return end
    pcall(WalkUIExact, CharacterFrame)
    pcall(WalkUIExact, PaperDollFrame)
    pcall(WalkUIExact, _G["AscensionCharacterFrame"], 0, true)
    if not charDelay then
        charDelay = CreateFrame("Frame")
    end
    local elapsed, shots = 0, 0
    charDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.3 then return end
        elapsed = 0
        shots = shots + 1
        pcall(WalkUIExact, CharacterFrame)
        pcall(WalkUIExact, PaperDollFrame)
        pcall(WalkUIExact, _G["AscensionCharacterFrame"], 0, true)
        if shots >= 3 then
            self:SetScript("OnUpdate", nil)
        end
    end)
end

if CharacterFrame and CharacterFrame.HookScript then
    CharacterFrame:HookScript("OnShow", TranslateCharacterFrame)
end
APT.TranslateCharacterFrame = TranslateCharacterFrame

local plateRootsSeen = setmetatable({}, { __mode = "k" })
local plateFSHooked = setmetatable({}, { __mode = "k" })
local inPlateFSHook = false

local function TranslatePlateFS(fs)
    if inPlateFSHook or not (db and db.units and APT.UnitNameEN2PT) then return end
    local text = fs and fs.GetText and fs:GetText()
    local translated = text and APT.UnitNameEN2PT[text]
    if translated and translated ~= text then
        inPlateFSHook = true
        pcall(fs.SetText, fs, translated)
        inPlateFSHook = false
    end
end

local function HookPlateFS(fs)
    if not (fs and fs.SetText) or plateFSHooked[fs] then return end
    plateFSHooked[fs] = true
    pcall(hooksecurefunc, fs, "SetText", TranslatePlateFS)
    TranslatePlateFS(fs)
end

local function ScanPlateRoot(fr, depth)
    if not (fr and fr.GetRegions and fr.GetChildren) or depth > 2 then return end
    for _, region in ipairs({ fr:GetRegions() }) do
        if region and region.IsObjectType and region:IsObjectType("FontString") then
            HookPlateFS(region)
        end
    end
    for _, child in ipairs({ fr:GetChildren() }) do
        ScanPlateRoot(child, depth + 1)
    end
end

local function ScanVisiblePlateRoots()
    if not (db and db.units and APT.UnitNameEN2PT and WorldFrame) then return end

    for _, child in ipairs({ WorldFrame:GetChildren() }) do
        local shown = not child.IsShown or child:IsShown()
        if shown and not plateRootsSeen[child] then
            plateRootsSeen[child] = true
            pcall(ScanPlateRoot, child, 0)
        end
    end
end

-- O cliente 3.3.5 não oferece um evento confiável para toda nameplate.
-- Em vez de varrer WorldFrame para sempre, fazemos pequenas rajadas somente
-- quando o alvo, o mouseover, o combate ou o mundo mudam.
local plateScanner = CreateFrame("Frame")
local plateElapsed, plateShots = 0, 0
local function StopPlateScan()
    plateElapsed, plateShots = 0, 0
    plateScanner:SetScript("OnUpdate", nil)
end
local function SchedulePlateScan()
    if not (db and db.units) then return end
    pcall(ScanVisiblePlateRoots)
    plateElapsed, plateShots = 0, 0
    plateScanner:SetScript("OnUpdate", function(self, dt)
        plateElapsed = plateElapsed + (dt or 0)
        if plateElapsed < 0.25 then return end
        plateElapsed = 0
        plateShots = plateShots + 1
        pcall(ScanVisiblePlateRoots)
        if plateShots >= 4 then StopPlateScan() end
    end)
end

local plateEvents = CreateFrame("Frame")
for _, event in ipairs({ "PLAYER_ENTERING_WORLD", "PLAYER_TARGET_CHANGED",
                         "UPDATE_MOUSEOVER_UNIT", "PLAYER_REGEN_DISABLED",
                         "NAME_PLATE_UNIT_ADDED", "NAME_PLATE_CREATED" }) do
    pcall(plateEvents.RegisterEvent, plateEvents, event)
end
plateEvents:SetScript("OnEvent", SchedulePlateScan)

local UNITFRAME_ROOTS = {
    "XPerl_Target", "XPerl_TargetTarget", "XPerl_Focus", "XPerl_Player",
    "TargetFrame", "FocusFrame", "GossipFrame", "QuestFrame",
}

local function WalkReplaceExact(root, em, es)
    if not (root and root.GetRegions and root.GetChildren) then return end
    local function visit(fr, depth)
        if depth > 6 then return end
        for _, r in ipairs({ fr:GetRegions() }) do
            if r.IsObjectType and r:IsObjectType("FontString") then
                if (r.GetText and r:GetText()) == em then
                    pcall(r.SetText, r, es)
                end
            end
        end
        for _, c in ipairs({ fr:GetChildren() }) do
            visit(c, depth + 1)
        end
    end
    pcall(visit, root, 0)
end

local function TranslateUnitFrames(unit)
    if not (db and db.units) then return end
    local guid = UnitGUID and UnitGUID(unit)
    local id = guid and NpcIdFromGUID(guid)
    local es = id and APT.UnitName[id]
    local em = UnitName and UnitName(unit)
    if not (es and em) or es == em then return end
    local g = APT.UnitNameEN[id]
    if g and g ~= em then return end
    for _, rn in ipairs(UNITFRAME_ROOTS) do
        WalkReplaceExact(_G[rn], em, es)
    end
end

local unitDelay
local function DelayedUnitPass(unit)
    if not unitDelay then
        unitDelay = CreateFrame("Frame")
    end
    local elapsed = 0
    unitDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.2 then return end
        self:SetScript("OnUpdate", nil)
        TranslateUnitFrames(unit)
    end)
end

local unitFrameWatcher = CreateFrame("Frame")
unitFrameWatcher:RegisterEvent("PLAYER_TARGET_CHANGED")
unitFrameWatcher:RegisterEvent("PLAYER_FOCUS_CHANGED")
unitFrameWatcher:RegisterEvent("GOSSIP_SHOW")
unitFrameWatcher:RegisterEvent("QUEST_GREETING")
unitFrameWatcher:RegisterEvent("QUEST_DETAIL")
unitFrameWatcher:RegisterEvent("QUEST_PROGRESS")
unitFrameWatcher:RegisterEvent("QUEST_COMPLETE")
unitFrameWatcher:SetScript("OnEvent", function(self, event)
    local unit = (event == "PLAYER_TARGET_CHANGED" and "target")
        or (event == "PLAYER_FOCUS_CHANGED" and "focus") or "npc"
    TranslateUnitFrames(unit)
    DelayedUnitPass(unit)
end)

local CASTBAR_ROOTS = {
    "CastingBarFrame", "TargetFrameSpellBar", "FocusFrameSpellBar",
    "Quartz3CastBarPlayer", "Quartz3CastBarTarget", "Quartz3CastBarFocus",
    "Quartz3CastBarPet", "QuartzCastBar",
}

local castDelay
local function TranslateCastbars(unit)
    if not (db and db.spells) then return end
    local name = UnitCastingInfo and UnitCastingInfo(unit)
    if not name and UnitChannelInfo then
        name = UnitChannelInfo(unit)
    end
    local es = name and APT.SpellNameEN2PT[name]
    if not es or es == name then return end
    for _, rn in ipairs(CASTBAR_ROOTS) do
        WalkReplaceExact(_G[rn], name, es)
    end
end

local function DelayedCastPass(unit)
    if not castDelay then
        castDelay = CreateFrame("Frame")
    end
    local elapsed = 0
    castDelay:SetScript("OnUpdate", function(self, dt)
        elapsed = elapsed + dt
        if elapsed < 0.1 then return end
        self:SetScript("OnUpdate", nil)
        TranslateCastbars(unit)
    end)
end

local castWatcher = CreateFrame("Frame")
castWatcher:RegisterEvent("UNIT_SPELLCAST_START")
castWatcher:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
castWatcher:SetScript("OnEvent", function(self, event, unit)
    if unit == "player" or unit == "target" or unit == "focus" or unit == "pet" then
        TranslateCastbars(unit)
        DelayedCastPass(unit)
    end
end)

local UPDATE_PREFIX = "AESver"
local myVersionStr = (GetAddOnMetadata and GetAddOnMetadata("AscensionPTBR", "Version")) or "0.0.0"

local function VersionScore(s)
    local a, b, c, suf = s:match("^(%d+)%.(%d+)%.(%d+)(%a?)$")
    if not a then return nil end
    return tonumber(a) * 1000000 + tonumber(b) * 10000 + tonumber(c) * 100
        + (suf ~= "" and (suf:lower():byte() - 96) or 0)
end

local myScore = VersionScore(myVersionStr) or 0
local notifiedScore = 0
local lastSent = {}
local REBROADCAST_CHANNELS = { PARTY = true, RAID = true, GUILD = true, BATTLEGROUND = true }

local UPDATE_URL = "https://github.com/HideXs/AscensionPTBR/releases"
local updPopup

local function TryOpenURL(url)
    for _, name in ipairs({ "OpenURL", "LaunchURL", "OpenExternalURL" }) do
        local fn = _G[name]
        if type(fn) == "function" and pcall(fn, url) then
            return true
        end
    end
    return false
end

local function ShowUpdatePopup(v)
    if not updPopup then
        local f = CreateFrame("Frame", "AscensionPTBRUpdate", UIParent)
        f:SetFrameStrata("DIALOG")
        f:SetWidth(440)
        f:SetHeight(150)
        f:SetPoint("TOP", UIParent, "TOP", 0, -140)
        f:SetCostasdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Costasground",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32,
            insets = { left = 11, right = 12, top = 12, bottom = 11 },
        })
        f:EnableMouse(true)
        local msg = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        msg:SetPoint("TOP", 0, -22)
        msg:SetWidth(400)
        f.msg = msg
        local eb = CreateFrame("EditBox", "AscensionPTBRUpdateEB", f, "InputBoxTemplate")
        eb:SetWidth(330)
        eb:SetHeight(20)
        eb:SetPoint("TOP", msg, "BOTTOM", 0, -10)
        eb:SetAutoFocus(false)
        eb:SetText(UPDATE_URL)
        eb:SetScript("OnTextChanged", function(self)

            if self:GetText() ~= UPDATE_URL then
                self:SetText(UPDATE_URL)
                self:HighlightText()
            end
        end)
        eb:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
        f.eb = eb
        local b1 = CreateFrame("Button", "AscensionPTBRUpdateB1", f, "UIPanelButtonTemplate")
        b1:SetWidth(160)
        b1:SetHeight(24)
        b1:SetPoint("BOTTOMRIGHT", f, "BOTTOM", -8, 18)
        b1:SetText("Actualizar")
        b1:SetScript("OnClick", function()
            if TryOpenURL(UPDATE_URL) then
                f:Hide()
                return
            end
            f.msg:SetText("Copia o enlace com |cffffffffCtrl+C|r e pégalo em seu navegador:")
            f.eb:SetFocus()
            f.eb:HighlightText()
        end)
        local b2 = CreateFrame("Button", "AscensionPTBRUpdateB2", f, "UIPanelButtonTemplate")
        b2:SetWidth(160)
        b2:SetHeight(24)
        b2:SetPoint("BOTTOMLEFT", f, "BOTTOM", 8, 18)
        b2:SetText("Cancelar")
        b2:SetScript("OnClick", function() f:Hide() end)
        updPopup = f
    end
    updPopup.msg:SetText("|cff33ff99AscensionPTBR|r: hay uma versión nueva |cffffffff" .. v
        .. "|r disponible (tem " .. myVersionStr .. ").")
    updPopup.eb:SetText(UPDATE_URL)
    updPopup:Show()
end

local function BroadcastVersion(chan)
    if not SendAddonMessage then return end
    local now = GetTime()
    if lastSent[chan] and now - lastSent[chan] < 30 then return end
    lastSent[chan] = now
    SendAddonMessage(UPDATE_PREFIX, "V:" .. myVersionStr, chan)
end

local function BroadcastAll()
    if GetNumRaidMembers and GetNumRaidMembers() > 0 then
        BroadcastVersion("RAID")
    elseif GetNumPartyMembers and GetNumPartyMembers() > 0 then
        BroadcastVersion("PARTY")
    end
    if IsInGuild and IsInGuild() then
        BroadcastVersion("GUILD")
    end
end

local updFrame = CreateFrame("Frame")
updFrame:RegisterEvent("CHAT_MSG_ADDON")
updFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
updFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
updFrame:RegisterEvent("RAID_ROSTER_UPDATE")
updFrame:SetScript("OnEvent", function(self, event, prefix, msg, channel)
    if event ~= "CHAT_MSG_ADDON" then
        BroadcastAll()
        return
    end
    if prefix ~= UPDATE_PREFIX or type(msg) ~= "string" then return end
    local v = msg:match("^V:(%d+%.%d+%.%d+%a?)$")
    local score = v and VersionScore(v)
    if not score then return end
    if score > myScore and score > notifiedScore then
        notifiedScore = score
        DEFAULT_CHAT_FRAME:AddMessage(
            "|cff33ff99AscensionPTBR|r: há uma nova versão disponível: |cffffffff" .. v
            .. "|r (você está usando " .. myVersionStr
            .. "). Baixe em |cff99ccffgithub.com/tuofxit/AscensionPT-BR|r.")
        pcall(ShowUpdatePopup, v)
    elseif score < myScore and channel and REBROADCAST_CHANNELS[channel] then
        BroadcastVersion(channel)
    end
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_ENTERING_WORLD" then
        -- Uma passada única é necessária porque muitos FontStrings já existem
        -- antes de os ganchos orientados a eventos serem instalados. Isto não
        -- reativa a antiga varredura periódica: executa somente ao entrar no
        -- mundo e deixa as atualizações posteriores para os painéis visíveis.
        RetranslateStaticUI()
        HookStaticPanels()

        local acf = _G["AscensionCharacterFrame"]
        if acf and acf.HookScript and not APT._charHooked then
            APT._charHooked = true
            acf:HookScript("OnShow", TranslateCharacterFrame)

            local statsScroll = _G["AscensionCharacterStatsPanelScrollFrame"]
            local statsPass = CreateFrame("Frame")
            local function OnStatsScroll()
                if not (db and db.ui) then return end
                pcall(WalkUIExact, _G["AscensionCharacterStatsPanel"], 0, true)
                local elapsed = 0
                statsPass:SetScript("OnUpdate", function(self, dt)
                    elapsed = elapsed + dt
                    if elapsed < 0.1 then return end
                    self:SetScript("OnUpdate", nil)
                    pcall(WalkUIExact, _G["AscensionCharacterStatsPanel"], 0, true)
                end)
            end
            if statsScroll and statsScroll.HookScript then
                if statsScroll:HasScript("OnVerticalScroll") then
                    statsScroll:HookScript("OnVerticalScroll", OnStatsScroll)
                end
                if statsScroll:HasScript("OnMouseWheel") then
                    statsScroll:HookScript("OnMouseWheel", OnStatsScroll)
                end
            end
        end
        return
    end
    if arg1 ~= "AscensionPTBR" then return end
    self:UnregisterEvent("ADDON_LOADED")

    AscensionPTBRDB = AscensionPTBRDB or {}
    db = AscensionPTBRDB
    for k, v in pairs(defaults) do
        if db[k] == nil then db[k] = v end
    end

    APT.ItemNameEN2PT = {}
    for id, em in pairs(APT.ItemNameEN or {}) do
        local es = APT.ItemName[id]
        if es and APT.ItemNameEN2PT[em] == nil then
            APT.ItemNameEN2PT[em] = es
        elseif es and APT.ItemNameEN2PT[em] ~= es then
            APT.ItemNameEN2PT[em] = false
        end
    end

    APT.UnitNameEN2PT = APT.UnitNameEN2PT or {}
    for id, em in pairs(APT.UnitNameEN or {}) do
        local es = APT.UnitName[id]
        if es and es ~= em then
            if APT.UnitNameEN2PT[em] == nil then
                APT.UnitNameEN2PT[em] = es
            elseif APT.UnitNameEN2PT[em] ~= es then
                APT.UnitNameEN2PT[em] = false
            end
        end
    end
    for em, es in pairs(APT.UnitNameEN2PT) do
        if es == false then APT.UnitNameEN2PT[em] = nil end
    end

    APT.QuestTitleEN2PT = {}
    APT.QuestTitleEN2ID = {}
    APT.QuestTitlePT2ID = {}
    APT.QuestTitleEN2IDs = {}
    APT.QuestTitlePT2IDs = {}
    APT.QuestTitleEN2PTByKey = {}
    APT.QuestTitleEN2IDsByKey = {}
    APT.QuestTitlePT2IDsByKey = {}
    for id, em in pairs(APT.QuestTitleEN or {}) do
        local es = APT.QuestTitle[id]
        if es then
            if APT.QuestTitleEN2PT[em] == nil then
                APT.QuestTitleEN2PT[em] = es
                APT.QuestTitleEN2ID[em] = id
            elseif APT.QuestTitleEN2PT[em] ~= es then
                APT.QuestTitleEN2PT[em] = false
                APT.QuestTitleEN2ID[em] = nil
            else

                APT.QuestTitleEN2ID[em] = nil
            end
            local l = APT.QuestTitleEN2IDs[em]
            if not l then l = {}; APT.QuestTitleEN2IDs[em] = l end
            l[#l + 1] = id
            if APT.QuestTitlePT2ID[es] == nil then
                APT.QuestTitlePT2ID[es] = id
            elseif APT.QuestTitlePT2ID[es] ~= id then
                APT.QuestTitlePT2ID[es] = false
            end
            local le = APT.QuestTitlePT2IDs[es]
            if not le then le = {}; APT.QuestTitlePT2IDs[es] = le end
            le[#le + 1] = id

            -- A tela clÃ¡ssica do Registro de MissÃµes transforma alguns
            -- cabeÃ§alhos em maiÃºsculas. As tabelas normais preservam a
            -- capitalizaÃ§Ã£o; estas chaves permitem encontrar a mesma missÃ£o
            -- sem aceitar tÃ­tulos ambÃ­guos.
            local enKey = QuestTitleKey(em)
            if enKey and enKey ~= "" then
                local enList = APT.QuestTitleEN2IDsByKey[enKey]
                if not enList then
                    enList = {}
                    APT.QuestTitleEN2IDsByKey[enKey] = enList
                end
                enList[#enList + 1] = id
                if APT.QuestTitleEN2PTByKey[enKey] == nil then
                    APT.QuestTitleEN2PTByKey[enKey] = es
                elseif APT.QuestTitleEN2PTByKey[enKey] ~= es then
                    APT.QuestTitleEN2PTByKey[enKey] = false
                end
            end

            local ptKey = QuestTitleKey(es)
            if ptKey and ptKey ~= "" then
                local ptList = APT.QuestTitlePT2IDsByKey[ptKey]
                if not ptList then
                    ptList = {}
                    APT.QuestTitlePT2IDsByKey[ptKey] = ptList
                end
                ptList[#ptList + 1] = id
            end
        end
    end
    if not db._v or db._v < 2 then
        db.units = false
        db._v = 2
    end
    if db._v < 3 then

        db.units = true
        db._v = 3
    end
    if db._v < 4 then

        db.gossip = true
        db._v = 4
    end

    APT.CustomUINorm = {}
    for raw, pt in pairs(APT.CustomUI or {}) do
        local key = NormalizeStaticKey(raw)
        if key and key ~= "" then APT.CustomUINorm[key] = pt end
    end

    APT.ServerUINorm = {}
    APT.ServerUIFragments = {}
    for raw, pt in pairs(APT.ServerUI or {}) do
        local key = NormalizeStaticKey(raw)
        if key and key ~= "" then APT.ServerUINorm[key] = pt end

        for _, tag in ipairs(SERVER_UI_FRAGMENT_TAGS) do
            local enParts, ptParts = {}, {}
            for part in raw:gmatch("<" .. tag .. "[^>]*>(.-)</" .. tag .. ">") do
                enParts[#enParts + 1] = part
            end
            for part in pt:gmatch("<" .. tag .. "[^>]*>(.-)</" .. tag .. ">") do
                ptParts[#ptParts + 1] = part
            end
            for i = 1, math.min(#enParts, #ptParts) do
                local fragmentKey = NormalizeStaticKey(enParts[i])
                if fragmentKey and fragmentKey ~= "" then
                    APT.ServerUIFragments[fragmentKey] = RenderServerFragment(ptParts[i])
                end
                if tag == "p" then
                    local enParagraphs = SplitServerParagraph(enParts[i])
                    local ptParagraphs = SplitServerParagraph(ptParts[i])
                    for j = 1, math.min(#enParagraphs, #ptParagraphs) do
                        local paragraphKey = NormalizeStaticKey(enParagraphs[j])
                        if paragraphKey and paragraphKey ~= "" then
                            APT.ServerUIFragments[paragraphKey] = RenderServerFragment(ptParagraphs[j])
                        end
                    end
                end
            end
        end
    end

    -- Evita que uma consulta feita durante a inicialização preserve um cache
    -- negativo depois que todos os índices e adaptadores já estão disponíveis.
    if APT.ClearStaticTextCache then APT.ClearStaticTextCache() end

    HookTooltip(GameTooltip)
    HookTooltip(ItemRefTooltip)

    HookTooltip(ShoppingTooltip1)
    HookTooltip(ShoppingTooltip2)
    HookTooltip(ShoppingTooltip3)
    HookTooltip(ItemRefShoppingTooltip1)
    HookTooltip(ItemRefShoppingTooltip2)

    local shopTips = {ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3,
                      ItemRefShoppingTooltip1, ItemRefShoppingTooltip2}

    local function TranslateShopTip(tip)
        if not db or not tip then return end
        pcall(TranslateTooltipLines, tip)
        local nm = tip:GetName()
        local ok, n = pcall(function() return tip:NumLines() end)
        if ok and n then
            for i = 1, n do
                local fs = _G[nm .. "TextLeft" .. i]
                if fs then
                    local txt = fs:GetText()
                    if txt and txt ~= "" then
                        local tr = TranslateStaticText(txt)
                            or (db.patterns and MatchLinePatterns(txt))
                        if not tr and APT.TranslateSystemTextStrict and not txt:find("\n") then
                            local tr2 = APT.TranslateSystemTextStrict(txt)
                            if tr2 ~= txt then tr = tr2 end
                        end
                        if tr and tr ~= txt then
                            inAPTSet = true
                            pcall(fs.SetText, fs, tr)
                            inAPTSet = false
                        end
                    end
                end
                local fsr = _G[nm .. "TextRight" .. i]
                if fsr then
                    local txtr = fsr:GetText()
                    if txtr and txtr ~= "" then
                        local trr = TranslateStaticText(txtr)
                            or (db.patterns and MatchLinePatterns(txtr))
                        if not trr and APT.TranslateSystemTextStrict and not txtr:find("\n") then
                            local tr2 = APT.TranslateSystemTextStrict(txtr)
                            if tr2 ~= txtr then trr = tr2 end
                        end
                        if trr and trr ~= txtr then
                            inAPTSet = true
                            pcall(fsr.SetText, fsr, trr)
                            inAPTSet = false
                        end
                    end
                end
            end
        end
    end

    for _, tip in ipairs(shopTips) do
        if tip then
            if tip.SetCompareItem then
                hooksecurefunc(tip, "SetCompareItem", function(self)
                    if not db then return end
                    TranslateShopTip(self)
                end)
            end
            if tip.SetHyperlinkCompareItem then
                hooksecurefunc(tip, "SetHyperlinkCompareItem", function(self)
                    if not db then return end
                    TranslateShopTip(self)
                end)
            end
        end
    end

-- shopDriver OnUpdate disabled: running TranslateShopTip on every single frame (60-144+ FPS) caused severe FPS drops.
-- Shop tips are already hooked via SetCompareItem, SetHyperlinkCompareItem, OnTooltipSetItem, OnShow, etc.


    HookAuras()
    HookSpellbook()
    HookAchievementAlerts()
    HookAchievementLinks()
    ApplyUIStrings()
    BuildOptionsPanel()

    if IsAddOnLoaded and IsAddOnLoaded("Blizzard_AchievementUI") then
        HookAchievementUI()
    end
    if IsAddOnLoaded and IsAddOnLoaded("Blizzard_TrainerUI") then
        HookTrainerUI()
    end
    if IsAddOnLoaded and IsAddOnLoaded("Blizzard_TradeSkillUI") then
        HookTradeSkillUI()
    end
    local waiter = CreateFrame("Frame")
    waiter:RegisterEvent("ADDON_LOADED")
    waiter:SetScript("OnEvent", function(w, _, name)
        if name == "Blizzard_AchievementUI" then
            HookAchievementUI()
        elseif name == "Blizzard_TrainerUI" then
            HookTrainerUI()
        elseif name == "Blizzard_TradeSkillUI" then
            HookTradeSkillUI()
        end
    end)

    local n = 0
    for _ in pairs(APT.SpellNameEN2PT) do n = n + 1 end
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "|cff33ff99AscensionPTBR|r carregado: %d nomes de habilidades, %d descrições, %d itens e %d NPCs. Use /ases para abrir as opções.",
        n, #APT.DescPairs, (function() local c = 0 for _ in pairs(APT.ItemName) do c = c + 1 end return c end)(),
        (function() local c = 0 for _ in pairs(APT.UnitName) do c = c + 1 end return c end)()))
end)

SLASH_ASCENSIONPTBR1 = "/ases"
SLASH_ASCENSIONPTBR2 = "/ascensiones"
SlashCmdList["ASCENSIONPTBR"] = function(msg)
    msg = (msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    local function status(v) return v and "|cff33ff99SÍ|r" or "|cffff3333NO|r" end
    if msg == "feitiços" or msg == "spells" then
        db.spells = not db.spells
    elseif msg == "itens" or msg == "items" then
        db.items = not db.items
    elseif msg == "npcs" or msg == "units" then
        db.units = not db.units
    elseif msg == "lineas" or msg == "patterns" then
        db.patterns = not db.patterns
    elseif msg == "ambiental" or msg == "flavor" then
        db.flavor = not db.flavor
    elseif msg == "conquistas" or msg == "achievements" then
        db.achievements = not db.achievements
    elseif msg == "missões" or msg == "quests" then
        db.quests = not db.quests
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r missões em español: " .. status(db.quests))
        return
    elseif msg == "dialogos" or msg == "diálogos" or msg == "gossip" then
        db.gossip = not db.gossip
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r diálogos de NPC em español: " .. status(db.gossip))
        return
    elseif msg == "capturar" or msg == "capture" then
        db.capture = not db.capture
        if db.capture then
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r CAPTURADOR ACTIVADO: pasa o ratón por todos os tooltips que quieras registrar (stats, paneles...). Quando termines: /ases capturar para parar e /reload para guardar.")
        else
            local n = 0
            for _ in pairs(db.captured or {}) do n = n + 1 end
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r capturador parado: " .. n .. " textos registrados. Haz /reload para volcarlos ao disco.")
        end
        return
    elseif msg == "mision" then

        local out = {}
        out[#out + 1] = "GetQuestID: " .. tostring(GetQuestID and (GetQuestID() or "nil") or "NO EXISTE")
        out[#out + 1] = "questLog: " .. tostring(QuestInfoFrame and QuestInfoFrame.questLog)
        local th = _G["QuestInfoTitleHeader"]
        local title = th and th.GetText and th:GetText() or "(sem título)"
        out[#out + 1] = "título mostrado: [" .. tostring(title) .. "]"
        local id = title and ((APT.QuestTitleEN2ID and APT.QuestTitleEN2ID[title])
            or (APT.QuestTitlePT2ID and APT.QuestTitlePT2ID[title]))
        if (not id or id == false) and title then
            id = ResolveQuestIDByPanels(title)
            if id then out[#out + 1] = "ID por TEXTO (cadena de título repetido)" end
        end
        out[#out + 1] = "ID por título: " .. tostring(id)
        local qid = tonumber(GetQuestID and GetQuestID() or nil)
        if not qid or qid == 0 then qid = tonumber(id) end
        if qid and APT.QuestData[qid] then
            local qd = APT.QuestData[qid]
            out[#out + 1] = "datos: SÍ (d=" .. tostring(qd.d ~= nil) .. " o=" .. tostring(qd.o ~= nil)
                .. " p=" .. tostring(qd.p ~= nil) .. " c=" .. tostring(qd.c ~= nil) .. ")"
            local checks = {
                { "desc", "QuestInfoDescriptionText", qd.dEN },
                { "obj", "QuestInfoObjectivesText", qd.oEN },
                { "entregue", "QuestInfoRewardText", qd.cEN },
            }
            for _, ck in ipairs(checks) do
                local fs = _G[ck[2]]
                local shown = fs and fs.GetText and fs:GetText()
                if shown and shown ~= "" and ck[3] then
                    local a = QuestNormalizeShown(shown)
                    local b = CollapseWS(ck[3]:gsub("\r", ""))
                    out[#out + 1] = "guarda " .. ck[1] .. ": " .. (a == b and "CASA" or "NO casa")
                    if a ~= b then
                        local n = math.min(#a, #b)
                        local i = n + 1
                        for j = 1, n do
                            if a:sub(j, j) ~= b:sub(j, j) then
                                i = j
                                break
                            end
                        end
                        out[#out + 1] = "  difiere em " .. i .. ": vivo=[" ..
                            a:sub(math.max(1, i - 15), i + 25):gsub("|", "||") .. "] datos=[" ..
                            b:sub(math.max(1, i - 15), i + 25):gsub("|", "||") .. "]"
                    end
                end
            end
        else
            out[#out + 1] = "datos: NO para id " .. tostring(qid)
        end
        for _, l in ipairs(out) do
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES missão|r " .. l)
        end
        return
    elseif msg == "interfaz" or msg == "ui" then
        db.ui = not db.ui
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interfaz cambiada: haz /reload para aplicar")
    elseif msg == "chat" then
        local newState = not (db.chat ~= false)
        if APT.SetChatEnabled then APT.SetChatEnabled(newState) else db.chat = newState end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r mensajes de chat em español: " .. status(db.chat))
        return
    elseif msg == "errores" or msg == "errors" then
        local newState = not (db.errores ~= false)
        if APT.SetErrorsEnabled then APT.SetErrorsEnabled(newState) else db.errores = newState end
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r mensajes de error em español: " .. status(db.errores))
        return
        elseif msg == "refrescar" or msg == "refresh" then
        RetranslateStaticUI()
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r interfaz estática retraducida")
        return
    elseif msg == "traduce" then

        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r sonda-traduce armada: abre o tooltip e mantenlo 4 s...")
        local probe = CreateFrame("Frame")
        local elapsed = 0
        probe:SetScript("OnUpdate", function(self, dt)
            elapsed = elapsed + dt
            if elapsed < 4 then return end
            self:SetScript("OnUpdate", nil)
            if not GameTooltip:IsVisible() then
                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES|r o tooltip no estaba visible")
                return
            end
            local list = CollectTooltipFontStrings(GameTooltip)
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES|r FontStrings recogidos: " .. #list)
            for i, fs in ipairs(list) do
                if i <= 8 then
                    local t = fs:GetText() or ""
                    t = t:gsub("|", "||"):sub(1, 55)
                    DEFAULT_CHAT_FRAME:AddMessage("  " .. i .. ": " .. t)
                end
            end
            local ok, err = pcall(TranslateTooltipLines, GameTooltip)
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES|r pasada manual: " .. (ok and "ejecutada" or ("ERROR: " .. tostring(err))))
        end)
        return
    elseif msg:match("^volcar") then

        local needle = msg:match("^volcar%s+(.+)$") or "Deals"
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r sonda armada: pasa o ratón pelo tooltip — volcado em 4 s...")
        local probe = CreateFrame("Frame")
        local elapsed = 0
        probe:SetScript("OnUpdate", function(self, dt)
            elapsed = elapsed + dt
            if elapsed < 4 then return end
            self:SetScript("OnUpdate", nil)
            local found = 0
            local frame = EnumerateFrames()
            while frame do
                local ok, regions = pcall(function() return { frame:GetRegions() } end)
                if ok and regions then
                    for _, r in ipairs(regions) do
                        if r and r.IsObjectType and r:IsObjectType("FontString")
                            and r.IsVisible and r:IsVisible() then
                            local t = r:GetText()
                            if t and t:lower():find(needle, 1, true) then
                                found = found + 1
                                local f, chain = frame, {}
                                while f and #chain < 6 do
                                    chain[#chain + 1] = (f.GetName and f:GetName()) or "(anónimo)"
                                    f = f.GetParent and f:GetParent()
                                end
                                DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES sonda|r " .. found .. ": " .. table.concat(chain, " < "))
                                local shown = t:gsub("|", "||"):gsub("\n", "\\n"):gsub("\r", "\\r")
                                if #shown > 150 then shown = shown:sub(1, 150) .. "..." end
                                DEFAULT_CHAT_FRAME:AddMessage("    texto crudo: [" .. shown .. "]")
                            end
                        end
                    end
                end
                frame = EnumerateFrames(frame)
            end
            DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES sonda|r fin: " .. found .. " coincidencias de '" .. needle .. "'")
        end)
        return
    elseif msg ~= "" then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AscensionPTBR|r comandos: /ases feitiços | itens | npcs | dialogos | lineas | ambiental | conquistas | interfaz | refrescar")
        return
    end
    DEFAULT_CHAT_FRAME:AddMessage(format(
        "|cff33ff99AscensionPTBR|r feitiços:%s itens:%s npcs:%s líneas:%s ambiental:%s missões:%s diálogos:%s conquistas:%s interfaz:%s",
        status(db.spells), status(db.items), status(db.units), status(db.patterns), status(db.flavor),
        status(db.quests), status(db.gossip), status(db.achievements), status(db.ui)))
end

SLASH_APTBRINSPECT1 = "/aptbrinspect"
SlashCmdList["APTBRINSPECT"] = function()
    local frame = _G["PathToAscensionFrame"]
    if not frame then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES inspect|r PathToAscensionFrame não encontrado")
        return
    end
    if not frame.IsVisible or not frame:IsVisible() then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99AES inspect|r PathToAscensionFrame não está visível")
        return
    end
    local out = {}
    local hasFontString = false
    local hasSimpleHTML = false
    local function inspectRegion(fr, depth)
        if depth > 10 then return end
        local indent = string.rep("  ", depth)
        local name = fr.GetName and (fr:GetName() or "(sem nome)") or "(sem nome)"
        local objType = fr.IsObjectType and (
            (fr:IsObjectType("Frame") and "Frame")
            or (fr:IsObjectType("Button") and "Button")
            or (fr:IsObjectType("SimpleHTML") and "SimpleHTML")
            or (fr:IsObjectType("FontString") and "FontString")
            or (fr:IsObjectType("Texture") and "Texture")
        ) or "?"
        local line = indent .. name .. " (" .. objType .. ")"
        if objType == "Texture" then
            local path = fr.GetTexture and fr:GetTexture()
            if path then line = line .. " textura=" .. path end
        elseif objType == "FontString" then
            hasFontString = true
            local text = fr.GetText and fr:GetText()
            if text and text ~= "" then
                local short = text:gsub("|", "||"):gsub("[\r\n]", " "):sub(1, 120)
                line = line .. " texto=[" .. short .. "]"
                local es = TranslateStaticText(text)
                if es and es ~= text then
                    pcall(fr.SetText, fr, es)
                    line = line .. " |cff33ff99TRADUZIDO|r"
                end
            end
        elseif objType == "SimpleHTML" then
            hasSimpleHTML = true
            local text = fr.GetText and fr:GetText()
            if text and text ~= "" then
                local short = text:gsub("|", "||"):gsub("[\r\n]", " "):sub(1, 120)
                line = line .. " html=[" .. short .. "]"
                local es = TranslateStaticText(text)
                if es and es ~= text then
                    pcall(fr.SetText, fr, es)
                    line = line .. " |cff33ff99TRADUZIDO|r"
                end
            end
        end
        if fr.GetWidth and fr.GetHeight then
            line = line .. " dim=" .. math.floor(fr:GetWidth() + 0.5) .. "x" .. math.floor(fr:GetHeight() + 0.5)
        end
        local parent = fr.GetParent and fr:GetParent()
        if parent then
            local pn = parent.GetName and (parent:GetName() or "(sem nome)") or "(sem nome)"
            local po = parent.IsObjectType and (
                parent:IsObjectType("Frame") and "Frame"
                or (parent:IsObjectType("Button") and "Button")
            ) or "?"
            line = line .. " parent=" .. pn .. "(" .. po .. ")"
        end
        out[#out + 1] = "|cff33ff99AES inspect|r " .. line
        local ok, regions = pcall(function() return { fr:GetRegions() } end)
        if ok and regions then
            for _, r in ipairs(regions) do inspectRegion(r, depth + 1) end
        end
        local okc, children = pcall(function() return { fr:GetChildren() } end)
        if okc and children then
            for _, c in ipairs(children) do inspectRegion(c, depth + 1) end
        end
    end
    out[#out + 1] = "|cff33ff99AES inspect|r --- PathToAscensionFrame ---"
    inspectRegion(frame, 0)
    if not hasFontString and not hasSimpleHTML then
        out[#out + 1] = "|cff33ff99AES inspect|r AVISO: nenhum FontString ou SimpleHTML encontrado — o conteúdo pode ser uma Texture"
        out[#out + 1] = "|cff33ff99AES inspect|r Se o texto estiver embutido em uma textura, não é possível traduzir via SetText."
        out[#out + 1] = "|cff33ff99AES inspect|r Seria necessário substituir o arquivo de textura por uma versão em PT-BR."
    end
    out[#out + 1] = "|cff33ff99AES inspect|r --- fim ---"
    DEFAULT_CHAT_FRAME:AddMessage(table.concat(out, "\n"))
end

AscensionPTBR.__firma = "AES/2026-07-26/5e72a60cd2ebbd20/HideXs"
