-- Default color palette
-- All colors can be overridden via setup()

local M = {}

M.defaults = {
  -- Backgrounds
  bg          = "#181818",
  bg_darker   = "#101010",
  bg_float    = "#1e1e1e",
  bg_visual   = "#2a2a2a",
  bg_cursor   = "#282828",

  -- Foreground
  fg          = "#cdd6f4",
  fg_dim      = "#9099b0",

  -- Syntax
  comment     = "#cc8c3c",  -- warm brown (original)
  keyword     = "#ffdd33",  -- bright yellow (original)
  literal     = "#73d936",  -- green for string literals
  comptime    = "#d19a66",  -- amber for macros, numeric/bool/char literals, and compile-time constants
  type_name   = "#4ec9d4",  -- cyan-teal for type names

  -- UI accents (diagnostics, git, plugins)
  blue        = "#519fdf",
  cyan        = "#46a6b2",
  green       = "#73d936",
  red         = "#f43841",
  yellow      = "#ffdd33",
  orange      = "#c18a56",
  purple      = "#b668cd",
  magenta     = "#d16d9e",

  -- Diagnostics / Git
  error       = "#f43841",
  warn        = "#ffdd33",
  hint        = "#46a6b2",
  info        = "#519fdf",
  git_add     = "#73d936",
  git_change  = "#ffdd33",
  git_delete  = "#f43841",

  none        = "NONE",
}

return M
