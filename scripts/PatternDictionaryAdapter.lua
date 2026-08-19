local APT = AscensionPTBR
if type(APT) ~= "table" then return end

local PD = PatternDictionary
if not PD or type(PD.Translate) ~= "function" then return end

if not GlossarioPTBR or type(GlossarioPTBR) ~= "table" then return end

PD:SetGlossary(GlossarioPTBR)

if not PD.compiled then PD:Compile() end

-- Wrapper 1: TranslateStaticText (global, Core.lua:895) — tooltips + UI
local OrigTranslateStaticText = TranslateStaticText

TranslateStaticText = function(t)
  if not t or t == "" then return OrigTranslateStaticText(t) end
  local ok, pdResult = pcall(PD.Translate, PD, t)
  if ok and pdResult and pdResult ~= t then return pdResult end
  return OrigTranslateStaticText(t)
end

APT.TranslateStaticText = TranslateStaticText

-- Wrapper 2: APT.TranslateSystemText (Chat.lua:43) — chat messages
local OrigTranslateSystemText = APT.TranslateSystemText

APT.TranslateSystemText = function(msg)
  if not msg or msg == "" then return OrigTranslateSystemText(msg) end
  local ok, pdResult = pcall(PD.Translate, PD, msg)
  if ok and pdResult and pdResult ~= msg then return pdResult end
  return OrigTranslateSystemText(msg)
end

-- Wrapper 3: APT.TranslateSystemTextStrict (Chat.lua:59) — strict system text
local OrigTranslateSystemTextStrict = APT.TranslateSystemTextStrict

APT.TranslateSystemTextStrict = function(msg)
  if not msg or msg == "" then return OrigTranslateSystemTextStrict(msg) end
  local ok, pdResult = pcall(PD.Translate, PD, msg)
  if ok and pdResult and pdResult ~= msg then return pdResult end
  return OrigTranslateSystemTextStrict(msg)
end
