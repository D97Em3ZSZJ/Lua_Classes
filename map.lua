--[[
  Lua implmentation of javascript maps.
  by: OkBuddy
]]

--// Map class 
local map = {}

--// Functions 
function map.new()
  local self = {}
  self.data = {}
  self.size = 0 

  --// Functions
  function self.set(key, value)
    self.data[key] = value
    self.size = self.size + 1
  end

  function self.get(key)
    return self.data[key]
  end

  function self.has(key)
    return self.data[key] ~= nil
  end

  function self.delete(key)
    self.data[key] = nil
    self.size = self.size - 1
  end

  function self.clear()
    self.data = {}
    self.size = 0
  end

  function self.keys()
    local keys = {}
    for k,v in pairs(self.data) do
      table.insert(keys, k)
    end
    return keys
  end

  function self.values()
    local values = {}
    for k,v in pairs(self.data) do
      table.insert(values, v)
    end
    return values
  end

  function self.entries()
    local entries = {}
    for k,v in pairs(self.data) do
      table.insert(entries, {key = k, value = v})
    end
    return entries
  end

  function self.forEach(callback)
    for k,v in pairs(self.data) do
      callback(k, v)
    end
  end

  return self
end 

return map 
