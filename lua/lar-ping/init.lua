-- lar-ping.nvim
-- colorscheme used by the famous engineer lar ping

local M = {}

---@class LarPingConfig
---@field bg? string
---@field bg_darker? string
---@field bg_float? string
---@field bg_visual? string
---@field bg_cursor? string
---@field fg? string Default foreground
---@field mg? string Mid-ground: dim text, line numbers, punctuation
---@field comment? string Comments
---@field keyword? string Keywords and flow control
---@field operator? string Operators
---@field string? string String literals
---@field literal? string Numeric, char, and bool literals
---@field type? string Type names
---@field macro? string Macros, attributes, preprocessor
---@field error? string Diagnostic error
---@field warning? string Diagnostic warning
---@field hint? string Diagnostic hint
---@field info? string Diagnostic info
---@field blue? string Links, directories
---@field green? string Positive UI states
---@field orange? string Search highlight
---@field magenta? string Debug
---@field git_add? string
---@field git_change? string
---@field git_delete? string
---@field none? string

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
