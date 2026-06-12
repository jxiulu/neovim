local M = {}

M.defaults = {
  -- Backgrounds
  bg          = "#303232",
  bg_darker   = "#272929",
  bg_float    = "#272929",
  bg_visual   = "#404141",
  bg_cursor   = "#404141",

  -- Foreground
  fg          = "#D6DEDE",
  mg          = "#AEB8B8",

  -- Syntax
  comment     = "#cc8c3c",
  keyword     = "#AEB8B8",
  operator    = "#EEEA38",
  string      = "#77DB11",
  literal     = "#E5AC6C",
  type        = "#41C9D7",
  macro       = "#DB6ECB",

  -- Diagnostics
  error       = "#f43841",
  warning     = "#ffdd33",
  hint        = "#46a6b2",
  info        = "#519fdf",

  -- UI Accents
  blue        = "#519fdf",
  green       = "#77DB11",
  orange      = "#cc8c3c",
  magenta     = "#DB6ECB",

  -- Git
  git_add     = "#77DB11",
  git_change  = "#ffdd33",
  git_delete  = "#f43841",

  none        = "NONE",
}

return M
