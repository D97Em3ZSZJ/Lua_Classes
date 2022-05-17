
local event = {}

function event.new()
  local self = {}
  self.listeners = {}
  
  setmetatable(self, {
    __newindex = function()
      return error('attempt to modify a read-only table')
    end,
  })

  function self:connect(callback)
    local listener = {}
    listener.callback = callback
    listener.id = #self.listeners + 1
    self.listeners[listener.id] = listener

    function listener:disconnect()
      self.listeners[listener.id] = nil
    end 

    return listener
  end 

  function self:close()
    self.listeners = nil 
    self = nil
  end 

  function self:fire(...)
    for i = 1, #self.listeners do
      local listener = self.listeners[i]
      listener.callback(...)
    end
  end 

  return self
end 

return event 
