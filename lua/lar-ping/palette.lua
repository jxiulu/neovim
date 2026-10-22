local M = {}

M.defaults = {
  -- Backgrounds
  bg          = "#d1d1d0",
  bg_darker   = "#c1c1c0",
  bg_float    = "#c1c1c0",
  bg_visual   = "#c0c0da",
  bg_cursor   = "#c1c1c0",

  -- Foreground
  fg          = "#333333",
  mg          = "#606a70",

  -- Syntax
  comment     = "#b07030",
  operator    = "#907040",
  string      = "#228800",
  literal     = "#885511",
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

M.blue = {
  -- Backgrounds
  bg          = "#335077",
  bg_darker   = "#2a3f68",
  bg_float    = "#2a3f68",
  bg_visual   = "#605f80",
  bg_cursor   = "#2a3f68",

  -- Foreground
  fg          = "#d7dddd",
  mg          = "#a9bdda",

  -- Syntax
  comment     = "#cc8c3c",
  operator    = "#dfd530",
  string      = "#77DB11",
  literal     = "#E5AC6C",
  type        = "#40cad0",
  macro       = "#DB6ECB",

  -- UI Accents
  blue        = "#519fdf",
  green       = "#77DB11",
  yellow      = "#ffdf22",
  orange      = "#f09c1c",
  red         = "#f43841",
  magenta     = "#DB6ECB",

  none        = "NONE",
}

M.dark = {
  -- Backgrounds
  bg          = "#202021",
  bg_darker   = "#2a2a2b",
  bg_float    = "#2a2a2b",
  bg_visual   = "#333339",
  bg_cursor   = "#333339",

  -- Foreground
  fg          = "#d0d3d5",
  mg          = "#a9bdda",

  -- Syntax
  comment     = "#cc8c3c",
  operator    = "#dfd530",
  string      = "#77DB11",
  literal     = "#E5AC6C",
  type        = "#40cad0",
  macro       = "#DB6ECB",

  -- UI Accents
  blue        = "#519fdf",
  green       = "#77DB11",
  yellow      = "#ffdf22",
  orange      = "#f09c1c",
  red         = "#f43841",
  magenta     = "#DB6ECB",

  none        = "NONE",
}

return M
