

-- Inspired by something on: https://stackoverflow.com/questions/37447704/what-is-the-alternative-for-switch-statement-in-lua-language

return function switch(value)
  local constructor = {}
  constructor.value = value
  constructor.functions = {}
  
  constructor.case = function(value, func)
    constructor.functions[value] = func
    return constructor
  end 

  constructor.default = function(func)
    constructor.default = func
    return constructor
  end 

  constructor.flick = function(value)
    local case = constructor.functions[constructor.value]
    if case then
      case()
    elseif constructor.default then
      constructor.default()
    else 
      error('Failed to find a case for value: ' .. value)
    end
  end

  return constructor
end 

-- Use Case: 
--[[
  switch(5)
  .case(2, function() print("2") end)
  .case(3, function() print("3") end)
  .default(function() print("default") end)
  .flick(1)
]]
