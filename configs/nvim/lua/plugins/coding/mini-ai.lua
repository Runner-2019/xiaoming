-- https://github.com/echasnovski/mini.ai
-- Better text-objects
-- The `a` means arround.
-- The `i` means inside.

return {
  "echasnovski/mini.ai",
  event = "VeryLazy",
  -- opts = {
  --   n_lines = 500, -- Number of lines within which textobject is searched
  --   custom_textobjects = nil,
  -- },
  opts = function()
    local ai = require("mini.ai")
    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)

    -- Register all keymaps when both mini.ai and which-key loaded.
    require("util").on_load("which-key.nvim", function()
      local a = {
        [" "] = "Whitespace",
        ['"'] = '"',
        ["'"] = "'",
        ["`"] = "`",
        ["("] = "(",
        [")"] = ")",
        [">"] = ">",
        ["<lt>"] = "<",
        ["]"] = "]",
        ["["] = "[",
        ["{"] = "{",
        ["}"] = "}",
        ["?"] = "User prompt",
        _ = "Underscore",
      }
      local i = vim.deepcopy(a)
      require("which-key").register({
        mode = { "o", "x" },
        i = i,
        a = a,
      })
    end)
  end,
}
