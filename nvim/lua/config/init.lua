require("config.set")
require("config.keymap")
require("config.lazy")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Ensure the buffer is valid
    if not args.buf then return end

    -- Set buffer-local keybindings
    local opts = { buffer = args.buf }

    -- LSP navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, {
      desc = "Go to definition"
    }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, {
      desc = "Go to declaration"
    }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, {
      desc = "Go to implementation"
    }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, {
      desc = "List references"
    }))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, {
      desc = "Hover documentation"
    }))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, {
      desc = "Show signature help"
    }))

    -- LSP actions
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, {
      desc = "Rename symbol"
    }))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, {
      desc = "Code actions"
    }))

    -- Diagnostics navigation
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, {
      desc = "Go to previous diagnostic"
    }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, {
      desc = "Go to next diagnostic"
    }))
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, {
      desc = "Show diagnostic in floating window"
    }))
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, {
      desc = "Populate location list with diagnostics"
    }))
  end,
})

vim.diagnostic.config({ virtual_text = true })
