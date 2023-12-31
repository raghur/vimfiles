
local utils = require('raghu.utils')

local instance = {}
instance.family = function(newFont)
  if (vim.env.TERM) then return end
  if newFont then
    -- if size spec is provided, then directly apply
    if string.find(newFont, ":h") then
      vim.o.guifont = newFont
    else
      -- extract size
      local size = instance.size()
      vim.o.guifont = newFont.. ":h" .. size
    end
  else
    local fontName = vim.o.guifont
    local idx = string.find(fontName, ":")
    if idx then
      return string.sub(fontName, 1, idx - 1)
    else
      return fontName
    end
  end
end

instance.size = function(size)
  local fontname = instance.family()
  if (not fontname) then return end
  if (size) then
    vim.o.guifont = fontname .. ":h" .. size
  else
    local font = vim.o.guifont
    local idx = string.find(font, ":h")
    if (not idx) then return 12 end
    size = tonumber(string.sub(font,idx+2))
    utils.dbg(idx, font, size)
    return size
  end
end

instance.adjust = function(step)
  local newSize = instance.size() + step
  instance.size(newSize)
end

return instance
