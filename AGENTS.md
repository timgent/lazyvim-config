# AGENTS.md

This file provides comprehensive guidance for AI agents working with this Neovim configuration.

## Repository Purpose

This is a personal Neovim configuration based on [LazyVim](https://www.lazyvim.org/), a feature-rich Neovim starter template. The configuration extends LazyVim with custom plugins, keymaps, and settings tailored for development workflows, particularly focusing on Elixir, Scala, and other languages.

## Common Use Cases

When assisting with this configuration, users typically ask about:

1. **How to do something in this setup** - Requires checking both LazyVim defaults AND custom overrides
2. **How to change configuration** - May involve modifying existing plugins or adding new ones
3. **Troubleshooting** - Understanding what's been customized vs. default behavior

## Important Workflow Notes

**ALWAYS check both:**
1. **LazyVim defaults** - What LazyVim provides out of the box
2. **Local customizations** - What has been overridden or added (see sections below)

This is critical because customizations may have overridden default LazyVim behavior.

## Architecture Overview

### Bootstrap Process

1. `init.lua` - Entry point that requires `config.lazy`
2. `lua/config/lazy.lua` - Bootstraps lazy.nvim and loads all plugins
   - Auto-installs lazy.nvim if missing
   - Imports LazyVim base plugins from `lazyvim.plugins`
   - Imports custom plugins from `plugins/` directory
   - Custom plugins are NOT lazy-loaded by default (`defaults.lazy = false`)
   - Auto-checks for plugin updates (without notifications)

### Configuration Structure

- `lua/config/options.lua` - Vim options (loads before lazy.nvim)
- `lua/config/keymaps.lua` - Custom keymaps (loads on VeryLazy event)
- `lua/config/autocmds.lua` - Custom autocommands (loads on VeryLazy event)
- `lua/plugins/*.lua` - Plugin specifications (auto-loaded by lazy.nvim)

## Custom Configuration Details

### Options (lua/config/options.lua)

**Line Numbers:**
- Uses **absolute line numbers** instead of relative (overrides LazyVim default)
- `vim.opt.relativenumber = false`
- `vim.opt.number = true`

### Keymaps (lua/config/keymaps.lua)

**Insert Mode Escape:**
- `jk`, `kj`, and all case variations (`JK`, `Jk`, `jK`, `KJ`, `Kj`, `kJ`) → `<Esc>`
- Provides quick exit from insert mode without reaching for Escape key

**File Path Copying:**
- `<leader>yp` - Copy relative file path to clipboard
- `<leader>yP` - Copy absolute file path to clipboard

### Custom Plugins

#### 1. Telescope Buffer Picker (telescope-buffers.lua)

**Customization:**
- Overrides `<leader>bb` with a larger vertical buffer picker
- 95% width/height with 60% preview height
- MRU (most recently used) sorting enabled
- Prompt at top with ascending sort strategy

#### 2. Mini.pairs (mini-pairs.lua)

**Customization:**
- **DISABLED** - Auto-pairing is turned off
- `{ "nvim-mini/mini.pairs", enabled = false }`

#### 3. Other.nvim (other.lua)

**Purpose:** Quick switching between source and test files

**Keymaps:**
- `<leader>co` - Open alternate file (switch between source/test)
- `<leader>cO` - Open alternate in horizontal split
- `<leader>cV` - Open alternate in vertical split

**Supported Languages & Patterns:**
- **Elixir**: `/lib/*.ex` ↔ `/test/*_test.exs`
- **Scala**: `/src/main/scala/*/*.scala` ↔ `/src/test/scala/*/*Spec.scala`
- **JavaScript/TypeScript**: `*.{js,ts,jsx,tsx}` ↔ `*.test.{js,ts,jsx,tsx}` or `*.spec.{js,ts,jsx,tsx}`
- **Python**: `*.py` ↔ `*_test.py` or `/tests/test_*.py`
- **Go**: `*.go` ↔ `*_test.go`
- **Rust**: `/src/*.rs` ↔ `/tests/*_test.rs`

#### 4. Neotest (neotest.lua)

**Purpose:** Primary test runner with rich UI feedback

**Keymaps:**
- `<leader>ts` - Toggle test summary window
- `<leader>to` - Toggle test output panel
- `<leader>tO` - Show test output (auto-close enabled)

**Adapters:**
- `neotest-elixir` - Elixir test support

**Features:**
- Virtual text showing pass/fail status at end of test lines
- Gutter signs for test status
- Auto-opens output for failed tests
- Custom icons: ✓ (passed), ✗ (failed), ● (running), ○ (skipped)
- **Statusline integration** - Shows test status in lualine (e.g., "✓ 5", "✗ 2/7", "🧪 Running...")
- **Notifications** - Shows test results via nvim-notify when tests finish

#### 5. Vim-test (vim-test.lua)

**Purpose:** Alternative test runner with persistent terminal

**Keymaps:**
- `<leader>Tr` - Run nearest test
- `<leader>Tt` - Run current test file
- `<leader>TT` - Run entire test suite
- `<leader>Tl` - Run last test
- `<leader>Tv` - Visit test file

**Configuration:**
- Strategy: `neovim_sticky` - Reuses terminal window for subsequent test runs
- Terminal: Bottom split, 15 lines high
- Elixir: Uses `mixtest` runner with `--trace` flag for verbose output (preserves `IO.puts`)

**Terminal Keymaps (auto-configured):**
- `q` (normal mode) - Close terminal window
- `<Esc><Esc>` (terminal mode) - Exit to normal mode

#### 6. Claude Code (claude-code.lua)

**Purpose:** Integration with Claude Code AI assistant

**Keymaps:**
- `<leader>ac` - Toggle Claude Code terminal
- `<leader>as` (visual mode) - Send selection to Claude
- `<leader>aa` - Add current file to Claude context
- `<leader>ad` - Accept Claude's diff suggestion
- `<leader>ar` - Reject Claude's diff suggestion

**Dependencies:**
- `folke/snacks.nvim`

#### 7. Linting (linting.lua)

**Customization:**
- **Disables markdown linting** (removes markdown/md from linters)
- Overrides `nvim-lint` configuration

## Plugin Configuration Patterns

### Adding New Plugins
```lua
return {
  "author/plugin-name",
  -- optional configuration
}
```

### Configuring LazyVim Plugins
```lua
return {
  "plugin-name",
  opts = { ... } -- merged with defaults
}
```

### Disabling Plugins
```lua
return {
  "plugin-name",
  enabled = false
}
```

### Override vs. Merge
- `opts = { ... }` (table) → Merged with defaults
- `opts = function(_, opts) ... end` → Can modify or replace defaults

### LSP Configuration
Configure language servers via `nvim-lspconfig` plugin:
```lua
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = { ... },
      -- other servers
    }
  }
}
```

### Language Support
Import LazyVim extras:
```lua
return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.python" },
}
```

## Code Formatting

Uses **StyLua** for Lua code formatting:

```bash
stylua .
```

Configuration (`stylua.toml`):
- 2-space indentation
- 120 character line width

## File Organization

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin versions (managed by lazy.nvim)
├── lazyvim.json           # LazyVim metadata
├── stylua.toml            # StyLua config
├── lua/
│   ├── config/
│   │   ├── lazy.lua       # Plugin manager bootstrap
│   │   ├── options.lua    # Vim options
│   │   ├── keymaps.lua    # Custom keymaps
│   │   └── autocmds.lua   # Custom autocommands
│   └── plugins/           # Custom plugin specs
│       ├── example.lua    # Example patterns (disabled)
│       ├── telescope-buffers.lua
│       ├── mini-pairs.lua
│       ├── other.lua
│       ├── neotest.lua
│       ├── vim-test.lua
│       ├── claude-code.lua
│       └── linting.lua
```

## LazyVim References

- [LazyVim Documentation](https://www.lazyvim.org/)
- [Default Options](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua)
- [Default Keymaps](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua)
- [Default Autocmds](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua)
- [LazyVim Plugins](https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins)

## Troubleshooting Approach

When helping troubleshoot or answer questions:

1. **Check custom configurations first** - Review the relevant file in `lua/config/` or `lua/plugins/`
2. **Compare with LazyVim defaults** - Check if behavior was overridden
3. **Consider plugin interactions** - Some plugins may affect others (e.g., neotest vs vim-test)
4. **Check lazy-loading** - Custom plugins load at startup; LazyVim plugins are lazy-loaded

## Common Questions

**"How do I run tests?"**
- Two options: Neotest (`<leader>t*` keymaps) or vim-test (`<leader>T*` keymaps)
- Neotest provides richer UI; vim-test provides simpler terminal output

**"How do I switch between source and test?"**
- Use `<leader>co` (other.nvim) - supports Elixir, Scala, JS/TS, Python, Go, Rust

**"Why isn't auto-pairing working?"**
- mini.pairs is disabled in `lua/plugins/mini-pairs.lua`

**"How do I see what line number I'm on?"**
- Absolute line numbers are enabled (not relative) in `lua/config/options.lua`

**"How do I customize a LazyVim plugin?"**
- Create/edit a file in `lua/plugins/` with the plugin name and new `opts`
- Use `opts` table to merge, or `opts` function to override completely
