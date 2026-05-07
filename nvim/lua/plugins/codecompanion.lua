return {
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  opts = {
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              default = "gemini-3-flash-preview", -- Current fast model for 2026
            },
          },
          env = {
            api_key = "GEMINI_API_KEY",
          },
        })
      end,
    },
    strategies = {
      chat = { adapter = "gemini" },
      inline = { adapter = "gemini" },
      agent = { adapter = "gemini" },
    },
    prompt_library = {
      ["Document Code"] = {
        strategy = "inline",
        description = "Add documentation/comments to the selected code",
        opts = {
          index = 5,
          is_default = true,
          is_slash_cmd = false,
          user_prompt = false, -- Skips asking for extra input; just runs the command
        },
        prompts = {
          {
            role = "system",
            content = "You are an expert programmer. Add clear, concise comments to the code provided. Use standard docstring formats (like JSDoc, Docstring, or Doxygen) where appropriate.",
          },
          {
            role = "user",
            content = function(context)
              local code = table.concat(context.lines, "\n")
              return "Please add comments to the following code:\n\n```" ..
                  context.filetype .. "\n" .. code .. "\n```"
            end,
          },
        },
      },
      ["Review Writing"] = {
        strategy = "inline",
        description = "Review and improve a selected section of writing in the context of the larger paper.",
        opts = {
          is_slash_cmd = false,
          user_prompt = false,
        },
        prompts = {
          {
            role = "system",
            content = "You are a peer reviewer for a professional engineering journal like IEEE or Optica. You will be asked to review writing intended for publication in such a journal. Review only for spelling, grammar, style, and substance. Do not change any latex formatting, or the intent of the writing. Strive to stay true to the author's voice while ensuring the tone is professional and well suited to the audience."
          },
          {
            role = "user",
            content = function(context)
              -- Extract the visual selection
              local section = table.concat(context.lines, "\n")
              
              -- Retrieve the entire buffer using the Neovim API
              local all_lines = vim.api.nvim_buf_get_lines(context.bufnr, 0, -1, false)
              local paper = table.concat(all_lines, "\n")
              
              -- Construct the prompt using string.format for standard multi-line layout
              return string.format(
                "Please review this specific section of my paper. The entire paper is provided for context, but please keep your remarks to the provided section and the surrounding area (IE if I should adjust a section to provide a better transition etc.).\n\n# Section:\n%s\n\n# Paper:\n%s",
                section,
                paper
              )
            end
          }
        }
      }
    }
  },
  keys = {
    -- Normal mode: Show standard LSP actions
    { "<leader>ca", vim.lsp.buf.code_action, mode = "n", desc = "LSP Code Actions" },
    -- Visual mode: Prioritize Gemini/CodeCompanion actions
    { "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = "x", desc = "CodeCompanion Actions" }
  }
}
