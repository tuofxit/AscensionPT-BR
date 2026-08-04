local APT = AscensionPTBR
if type(APT) ~= "table" then return end

local PD = PatternDictionary
if not PD or type(PD.Translate) ~= "function" then return end

if not GlossarioPTBR or type(GlossarioPTBR) ~= "table" then return end

PD:SetGlossary(GlossarioPTBR)

if not PD.compiled then PD:Compile() end

-- Wrapper 1: TranslateStaticText (global, Core.lua:895) — tooltips + UI
-- Core.lua keeps TranslateStaticText as a local upvalue. Replacing a global
-- function here cannot affect the Core tooltip path and can leave callers with
-- a nil original function. Expose a conservative fallback instead; Core opts
-- into it only after its exact dictionaries have been checked.
local EnglishWords = {
  "the", "and", "your", "you", "with", "from", "into", "while", "before",
  "after", "healing", "damage", "done", "increases", "reduces", "requires",
  "level", "spell", "power", "rating", "chance", "health", "mana", "energy",
  "attack", "critical", "bank", "guild", "personal", "soulbound", "items",
}

local function IsSafePatternResult(text)
  if type(text) ~= "string" or text == "" then return false end
  local lower = text:lower()
  for _, word in ipairs(EnglishWords) do
    if lower:find("%f[%a]" .. word .. "%f[^%a]") then return false end
  end
  return true
end

APT.TranslatePatternFallback = function(text)
  if type(text) ~= "string" or text == "" then return nil end
  local ok, translated = pcall(PD.Translate, PD, text)
  if ok and translated and translated ~= text and IsSafePatternResult(translated) then
    return translated
  end
  return nil
end

-- Wrapper 2: APT.TranslateSystemText (Chat.lua:43) — chat messages
local OrigTranslateSystemText = APT.TranslateSystemText

APT.TranslateSystemText = function(msg)
  if not msg or msg == "" then
    return type(OrigTranslateSystemText) == "function" and OrigTranslateSystemText(msg) or msg
  end
  local originalResult = type(OrigTranslateSystemText) == "function"
      and OrigTranslateSystemText(msg) or msg
  if originalResult ~= msg then return originalResult end
  local pdResult = APT.TranslatePatternFallback(msg)
  if pdResult then return pdResult end
  return originalResult
end

-- Wrapper 3: APT.TranslateSystemTextStrict (Chat.lua:59) — strict system text
local OrigTranslateSystemTextStrict = APT.TranslateSystemTextStrict

APT.TranslateSystemTextStrict = function(msg)
  if not msg or msg == "" then
    return type(OrigTranslateSystemTextStrict) == "function" and OrigTranslateSystemTextStrict(msg) or msg
  end
  local originalResult = type(OrigTranslateSystemTextStrict) == "function"
      and OrigTranslateSystemTextStrict(msg) or msg
  if originalResult ~= msg then return originalResult end
  local pdResult = APT.TranslatePatternFallback(msg)
  if pdResult then return pdResult end
  return originalResult
end
