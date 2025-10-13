require("config.set")
require("config.keymap")
require("config.lazy")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Ensure the buffer is valid
    if not args.buf then return end

    -- Set buffer-local keybindings
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)       -- Go to definition
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)      -- Go to declaration
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)   -- Go to implementation
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)       -- List references
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)             -- Hover info
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- Signature help

    -- LSP actions
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)  -- Rename symbol
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code actions

    -- Diagnostics navigation
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts) -- Show diagnostics in floating window
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts) -- Set diagnostics in location list
  end,
})


vim.diagnostic.config({ virtual_text = true })
