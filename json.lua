--[[
  Better json encoding for lua
  Might add some more functionality later just needed a quick json beautifer
]]

--// Class 
local json = {}

--// Functions 
function json.stringify(object : object, spacing : int, depth : ignore)
  depth = depth or 1
  spacing = spacing or 2
  local result = '{\n'
  local indent = string.rep(' ', spacing)
  indent = string.rep(indent, depth)

  for key, value in next, object do 
    key = '"' .. key .. '"'
    if type(value) == 'table' then --// Arrays 
      result = result .. indent .. key .. ' : ' .. json.encode(value, spacing, depth + 1) .. ',\n'
    elseif type(value) == 'string' then --// Strings
      result = result .. indent .. key .. ' : "' .. value .. '",\n'
    elseif type(value) == 'function' then --// Functions 
      local name = debug.getinfo(value).name
      name = name == '' and '<function>' or name
      result = result .. indent .. key .. ' : ' .. ('"' .. name .. '"') .. ',\n'
    else 
      result = result .. indent .. key .. ' : ' .. tostring(value) .. ',\n'
    end 
  end 

  result = result:sub(1, -3) --// Removes last comma 
  result = result .. '\n' .. string.rep(' ', spacing * (depth - 1)) .. '}'

  return result
end 

return json 
