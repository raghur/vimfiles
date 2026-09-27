vim.cmd([[

function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf('%10s', lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
command! -nargs=+ -bang -complete=command R call utils#ReadExCommandOutput(<bang>1, <q-args>)
inoremap <c-r>R <c-o>:<up><home>R! <cr>

command! BlogSave call utils#BlogSave(expand("%:p"))

set foldtext=NeatFoldText()
]])

-- `:w !sudo tee` cannot prompt for a password in Neovim (no TTY), so ask for it
-- here and feed it to sudo on stdin.
vim.api.nvim_create_user_command("W", function()
  local path = vim.fn.expand("%:p")
  if path == "" then
    vim.notify("Buffer has no file name", vim.log.levels.ERROR)
    return
  end
  local password = vim.fn.inputsecret("sudo password: ")
  local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, true), "\n") .. "\n"
  local result = vim.system({ "sudo", "-S", "-p", "", "tee", path }, {
    stdin = password .. "\n" .. content,
    text = true,
  }):wait()
  if result.code ~= 0 then
    vim.notify("sudo write failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
    return
  end
  vim.bo.modified = false
  vim.cmd.checktime()
  vim.notify("Wrote " .. path .. " with sudo", vim.log.levels.INFO)
end, { desc = "Write the current file with sudo" })
