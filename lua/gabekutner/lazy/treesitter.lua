return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { 
                "lua", 
                "vim",
                "vimdoc",
                "javascript", 
                "typescript", 
                "tsx", 
                "go",
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
