return {
        "jalvesaq/zotcite",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim",
        },
        config = function ()
            require("zotcite").setup({
              python_path = "/home/rich/.zocite/.venv/bin/python3",
              open_in_zotero = true,
            })
        end
    }
