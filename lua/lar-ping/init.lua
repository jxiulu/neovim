-- lar-ping.nvim
-- colorscheme used by the famous engineer lar ping

local M = {}

---@class LarPingConfig
---@field bg? string Background color
---@field bg_darker? string Darker background (sidebars, floats)
---@field bg_float? string Float window background
---@field bg_visual? string Visual selection background
---@field bg_cursor? string Cursor line / cursorcolumn background
---@field fg? string Default foreground
---@field fg_dim? string Dimmed foreground (line numbers, borders)
---@field comment? string Comments (italic)
---@field keyword? string Keywords, statements, conditionals
---@field literal? string String literals
---@field comptime? string Macros, numeric/bool/char literals, and compile-time constants (constexpr, Rust const, Zig comptime)
---@field type_name? string Type names (class, struct, typedef, enum …)
---@field blue? string Blue accent
---@field cyan? string Cyan accent
---@field green? string Green accent
---@field red? string Red accent
---@field yellow? string Yellow accent
---@field orange? string Orange accent
---@field purple? string Purple / preprocessor / macro accent
---@field magenta? string Magenta accent
---@field error? string Diagnostic error color
---@field warn? string Diagnostic warning color
---@field hint? string Diagnostic hint color
---@field info? string Diagnostic info color
---@field git_add? string Git added lines
---@field git_change? string Git changed lines
---@field git_delete? string Git deleted lines
---@field none? string Transparent / "NONE"

--- Default configuration (all palette defaults).
--- Every field maps directly to a named color in the palette.
M.config = {}

--- Merge user opts with defaults and return the resolved color table.
---@param opts LarPingConfig
---@return table
local function resolve(opts)
  local palette = require("lar-ping.palette")
  return vim.tbl_deep_extend("force", palette.defaults, opts or {})
end

--- Apply the colorscheme.
---@param opts LarPingConfig?
M.load = function(opts)
  local c = resolve(opts or M.config)

  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.background     = "dark"
  vim.o.termguicolors  = true
  vim.g.colors_name    = "lar-ping"

  require("lar-ping.highlights").set(c)
end

--- Configure the theme (called by lazy.nvim opts / config).
--- Accepts the same fields as LarPingConfig  — only the keys you provide
--- will override the defaults, the rest stay at their built-in values.
---@param opts LarPingConfig?
M.setup = function(opts)
  M.config = opts or {}
  -- When setup() is called directly (not via lazy colorscheme loading),
  -- apply immediately.
  M.load(M.config)
end

return M
