local function git_relative_path()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then return "" end

  -- Determine git root from the directory of the file
  local git_root = vim.fn.systemlist(
    "git -C " .. vim.fn.shellescape(vim.fn.fnamemodify(file, ":h"))
    .. " rev-parse --show-toplevel"
  )[1]

  if git_root and git_root ~= "" then
    -- Return file path relative to the git root
    local rel = file:sub(#git_root + 2) -- trim "/"
    return rel
  end

  -- Not in git → show just filename
  return vim.fn.fnamemodify(file, ":t")
end


return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {git_relative_path},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
    },
}
