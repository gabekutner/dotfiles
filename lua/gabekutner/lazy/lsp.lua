return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "rafamadriz/friendly-snippets",
    },

    config = function()
        local cmp = require("cmp")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "ts_ls", "gopls" },
        })

        require("fidget").setup({})
        require("luasnip.loaders.from_vscode").lazy_load()

        vim.lsp.config('lua_ls', {
            capabilities = capabilities,
            root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        vim.lsp.config("pyright", {
            capabilities = capabilities,
        })

        vim.lsp.config("ts_ls", {
            capabilities = capabilities,
            root_dir = function(bufnr, on_dir)
                local fname = vim.api.nvim_buf_get_name(bufnr)
                local root = vim.fs.root(fname, { "tsconfig.json", "jsconfig.json", "package.json", ".git" })
                on_dir(root)
            end,
        })

        vim.lsp.config("gopls", {
            capabilities = capabilities,
        })

        vim.lsp.enable("lua_ls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("ts_ls")
        vim.lsp.enable("gopls")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
        })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})        
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {})
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {})
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {})
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {})
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {})
    end
}
