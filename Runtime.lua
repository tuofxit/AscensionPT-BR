-- Agendador central leve, adaptado da arquitetura de desempenho da versao
-- 1.5.0 de GabrielBosco/AscensionPTBR. Um unico OnUpdate atende tarefas curtas.

AscensionPTBR = AscensionPTBR or {}
local A = AscensionPTBR

A.Runtime = A.Runtime or {}
local Runtime = A.Runtime

Runtime.tasks = Runtime.tasks or {}
Runtime.clock = Runtime.clock or 0
Runtime.frame = Runtime.frame or CreateFrame("Frame")

local function reportError(err)
    if geterrorhandler then
        local handler = geterrorhandler()
        if handler then handler(err) end
    end
end

local function recomputeNextDue()
    local nextDue
    for _, task in pairs(Runtime.tasks) do
        local due = task and task.due
        if type(due) == "number" and (not nextDue or due < nextDue) then
            nextDue = due
        end
    end
    Runtime.nextDue = nextDue
end

function Runtime.Cancel(key)
    if key ~= nil then Runtime.tasks[key] = nil end
    if next(Runtime.tasks) == nil then
        Runtime.nextDue = nil
        Runtime.frame:SetScript("OnUpdate", nil)
    else
        recomputeNextDue()
    end
end

function Runtime.After(key, delay, callback)
    if key == nil or type(callback) ~= "function" then return end
    local due = Runtime.clock + (tonumber(delay) or 0)
    Runtime.tasks[key] = { due = due, callback = callback }
    if not Runtime.nextDue or due < Runtime.nextDue then Runtime.nextDue = due end
    if not Runtime.frame:GetScript("OnUpdate") then
        Runtime.frame:SetScript("OnUpdate", Runtime.OnUpdate)
    end
end

function Runtime.OnUpdate(self, elapsed)
    Runtime.clock = Runtime.clock + (elapsed or 0)
    local now = Runtime.clock
    if Runtime.nextDue and now < Runtime.nextDue then return end

    for key, task in pairs(Runtime.tasks) do
        if task and now >= task.due then
            Runtime.tasks[key] = nil
            local ok, err = pcall(task.callback)
            if not ok then reportError(err) end
        end
    end

    if next(Runtime.tasks) == nil then
        Runtime.nextDue = nil
        self:SetScript("OnUpdate", nil)
    else
        recomputeNextDue()
    end
end

-- Agenda uma sequencia de atrasos absolutos usando a mesma chave. Uma nova
-- chamada substitui a sequencia anterior, evitando filas duplicadas ao abrir
-- ou trocar rapidamente de painel.
function Runtime.Sequence(key, delays, callback)
    if key == nil or type(delays) ~= "table" or type(callback) ~= "function" then return end
    local generation = (Runtime.generations and Runtime.generations[key] or 0) + 1
    Runtime.generations = Runtime.generations or {}
    Runtime.generations[key] = generation

    local index = 1
    local previous = 0
    local function queueNext()
        if Runtime.generations[key] ~= generation then return end
        local absolute = tonumber(delays[index])
        if not absolute then return end
        local delay = math.max(0, absolute - previous)
        previous = absolute
        Runtime.After(key, delay, function()
            if Runtime.generations[key] ~= generation then return end
            callback(index)
            index = index + 1
            queueNext()
        end)
    end
    queueNext()
end
