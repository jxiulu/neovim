local M = {}

M.defaults = {
  -- Backgrounds
  bg          = "#242424",
  bg_darker   = "#242424",
  bg_float    = "#343434",
  bg_visual   = "#575757",
  bg_cursor   = "#707070",

  -- Foreground
  fg          = "#f5f5f5",
  mg          = "#b0b0b0",

  -- Syntax
  comment     = "#cc8c3c",
  keyword     = "#b0b0b0",
  operator    = "#ffdd33",
  string      = "#7eed3b",
  literal     = "#d19a66",
  type        = "#52deeb",
  macro       = "#c36dde",

  -- Diagnostics
  error       = "#f43841",
  warning     = "#ffdd33",
  hint        = "#46a6b2",
  info        = "#519fdf",

  -- UI Accents
  blue        = "#519fdf",
  green       = "#73d936",
  orange      = "#c18a56",
  magenta     = "#d16d9e",

  -- Git
  git_add     = "#73d936",
  git_change  = "#ffdd33",
  git_delete  = "#f43841",

  none        = "NONE",
}

return M
