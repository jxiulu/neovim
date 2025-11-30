# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration written entirely in Lua, featuring a single-file architecture (`init.lua`). The configuration uses lazy.nvim for plugin management and is optimized for C/C++ development with LSP, debugging, and modern editing features.

## Architecture

### Single-File Design
All configuration lives in `init.lua` (~1,232 lines). The file is structured in this order:
1. Vim loader optimization and basic options (lines 1-41)
2. Lazy.nvim bootstrapping (lines 43-55)
3. LSP on_attach handler definition (lines 57-79)
4. Color palette definitions (lines 81-99)
5. Plugin specifications using lazy.nvim (lines 102-996)
6. Theme persistence logic (lines 1000-1031)
7. LSP diagnostics configuration (lines 1035-1056)
8. Keymaps and custom commands (lines 1058-1232)

### Key Architectural Patterns

**Custom Theme Integration**: Two local theme directories are referenced:
- `/Users/jerrylu/Documents/Projects/agi-theme` (init.lua:105)
- `/Users/jerrylu/Documents/Projects/mytheme` (init.lua:113)

These are loaded with `dir =` instead of typical plugin specs. The configuration includes a custom color palette (init.lua:81-99) using named colors like `cherry`, `jade`, `violet`, etc.

**LSP Configuration**: LSP setup uses a handler-based approach via mason-lspconfig (init.lua:492-549). The `lsp_on_attach` function (init.lua:57-79) is defined globally and used by all language servers. Inlay hints are disabled by default but toggleable.

**CWD Management**: Custom working directory helpers (init.lua:1085-1175) prioritize LSP root detection, falling back to project markers (`.git`, `compile_commands.json`, etc.). This is important for multi-project workflows.

**DAP Configuration**: Debugging is configured for C/C++ using codelldb (init.lua:716-786). The configuration includes auto-building before debugging with make/cmake detection.

## Common Commands

### Development Workflow
```lua
:Config           -- Jump to init.lua and cd to ~/.config/nvim
```

### LSP & Diagnostics
- `K` - Hover documentation
- `gd` - Go to definition (uses Snacks picker, not native LSP)
- `gr` - Find references (Snacks picker)
- `<leader>rn` or `<leader>cr` - Rename symbol
- `<leader>ca` - Code actions
- `gl` - Open diagnostics float
- `[d` / `]d` - Previous/next diagnostic

### File Navigation
- `<leader>ff` - Find files (Snacks picker)
- `<leader>fg` - Find git files
- `<leader>fr` - Recent files
- `<leader>sb` - Search lines in buffer
- `<leader>sg` - Live grep
- `<leader>o` - Open Oil file browser
- `<leader>or` - Open project root in Oil (float)

### Working Directory
- `<leader>ed` - Set CWD to current file's directory
- `<leader>er` - Set CWD to project root (LSP-aware)
- `<leader>es` - Show current CWD

### Debugging (C/C++)
- `<F5>` - Continue/start debugging
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Conditional breakpoint
- DAP will auto-run `make -j || cmake -S . -B build && cmake --build build -j`

### Git (via Snacks)
- `<leader>gs` - Git status picker
- `<leader>gl` - Git log
- `<leader>gb` - Git branches
- `<leader>gd` - Git diff (hunks)

### Custom "Dart" Plugin
This appears to be a buffer/mark management system (not Dart language):
- `<leader>da` - Add to dart list
- `<leader>dm` - Toggle dart menu
- `<leader>d1-4` - Select dart items 1-4

### Grapple (File Marking)
- `<leader>rm` - Toggle tag
- `<leader>rM` - Open tags window
- `<leader>rn` - Next tag
- `<leader>rp` - Previous tag

### UI Toggles
- `<leader>uz` - Zen mode
- `<leader>us` - Spelling
- `<leader>uw` - Wrap
- `<leader>uh` - Inlay hints
- `<leader>ud` - Diagnostics
- `<leader>ul` - Line numbers

## Important Configuration Details

### Formatters (conform.nvim)
Format-on-save is enabled for:
- **C/C++**: clang-format with custom args `--style={BasedOnStyle: llvm, IndentWidth: 4}` (init.lua:625-626)
- **Lua**: stylua
- **Python**: isort + black

Large files (>5000 lines) skip formatting (init.lua:631).

### Language Servers
Mason is configured to install: `clangd`, `lua_ls`, `cmake` (init.lua:534)

**clangd customizations** (init.lua:504-521):
- Header insertion disabled: `--header-insertion=never`
- Function arg placeholders disabled
- Offset encoding: utf-16
- Background indexing enabled

### Sessions
auto-session is enabled (init.lua:982-993) with:
- Automatic session restore on `cwd_change_handling`
- Suppressed for `~/Downloads`

### Theme Persistence
The colorscheme is saved to `last_theme.txt` on exit and restored on startup (init.lua:1000-1031). This ensures theme choice persists across sessions.

### Plugin Manager
Lazy.nvim is used. To install plugins: just restart Neovim or `:Lazy sync`

### Diagnostics Behavior
- Virtual text is disabled (init.lua:1042)
- Diagnostics float automatically on `CursorHold` (init.lua:1050-1056)
- Border style is set to `"none"` via `borderopt` variable (init.lua:30)

## Project Structure Assumptions

This config assumes C/C++ projects with:
- CMake or Makefile build system
- `compile_commands.json` for clangd
- Debug builds in `./build/` directory (init.lua:899)

## Notes for Future Modifications

1. **Adding Language Servers**: Modify the `servers` table in mason-lspconfig opts (init.lua:503-531) and add to `ensure_installed` (init.lua:534)

2. **Changing Keymaps**: Most keymaps are defined in plugin `keys` tables or in the global keymap section (init.lua:1058+). Use which-key groups for organization (init.lua:1069-1079)

3. **Theme Development**: Local themes are loaded from `~/Documents/Projects/`. The `mytheme` plugin uses a base16-style palette (init.lua:121-154)

4. **Modifying DAP**: C/C++ debug configuration is in init.lua:766-785. Adjust the build command in the `program` function if using different build systems

5. **Snacks.nvim**: This plugin provides the picker (Telescope alternative), notifier, zen mode, and other utilities. Many LSP navigation keymaps override default behavior to use Snacks pickers (init.lua:307-341)
