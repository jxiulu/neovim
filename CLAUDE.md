# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a Neovim configuration using **lazy.nvim** as the plugin manager.

### Entry point
`init.lua` — 27-line bootstrap only: enables the loader, requires `config.options`, bootstraps lazy.nvim, loads plugins via `require("lazy").setup("plugins", ...)`, then requires `config.autocmds` and `config.keymaps`.

### Module layout
```
lua/
├── config/
│   ├── options.lua    — vim.opt settings and terminal background autocmds
│   ├── autocmds.lua   — diagnostics config, language-specific FileType autocmds, theme persistence
│   └── keymaps.lua    — global keymaps, :Config user command, which-key group labels
└── plugins/           — lazy.nvim auto-discovers every file here
    ├── lsp.lua        — lsp_on_attach, mason + mason-lspconfig, all LSP server configs
    ├── completion.lua — nvim-cmp + LuaSnip
    ├── formatting.lua — conform.nvim (zigfmt, rustfmt, clang-format, etc.)
    ├── debugging.lua  — nvim-dap + dap-ui + codelldb adapter
    ├── snacks.lua     — snacks.nvim (picker, dashboard, notifier, zen, toggles)
    ├── treesitter.lua — nvim-treesitter parsers and config
    ├── themes.lua     — all colorscheme plugins + local BetterTheme
    └── ui.lua         — oil, lualine, grapple, trouble, gitsigns, comment, which-key, autopairs
```

### Key conventions
- **Adding a plugin**: create a new file in `lua/plugins/` returning a lazy spec table. No registration needed.
- **Adding a language**: touch all four places — `lsp.lua` (LSP server + Mason ensure_installed), `treesitter.lua` (parser), `formatting.lua` (formatter), `autocmds.lua` (FileType autocmd with indent/colorcolumn/build keymaps).
- **lsp_on_attach** is defined at the top of `lua/plugins/lsp.lua` (not in config/). All LSP servers share it via `base_opts`.
- `border = "rounded"` is inlined wherever needed (lazy UI, oil float, diagnostic float) — there is no shared constant.
- Theme is persisted across sessions via `last_theme.txt` in the config root (read/written by autocmds in `config/autocmds.lua`).
- The local plugin **BetterTheme** lives at `~/Documents/Projects/BetterTheme` and is loaded with `dir =`.

### Installed language support
| Language | LSP | Formatter | Treesitter | FileType autocmd |
|----------|-----|-----------|------------|-----------------|
| C/C++ | clangd | clang-format | ✓ | colorcolumn=81 |
| Rust | rust_analyzer | rustfmt | ✓ | colorcolumn=100, cargo keymaps |
| Zig | zls | zigfmt | ✓ | colorcolumn=100, zig build keymaps |
| Java | jdtls | google-java-format | ✓ | colorcolumn=120, javac/java keymaps |
| Lua | lua_ls | stylua | ✓ | — |
| Markdown | marksman | prettier | ✓ | wrap, spell, conceallevel=2 |
