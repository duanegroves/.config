return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "vtsls",
                "pyright"
            },
            ["lua_la"] = function() 
                local lspconfig = require("lspconfig")
                lspconfig.lua_ls.setup{
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                }
            end
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            "neovim/nvim-lspconfig",
            -- For nvim-cmp
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            -- For luasnip users.
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
        config = function()
            local cmp = require'cmp'

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
--                mapping = cmp.mapping.preset.insert({
--                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
--                    ['<C-Space>'] = cmp.mapping.complete(),
--                    ['<C-e>'] = cmp.mapping.abort(),
--                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                })
            })
        end
    },
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
}
