local M = {}

M.light = {
  -- Backgrounds
  bg          = "#c4c4c4",
  bg_darker   = "#b8b8b8",
  bg_float    = "#b8b8b8",
  bg_visual   = "#c8c8d8",
  bg_cursor   = "#c8c8d8",

  -- Foreground
  fg          = "#303030",
  mg          = "#585048",

  -- Syntax
  comment     = "#a07850",
  operator    = "#a85840",
  string      = "#228800",
  literal     = "#886020",
  type        = "#208090",
  macro       = "#aa4477",

  -- UI Accents
  blue        = "#1188aa",
  green       = "#22aa00",
  yellow      = "#cc9911",
  orange      = "#bb7700",
  red         = "#bb0000",
  magenta     = "#aa4477",

  none        = "NONE",
}

M.dark = {
  -- Backgrounds
  bg          = "#2e2e2e",
  bg_darker   = "#2a2a2a",
  bg_float    = "#2a2a2a",
  bg_visual   = "#304048",
  bg_cursor   = "#404040",

  -- Foreground
  fg          = "#cecece",
  mg          = "#b4aca0",

  -- Syntax
  comment     = "#a07850",
  operator    = "#a8ae20",
  string      = "#40b040",
  literal     = "#a87e38",
  type        = "#30a0b0",
  macro       = "#b05880",

  -- UI Accents
  blue        = "#1188aa",
  green       = "#40b040",
  yellow      = "#cc9911",
  orange      = "#bb7700",
  red         = "#bb0000",
  magenta     = "#aa4477",

  none        = "NONE",
}

return M
