# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on LazyVim, a Neovim starter template that uses lazy.nvim as the plugin manager. The configuration follows LazyVim's standard directory structure and extends it with custom plugins and settings.

## Architecture

### Bootstrap Process

1. `init.lua` - Entry point that requires `config.lazy`
2. `lua/config/lazy.lua` - Bootstraps lazy.nvim plugin manager and sets up the plugin specification:
   - Automatically clones lazy.nvim if not present
   - Imports LazyVim base plugins from `lazyvim.plugins`
   - Imports custom plugins from the `plugins/` directory
   - Configures plugin loading behavior (non-lazy by default for custom plugins)
   - Sets up automatic plugin update checking

### Configuration Structure

The `lua/config/` directory contains core configuration that loads automatically:

- `options.lua` - Vim options (loads before lazy.nvim startup)
- `keymaps.lua` - Custom keymaps (loads on VeryLazy event)
- `autocmds.lua` - Custom autocommands (loads on VeryLazy event)

Each file references LazyVim's default configurations that are always applied first.

### Plugin Management

Custom plugins are defined in `lua/plugins/*.lua`. Each file:

- Is automatically loaded by lazy.nvim
- Should return a Lua table with plugin specifications
- Can add new plugins, disable LazyVim plugins, or override their configurations

The `example.lua` file demonstrates various plugin configuration patterns but is disabled via early return.

## Plugin Configuration Patterns

When modifying or adding plugins:

1. **Adding new plugins**: Return a table with plugin spec `{ "author/plugin-name" }`
2. **Configuring LazyVim plugins**: Override by plugin name with new `opts`
3. **Disabling plugins**: Set `enabled = false`
4. **Merging options**: Use `opts` table (merged with parent spec)
5. **Overriding options**: Use `opts` function (replaces defaults)
6. **LSP servers**: Configure via `nvim-lspconfig` plugin's `opts.servers` table
7. **Importing extras**: Use `{ import = "lazyvim.plugins.extras.lang.X" }` for language support

## Code Formatting

This configuration uses StyLua for Lua code formatting:

```bash
stylua .
```

Configuration is in `stylua.toml`:
- 2-space indentation
- 120 character line width

## File Organization

- `init.lua` - Single-line entry point
- `lua/config/` - Core vim configuration
- `lua/plugins/` - Custom plugin specifications
- `lazy-lock.json` - Plugin version lockfile (managed by lazy.nvim)
- `lazyvim.json` - LazyVim configuration metadata

## Key Concepts

**Lazy Loading**: By default in this config, LazyVim plugins are lazy-loaded but custom plugins load at startup. This can be changed via `defaults.lazy` in the lazy.nvim setup.

**Plugin Specs**: Each plugin specification can include keys like `dependencies`, `opts`, `config`, `keys`, `event`, `cmd`, etc. to control loading and configuration.

**Override vs Merge**: Options (`opts`) defined as tables are merged with defaults; options defined as functions replace defaults entirely.
