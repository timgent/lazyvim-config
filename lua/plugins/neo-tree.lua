return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      find_by_full_path_words = true,
      find_command = "fd", -- or "find" if you don't have fd installed
    },
  },
}
