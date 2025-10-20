return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "jfpedroza/neotest-elixir",
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      table.insert(opts.adapters, require("neotest-elixir"))

      -- Make test results more visible with these options:
      opts.status = {
        enabled = true,
        virtual_text = true, -- Show pass/fail status as virtual text at end of line
        signs = true, -- Keep the gutter signs
      }

      opts.output = {
        enabled = true,
        open_on_run = "short", -- Automatically show output for failed tests
      }

      -- Configure better icons for the signs
      opts.icons = {
        passed = "✓",
        running = "●",
        failed = "✗",
        skipped = "○",
        unknown = "?",
        watching = "👁",
      }

      -- Highlights for better visibility
      opts.highlights = {
        passed = "NeotestPassed",
        running = "NeotestRunning",
        failed = "NeotestFailed",
        skipped = "NeotestSkipped",
      }

      -- Summary window configuration
      opts.summary = {
        enabled = true,
        animated = true,
        follow = true,
        expand_errors = true,
      }

      return opts
    end,
    keys = {
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Neotest Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Neotest Output Panel",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Neotest Output",
      },
    },
  },

  -- Optional: Show test status in your statusline
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local neotest = require("neotest")
      table.insert(opts.sections.lualine_x or {}, {
        function()
          local status = neotest.state.status_counts("file")
          if not status then
            return ""
          end
          
          local passed = status.passed or 0
          local failed = status.failed or 0
          local running = status.running or 0
          
          if running > 0 then
            return "🧪 Running..."
          elseif failed > 0 then
            return string.format("✗ %d/%d", failed, passed + failed)
          elseif passed > 0 then
            return string.format("✓ %d", passed)
          end
          return ""
        end,
        color = function()
          local status = neotest.state.status_counts("file")
          if not status then
            return nil
          end
          
          if (status.failed or 0) > 0 then
            return { fg = "#f38ba8" } -- red
          elseif (status.passed or 0) > 0 then
            return { fg = "#a6e3a1" } -- green
          end
          return nil
        end,
      })
    end,
  },

  -- Optional: Use nvim-notify for test notifications
  {
    "rcarriga/nvim-notify",
    optional = true,
    opts = {
      timeout = 3000,
      max_width = 60,
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      
      -- Hook into neotest to show notifications
      vim.api.nvim_create_autocmd("User", {
        pattern = "NeotestRunFinished",
        callback = function()
          local stats = require("neotest").state.status_counts("file")
          if not stats then
            return
          end

          local passed = stats.passed or 0
          local failed = stats.failed or 0
          local skipped = stats.skipped or 0

          if failed > 0 then
            notify(
              string.format("Tests: %d passed, %d failed, %d skipped", passed, failed, skipped),
              "error",
              { title = "Test Results" }
            )
          elseif passed > 0 then
            notify(
              string.format("All %d tests passed! 🎉", passed),
              "info",
              { title = "Test Results" }
            )
          end
        end,
      })
    end,
  },
}

