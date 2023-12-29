
local utils = require('raghu.utils')

local instance = {}
instance.font = function(newFont)
  if (vim.env.TERM) then return end
  if newFont then
    if string.find(newFont, ":h") then
      vim.o.guifont = newFont
    else
      local size = instance.fontSize()
      vim.opt.guifont = {newFont, ":h" .. size}
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

instance.fontSize = function(size)
  local fontname = instance.font()
  if (not fontname) then return end
  if (size) then
    vim.opt.guifont = {fontname, ":h" .. size}
  else
    local font = vim.o.guifont
    local idx = string.find(font, ":h")
    if (not idx) then return 12 end
    size = tonumber(string.sub(font,idx+2))
    utils.dbg(idx, font, size)
    return size
  end
end

return instance
