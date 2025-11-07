-- Claude Code integration for Neovim
-- https://github.com/coder/claudecode.nvim
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  -- Lazy-load on keybindings for optimal startup
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude: Toggle terminal" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude: Send selection" },
    { "<leader>aa", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: Add current file" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: Accept diff" },
    { "<leader>ar", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: Reject diff" },
  },
  -- Use default configuration (zero config needed)
  config = true,
}
