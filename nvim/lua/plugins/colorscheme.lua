return {
--     {
--         "xero/miasma.nvim",
--         lazy = false,
--         priority = 1000,
--         config = function()
--             vim.cmd("colorscheme miasma")
--         end,
--     },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    }
}
