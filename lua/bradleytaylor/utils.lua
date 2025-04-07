local M = {}

M.cmd = function(command)
  return '<cmd>' .. command .. '<cr>'
end

M.keymap = function(mode, keys, func, desc)
  vim.keymap.set(mode, keys, func, { desc = desc })
end

return M
