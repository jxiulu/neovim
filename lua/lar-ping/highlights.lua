local M = {}

M.set = function(c)
	local hl = vim.api.nvim_set_hl

	-- =========================================================================
	-- Editor UI
	-- =========================================================================
	hl(0, "Normal",      { fg = c.fg,      bg = c.bg })
	hl(0, "NormalFloat", { fg = c.fg,      bg = c.bg_float })
	hl(0, "FloatBorder", { fg = c.mg,      bg = c.bg_float })
	hl(0, "FloatTitle",  { fg = c.keyword, bg = c.bg_float })
	hl(0, "NormalSB",    { fg = c.fg,      bg = c.bg_darker })

	hl(0, "Cursor",       { fg = c.bg, bg = c.fg })
	hl(0, "CursorLine",   { bg = c.bg_cursor })
	hl(0, "CursorLineNr", { fg = c.keyword })
	hl(0, "CursorColumn", { bg = c.bg_cursor })

	hl(0, "LineNr",      { fg = c.mg })
	hl(0, "SignColumn",  { bg = c.bg })
	hl(0, "ColorColumn", { bg = c.bg })
	hl(0, "FoldColumn",  { fg = c.mg, bg = c.bg })
	hl(0, "Folded",      { fg = c.mg, bg = c.bg_darker })

	hl(0, "StatusLine",   { fg = c.fg, bg = c.bg_cursor })
	hl(0, "StatusLineNC", { fg = c.mg, bg = c.bg_darker })
	hl(0, "WinBar",       { fg = c.fg, bg = c.bg })
	hl(0, "WinBarNC",     { fg = c.mg, bg = c.bg })
	hl(0, "WinSeparator", { fg = c.bg_cursor })

	hl(0, "TabLine",     { fg = c.mg, bg = c.bg_darker })
	hl(0, "TabLineFill", { bg = c.bg_darker })
	hl(0, "TabLineSel",  { fg = c.fg, bg = c.bg })

	hl(0, "Visual",    { bg = c.bg_visual })
	hl(0, "VisualNOS", { bg = c.bg_visual })

	hl(0, "Search",     { fg = c.bg, bg = c.keyword })
	hl(0, "IncSearch",  { fg = c.bg, bg = c.orange })
	hl(0, "CurSearch",  { fg = c.bg, bg = c.orange })
	hl(0, "Substitute", { fg = c.bg, bg = c.error })

	hl(0, "MatchParen", { fg = c.fg, underline = true })

	hl(0, "Pmenu",        { fg = c.fg,   bg = c.bg_float })
	hl(0, "PmenuSel",     { fg = c.fg,   bg = c.bg_visual })
	hl(0, "PmenuSbar",    { bg = c.bg_darker })
	hl(0, "PmenuThumb",   { bg = c.mg })
	hl(0, "PmenuKind",    { fg = c.type, bg = c.bg_float })
	hl(0, "PmenuKindSel", { fg = c.type, bg = c.bg_visual })
	hl(0, "PmenuExtra",   { fg = c.mg,   bg = c.bg_float })

	hl(0, "NonText",     { fg = c.mg })
	hl(0, "SpecialKey",  { fg = c.bg_cursor })
	hl(0, "Whitespace",  { fg = c.bg_cursor })
	hl(0, "EndOfBuffer", { fg = c.literal })
	hl(0, "Conceal",     { fg = c.mg })

	hl(0, "Directory",  { fg = c.blue })
	hl(0, "Title",      { fg = c.keyword })
	hl(0, "Question",   { fg = c.green })
	hl(0, "MoreMsg",    { fg = c.green })
	hl(0, "ModeMsg",    { fg = c.fg })
	hl(0, "MsgArea",    { fg = c.fg })
	hl(0, "ErrorMsg",   { fg = c.error })
	hl(0, "WarningMsg", { fg = c.warning })

	hl(0, "SpellBad",   { undercurl = true, sp = c.error })
	hl(0, "SpellCap",   { undercurl = true, sp = c.warning })
	hl(0, "SpellRare",  { undercurl = true, sp = c.hint })
	hl(0, "SpellLocal", { undercurl = true, sp = c.info })

	hl(0, "QuickFixLine", { bg = c.bg_visual })
	hl(0, "qfLineNr",     { fg = c.fg })
	hl(0, "qfFileName",   { fg = c.blue })

	-- Syntax (legacy highlight groups)
	hl(0, "Comment",        { fg = c.comment, italic = true })
	hl(0, "SpecialComment", { fg = c.comment, italic = true })

	hl(0, "Constant",  { fg = c.literal })
	hl(0, "String",    { fg = c.string })
	hl(0, "Character", { fg = c.literal })
	hl(0, "Number",    { fg = c.literal })
	hl(0, "Float",     { fg = c.literal })
	hl(0, "Boolean",   { fg = c.literal })

	hl(0, "Identifier", { fg = c.fg })
	hl(0, "Function",   { link = "@function" })

	hl(0, "Statement",   { fg = c.keyword })
	hl(0, "Keyword",     { fg = c.keyword })
	hl(0, "Conditional", { fg = c.keyword })
	hl(0, "Repeat",      { fg = c.keyword })
	hl(0, "Label",       { fg = c.keyword })
	hl(0, "Operator",    { fg = c.operator })
	hl(0, "Exception",   { fg = c.error })

	hl(0, "PreProc",   { fg = c.mg })
	hl(0, "Include",   { fg = c.mg })
	hl(0, "Define",    { fg = c.mg })
	hl(0, "Macro",     { fg = c.macro })
	hl(0, "PreCondit", { fg = c.macro })

	hl(0, "Type",         { fg = c.type })
	hl(0, "StorageClass", { fg = c.type })
	hl(0, "Structure",    { fg = c.type })
	hl(0, "Typedef",      { fg = c.type })

	hl(0, "Special",     { fg = c.fg })
	hl(0, "SpecialChar", { fg = c.literal })
	hl(0, "Tag",         { fg = c.blue })
	hl(0, "Delimiter",   { fg = c.fg })
	hl(0, "Debug",       { fg = c.magenta })

	hl(0, "Underlined", { underline = true })
	hl(0, "Bold",       { bold = true })
	hl(0, "Italic",     { italic = true })
	hl(0, "Ignore",     { fg = c.mg })
	hl(0, "Error",      { fg = c.error })
	hl(0, "Todo",       { fg = c.keyword })

	-- =========================================================================
	-- Treesitter
	-- =========================================================================

	-- Identifiers
	hl(0, "@variable",          { fg = c.fg })
	hl(0, "@variable.builtin",  { fg = c.mg })
	hl(0, "@variable.parameter",{ fg = c.fg })
	hl(0, "@variable.member",   { fg = c.fg })

	-- Constants
	hl(0, "@constant",         { fg = c.literal })
	hl(0, "@constant.builtin", { fg = c.literal })
	hl(0, "@constant.macro",   { fg = c.literal })

	hl(0, "@module", { fg = c.mg })
	hl(0, "@label",  { fg = c.keyword })

	-- Literals
	hl(0, "@string",                { fg = c.string })
	hl(0, "@string.documentation",  { fg = c.comment, italic = true })
	hl(0, "@string.special.symbol", { fg = c.fg, italic = true })
	hl(0, "@string.special.url",    { fg = c.blue, underline = true })
	hl(0, "@string.special.path",   { fg = c.blue })

	hl(0, "@character",         { fg = c.literal })
	hl(0, "@character.special", { fg = c.mg })
	hl(0, "@number",            { fg = c.literal })
	hl(0, "@boolean",           { fg = c.literal })

	-- Types
	hl(0, "@type",            { fg = c.type })
	hl(0, "@type.builtin",    { fg = c.type })
	hl(0, "@type.definition", { fg = c.type })
	hl(0, "@type.qualifier",  { fg = c.mg })

	hl(0, "@attribute", { fg = c.macro })
	hl(0, "@property",  { fg = c.fg })

	-- Functions
	hl(0, "@function",         { fg = c.fg,    italic = true })
	hl(0, "@function.builtin", { fg = c.fg,    italic = true })
	hl(0, "@function.macro",   { fg = c.macro, italic = true })
	hl(0, "@constructor",      { fg = c.type })
	hl(0, "@operator",         { fg = c.operator })

	-- Keywords
	hl(0, "@keyword",       { fg = c.mg })
	hl(0, "@keyword.debug", { fg = c.magenta })

	-- Punctuation
	hl(0, "@punctuation", { fg = c.mg })

	-- Comments
	hl(0, "@comment",               { fg = c.comment, italic = true })
	hl(0, "@comment.documentation", { fg = c.comment, italic = true })
	hl(0, "@comment.error",         { fg = c.error })
	hl(0, "@comment.warning",       { fg = c.warning })
	hl(0, "@comment.todo",          { fg = c.keyword })
	hl(0, "@comment.note",          { fg = c.hint })

	-- Markup
	hl(0, "@markup.strong",         { bold = true })
	hl(0, "@markup.italic",         { italic = true })
	hl(0, "@markup.strikethrough",  { strikethrough = true })
	hl(0, "@markup.underline",      { underline = true })
	hl(0, "@markup.heading",        { fg = c.keyword })
	hl(0, "@markup.heading.1",      { fg = c.keyword })
	hl(0, "@markup.heading.2",      { fg = c.orange })
	hl(0, "@markup.heading.3",      { fg = c.keyword })
	hl(0, "@markup.heading.4",      { fg = c.type })
	hl(0, "@markup.heading.5",      { fg = c.fg })
	hl(0, "@markup.heading.6",      { fg = c.mg })
	hl(0, "@markup.quote",          { fg = c.comment, italic = true })
	hl(0, "@markup.math",           { fg = c.fg, italic = true })
	hl(0, "@markup.link",           { fg = c.blue, underline = true })
	hl(0, "@markup.link.label",     { fg = c.fg })
	hl(0, "@markup.link.url",       { fg = c.blue, underline = true })
	hl(0, "@markup.raw",            { fg = c.string })
	hl(0, "@markup.raw.block",      { fg = c.fg })
	hl(0, "@markup.list",           { fg = c.keyword })
	hl(0, "@markup.list.checked",   { fg = c.green })
	hl(0, "@markup.list.unchecked", { fg = c.mg })

	hl(0, "@diff.plus",  { fg = c.git_add })
	hl(0, "@diff.minus", { fg = c.git_delete })
	hl(0, "@diff.delta", { fg = c.git_change })

	hl(0, "@tag",           { fg = c.macro })
	hl(0, "@tag.attribute", { fg = c.macro })
	hl(0, "@tag.delimiter", { fg = c.macro })

	-- =========================================================================
	-- LSP Semantic Tokens
	-- =========================================================================
	-- Applied on top of treesitter. Empty groups prevent LSP auto-linking,
	-- letting treesitter highlights show through.

	hl(0, "@lsp", {})

	-- Explicit: match treesitter colors for these token types
	hl(0, "@lsp.type.type",     { fg = c.type })
	hl(0, "@lsp.type.variable", { fg = c.fg })
	hl(0, "@lsp.type.namespace",{ fg = c.mg })
	hl(0, "@lsp.type.function", { link = "@function" })
	hl(0, "@lsp.type.method",   { link = "@function" })
	hl(0, "@lsp.type.macro",    { link = "@function.macro" })
	hl(0, "@lsp.type.enumMember",{ fg = c.fg })

	-- rust-analyzer semantic tokens
	hl(0, "@lsp.type.lifetime",           { fg = c.macro })
	hl(0, "@lsp.type.formatSpecifier",    { fg = c.literal })
	hl(0, "@lsp.type.unresolvedReference",{ fg = c.fg, undercurl = true, sp = c.error })

	-- Defer to treesitter for these token types
    hl(0, "@lsp.type", { link = "@type"} )
	hl(0, "@lsp.type.interface",      { fg = c.type, italic = true })
	hl(0, "@lsp.type.parameter",      {})
	hl(0, "@lsp.type.property",       {})
	hl(0, "@lsp.type.keyword",        {})
	hl(0, "@lsp.type.comment",        {})
	hl(0, "@lsp.type.string",         { link = "@string" })
	hl(0, "@lsp.type.number",         {})
	hl(0, "@lsp.type.regexp",         {})
	hl(0, "@lsp.type.operator",       {})
	hl(0, "@lsp.type.boolean",        {})
	hl(0, "@lsp.type.enum",           {})
	hl(0, "@lsp.type.decorator",      {})
	hl(0, "@lsp.type.annotation",     {})
	hl(0, "@lsp.type.builtinType",    {})
	hl(0, "@lsp.type.selfTypeKeyword",{})
	hl(0, "@lsp.type.selfKeyword",    {})
	hl(0, "@lsp.type.generic",        {})

	hl(0, "@lsp.mod.deprecated", { strikethrough = true })
    hl(0, "@lsp.mod.attribute", { link = "@attribute" })
    hl(0, "@lsp.typemod.string", { link = "@string" })
	hl(0, "@lsp.mod.readonly",   {})

	-- =========================================================================
	-- Diagnostics
	-- =========================================================================
	hl(0, "DiagnosticError", { fg = c.error })
	hl(0, "DiagnosticWarn",  { fg = c.warning })
	hl(0, "DiagnosticHint",  { fg = c.hint })
	hl(0, "DiagnosticInfo",  { fg = c.info })
	hl(0, "DiagnosticOk",    { fg = c.green })

	hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.error })
	hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = c.warning })
	hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = c.hint })
	hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = c.info })

	hl(0, "DiagnosticVirtualTextError", { fg = c.error })
	hl(0, "DiagnosticVirtualTextWarn",  { fg = c.warning })
	hl(0, "DiagnosticVirtualTextHint",  { fg = c.hint })
	hl(0, "DiagnosticVirtualTextInfo",  { fg = c.info })

	hl(0, "DiagnosticSignError", { fg = c.error })
	hl(0, "DiagnosticSignWarn",  { fg = c.warning })
	hl(0, "DiagnosticSignHint",  { fg = c.hint })
	hl(0, "DiagnosticSignInfo",  { fg = c.info })

	hl(0, "DiagnosticUnnecessary", {})

	-- =========================================================================
	-- Git / Diff
	-- =========================================================================
	hl(0, "DiffAdd",    { fg = c.git_add })
	hl(0, "DiffChange", { fg = c.git_change })
	hl(0, "DiffDelete", { fg = c.git_delete })
	hl(0, "DiffText",   { fg = c.fg })

	hl(0, "GitSignsAdd",    { fg = c.git_add })
	hl(0, "GitSignsChange", { fg = c.git_change })
	hl(0, "GitSignsDelete", { fg = c.git_delete })

	-- =========================================================================
	-- Plugin: Telescope
	-- =========================================================================
	hl(0, "TelescopeNormal",         { fg = c.fg,      bg = c.bg_float })
	hl(0, "TelescopeBorder",         { fg = c.mg,      bg = c.bg_float })
	hl(0, "TelescopeTitle",          { fg = c.keyword, bg = c.bg_float })
	hl(0, "TelescopeSelection",      { fg = c.fg,      bg = c.bg_visual })
	hl(0, "TelescopeSelectionCaret", { fg = c.keyword })
	hl(0, "TelescopeMatching",       { fg = c.keyword })
	hl(0, "TelescopePromptNormal",   { fg = c.fg,      bg = c.bg_darker })
	hl(0, "TelescopePromptBorder",   { fg = c.mg,      bg = c.bg_darker })
	hl(0, "TelescopePromptPrefix",   { fg = c.keyword })

	-- =========================================================================
	-- Plugin: nvim-cmp
	-- =========================================================================
	hl(0, "CmpItemAbbr",           { fg = c.fg })
	hl(0, "CmpItemAbbrDeprecated", { fg = c.mg, strikethrough = true })
	hl(0, "CmpItemAbbrMatch",      { fg = c.keyword })
	hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.orange })
	hl(0, "CmpItemKind",           { fg = c.type })
	hl(0, "CmpItemMenu",           { fg = c.mg })

	-- =========================================================================
	-- Plugin: neo-tree
	-- =========================================================================
	hl(0, "NeoTreeNormal",        { fg = c.fg, bg = c.bg_darker })
	hl(0, "NeoTreeNormalNC",      { fg = c.fg, bg = c.bg_darker })
	hl(0, "NeoTreeDirectoryIcon", { fg = c.blue })
	hl(0, "NeoTreeDirectoryName", { fg = c.blue })
	hl(0, "NeoTreeFileName",      { fg = c.fg })
	hl(0, "NeoTreeGitAdded",      { fg = c.git_add })
	hl(0, "NeoTreeGitModified",   { fg = c.git_change })
	hl(0, "NeoTreeGitDeleted",    { fg = c.git_delete })

	-- =========================================================================
	-- Plugin: which-key
	-- =========================================================================
	hl(0, "WhichKey",          { fg = c.keyword })
	hl(0, "WhichKeyGroup",     { fg = c.type })
	hl(0, "WhichKeyDesc",      { fg = c.fg })
	hl(0, "WhichKeySeparator", { fg = c.mg })
	hl(0, "WhichKeyBorder",    { fg = c.mg, bg = c.bg_float })
	hl(0, "WhichKeyNormal",    { fg = c.fg, bg = c.bg_float })

	-- =========================================================================
	-- Plugin: indent-blankline
	-- =========================================================================
	hl(0, "IblIndent", { fg = c.bg_cursor })
	hl(0, "IblScope",  { fg = c.mg })

	-- =========================================================================
	-- Plugin: nvim-notify
	-- =========================================================================
	hl(0, "NotifyERRORBorder", { fg = c.error })
	hl(0, "NotifyWARNBorder",  { fg = c.warning })
	hl(0, "NotifyINFOBorder",  { fg = c.info })
	hl(0, "NotifyHINTBorder",  { fg = c.hint })
	hl(0, "NotifyDEBUGBorder", { fg = c.mg })
	hl(0, "NotifyERRORTitle",  { fg = c.error })
	hl(0, "NotifyWARNTitle",   { fg = c.warning })
	hl(0, "NotifyINFOTitle",   { fg = c.info })
	hl(0, "NotifyHINTTitle",   { fg = c.hint })
end

return M
