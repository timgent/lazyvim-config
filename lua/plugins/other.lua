return {
  "rgroli/other.nvim",
  keys = {
    { "<leader>co", "<cmd>Other<cr>", desc = "Open alternate file" },
    { "<leader>cO", "<cmd>OtherSplit<cr>", desc = "Open alternate in split" },
    { "<leader>cV", "<cmd>OtherVSplit<cr>", desc = "Open alternate in vsplit" },
  },
  config = function()
    require("other-nvim").setup({
      mappings = {
      -- Elixir patterns
      {
        pattern = "/lib/(.*)%.ex$",
        target = "/test/%1_test.exs",
        context = "test",
      },
      {
        pattern = "/test/(.*)_test%.exs$",
        target = "/lib/%1.ex",
        context = "source",
      },
      -- Scala patterns
      {
        pattern = "/src/main/scala/(.*)/(.*)%.scala$",
        target = "/src/test/scala/%1/%2Spec.scala",
        context = "test",
      },
      {
        pattern = "/src/test/scala/(.*)/(.*)Spec%.scala$",
        target = "/src/main/scala/%1/%2.scala",
        context = "source",
      },
      -- JavaScript/TypeScript patterns
      {
        pattern = "/(.*)%.([jt]sx?)$",
        target = "/%1.test.%2",
        context = "test",
      },
      {
        pattern = "/(.*)%.test%.([jt]sx?)$",
        target = "/%1.%2",
        context = "source",
      },
      {
        pattern = "/(.*)%.spec%.([jt]sx?)$",
        target = "/%1.%2",
        context = "source",
      },
      -- Python patterns
      {
        pattern = "/(.*)%.py$",
        target = "/%1_test.py",
        context = "test",
      },
      {
        pattern = "/(.*)_test%.py$",
        target = "/%1.py",
        context = "source",
      },
      {
        pattern = "/tests/test_(.*)%.py$",
        target = "/%1.py",
        context = "source",
      },
      -- Go patterns
      {
        pattern = "/(.*)%.go$",
        target = "/%1_test.go",
        context = "test",
      },
      {
        pattern = "/(.*)_test%.go$",
        target = "/%1.go",
        context = "source",
      },
      -- Rust patterns
      {
        pattern = "/src/(.*)%.rs$",
        target = "/tests/%1_test.rs",
        context = "test",
      },
      {
        pattern = "/tests/(.*)_test%.rs$",
        target = "/src/%1.rs",
        context = "source",
      },
    },
    })
  end,
}
