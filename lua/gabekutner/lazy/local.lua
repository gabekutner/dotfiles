return {
    {
        "cheatsheet",
        dir = "~/personal/cheatsheet",
        config = function()
            local cheatsheet = require("cheatsheet")

            -- Re-apply highlights after colorscheme is set
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    cheatsheet.setup()
                end,
            })

            -- Also call setup initially, in case it loads first
            cheatsheet.setup()

            vim.keymap.set("n", "<leader>cs", cheatsheet.toggle, { desc = "Toggle Cheatsheet" })
        end
    },
}
