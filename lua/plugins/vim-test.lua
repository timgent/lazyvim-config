return {
  "vim-test/vim-test",
  keys = {
    { "<leader>Tr", "<cmd>TestNearest<cr>", desc = "Run Nearest Test (vim-test)" },
    { "<leader>Tt", "<cmd>TestFile<cr>", desc = "Run Test File (vim-test)" },
    { "<leader>TT", "<cmd>TestSuite<cr>", desc = "Run All Tests (vim-test)" },
    { "<leader>Tl", "<cmd>TestLast<cr>", desc = "Run Last Test (vim-test)" },
    { "<leader>Tv", "<cmd>TestVisit<cr>", desc = "Visit Test File" },
  },
  config = function()
    -- Use neovim_sticky strategy: keeps terminal open and reuses it for subsequent runs
    vim.g["test#strategy"] = "neovim_sticky"

    -- Configure terminal behavior
    vim.g["test#neovim#term_position"] = "botright 15" -- Bottom split, 15 lines high

    -- Elixir/Mix test configuration
    vim.g["test#elixir#runner"] = "mixtest"

    -- Preserve IO.puts and all console output
    vim.g["test#elixir#mixtest#options"] = {
      all = "--trace", -- Verbose output showing IO.puts
    }

    -- Make it easy to work with test terminal
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*",
      callback = function()
        -- Set local keymap to close terminal with 'q' in normal mode
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
        -- Easy escape from terminal mode
        vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = true, silent = true })
      end,
    })
  end,
}
