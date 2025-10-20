-- Custom telescope buffer picker configuration
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- Override or add buffer picker with bigger view
    {
      "<leader>bb",
      function()
        require("telescope.builtin").buffers({
          sort_mru = true,
          sort_lastused = true,
          layout_strategy = "vertical",
          layout_config = {
            height = 0.95,
            width = 0.95,
            preview_height = 0.6,
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
        })
      end,
      desc = "Buffers (Big View)",
    },
  },
}

