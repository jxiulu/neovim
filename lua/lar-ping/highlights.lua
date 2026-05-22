local M = {}

M.set = function(c)
	local hl = vim.api.nvim_set_hl

	-- =========================================================================
	-- Editor UI
	-- =========================================================================
	hl(0, "Normal", { fg = c.fg, bg = c.bg })
	hl(0, "NormalNC", { fg = c.fg, bg = c.bg })
	hl(0, "NormalFloat", { fg = c.fg, bg = c.bg_float })
	hl(0, "FloatBorder", { fg = c.fg_dim, bg = c.bg_float })
	hl(0, "FloatTitle", { fg = c.keyword, bg = c.bg_float })
	hl(0, "NormalSB", { fg = c.fg, bg = c.bg_darker })

	hl(0, "Cursor", { fg = c.bg, bg = c.fg })
	hl(0, "CursorLine", { bg = c.bg_cursor })
	hl(0, "CursorLineNr", { fg = c.keyword, bg = c.none })
	hl(0, "CursorColumn", { bg = c.bg_cursor })

	hl(0, "LineNr", { fg = c.fg_dim, bg = c.none })
	hl(0, "SignColumn", { fg = c.none, bg = c.bg })
	hl(0, "ColorColumn", { bg = c.bg })
	hl(0, "FoldColumn", { fg = c.fg_dim, bg = c.bg })
	hl(0, "Folded", { fg = c.fg_dim, bg = c.bg_darker })

	hl(0, "StatusLine", { fg = c.fg, bg = c.bg_cursor })
	hl(0, "StatusLineNC", { fg = c.fg_dim, bg = c.bg_darker })
	hl(0, "WinBar", { fg = c.fg, bg = c.bg })
	hl(0, "WinBarNC", { fg = c.fg_dim, bg = c.bg })
	hl(0, "WinSeparator", { fg = c.bg_cursor })

	hl(0, "TabLine", { fg = c.fg_dim, bg = c.bg_darker })
	hl(0, "TabLineFill", { bg = c.bg_darker })
	hl(0, "TabLineSel", { fg = c.fg, bg = c.bg })

	hl(0, "Visual", { bg = c.bg_visual })
	hl(0, "VisualNOS", { bg = c.bg_visual })

	hl(0, "Search", { fg = c.bg, bg = c.keyword })
	hl(0, "IncSearch", { fg = c.bg, bg = c.orange })
	hl(0, "CurSearch", { fg = c.bg, bg = c.orange })
	hl(0, "Substitute", { fg = c.bg, bg = c.red })

	hl(0, "MatchParen", { fg = c.fg, underline = true })

	hl(0, "Pmenu", { fg = c.fg, bg = c.bg_float })
	hl(0, "PmenuSel", { fg = c.fg, bg = c.bg_visual })
	hl(0, "PmenuSbar", { bg = c.bg_darker })
	hl(0, "PmenuThumb", { bg = c.fg_dim })
	hl(0, "PmenuKind", { fg = c.type_name, bg = c.bg_float })
	hl(0, "PmenuKindSel", { fg = c.type_name, bg = c.bg_visual })
	hl(0, "PmenuExtra", { fg = c.fg_dim, bg = c.bg_float })

	hl(0, "NonText", { fg = c.fg_dim })
	hl(0, "SpecialKey", { fg = c.bg_cursor })
	hl(0, "Whitespace", { fg = c.bg_cursor })
	hl(0, "EndOfBuffer", { fg = c.comptime })
	hl(0, "Conceal", { fg = c.fg_dim })

	hl(0, "Directory", { fg = c.blue })
	hl(0, "Title", { fg = c.keyword })
	hl(0, "Question", { fg = c.green })
	hl(0, "MoreMsg", { fg = c.green })
	hl(0, "ModeMsg", { fg = c.fg })
	hl(0, "MsgArea", { fg = c.fg })
	hl(0, "ErrorMsg", { fg = c.error })
	hl(0, "WarningMsg", { fg = c.warn })

	hl(0, "SpellBad", { undercurl = true, sp = c.error })
	hl(0, "SpellCap", { undercurl = true, sp = c.warn })
	hl(0, "SpellRare", { undercurl = true, sp = c.hint })
	hl(0, "SpellLocal", { undercurl = true, sp = c.info })

	hl(0, "QuickFixLine", { bg = c.bg_visual })
	hl(0, "qfLineNr", { fg = c.fg })
	hl(0, "qfFileName", { fg = c.blue })

	hl(0, "DiagnosticUnderlineHint", { sp = c.comment, undercurl = true, underline = false })
	hl(0, "DiagnosticUnderlineWarn", { undercurl = true, underline = false })

	-- =========================================================================
	-- Syntax (legacy highlight groups)
	-- =========================================================================
	hl(0, "Comment", { fg = c.comment, italic = true })
	hl(0, "SpecialComment", { fg = c.comment, italic = true })

	hl(0, "Constant", { fg = c.comptime })
	hl(0, "String", { fg = c.literal })
	hl(0, "Character", { fg = c.comptime })
	hl(0, "Number", { fg = c.comptime })
	hl(0, "Float", { fg = c.comptime })
	hl(0, "Boolean", { fg = c.comptime })

	hl(0, "Identifier", { fg = c.fg })
	hl(0, "Function", { fg = c.fg, italic = true })

	hl(0, "Statement", { fg = c.keyword })
	hl(0, "Keyword", { fg = c.keyword })
	hl(0, "Conditional", { fg = c.keyword })
	hl(0, "Repeat", { fg = c.keyword })
	hl(0, "Label", { fg = c.keyword })
	hl(0, "Operator", { fg = c.keyword })
	hl(0, "Exception", { fg = c.red })

	hl(0, "PreProc", { fg = c.purple })
	hl(0, "Include", { fg = c.purple })
	hl(0, "Define", { fg = c.comptime })
	hl(0, "Macro", { fg = c.fg })
	hl(0, "PreCondit", { fg = c.purple })

	hl(0, "Type", { fg = c.type_name })
	hl(0, "StorageClass", { fg = c.keyword })
	hl(0, "Structure", { fg = c.type_name })
	hl(0, "Typedef", { fg = c.type_name })

	hl(0, "Special", { fg = c.fg })
	hl(0, "SpecialChar", { fg = c.comptime })
	hl(0, "Tag", { fg = c.blue })
	hl(0, "Delimiter", { fg = c.fg })
	hl(0, "Debug", { fg = c.magenta })

	hl(0, "Underlined", { underline = true })
	hl(0, "Bold", { bold = true })
	hl(0, "Italic", { italic = true })
	hl(0, "Ignore", { fg = c.fg_dim })
	hl(0, "Error", { fg = c.error })
	hl(0, "Todo", { fg = c.keyword })

	-- =========================================================================
	-- Treesitter (@-prefixed, nvim 0.8+)
	-- =========================================================================

	-- Identifiers
	hl(0, "@variable", { fg = c.fg })
	hl(0, "@variable.builtin", { fg = c.fg_dim })
	hl(0, "@variable.parameter", { fg = c.fg })
	hl(0, "@variable.member", { fg = c.fg })

	-- Constants
	hl(0, "@constant", { fg = c.comptime })
	hl(0, "@constant.builtin", { fg = c.comptime, italic = false })
	hl(0, "@constant.macro", { fg = c.comptime })

	hl(0, "@module", { fg = c.fg_dim })
	-- hl(0, "@module.builtin",        { })
	hl(0, "@label", { fg = c.keyword })

	-- Literals
	hl(0, "@string", { fg = c.literal })
	hl(0, "@string.documentation", { fg = c.comment, italic = true })
	-- hl(0, "@string.regexp",         { fg = c.literal })
	-- hl(0, "@string.escape",         { fg = c.literal })
	-- hl(0, "@string.special",        { fg = c.literal })

	hl(0, "@string.special.symbol", { fg = c.fg, italic = true })
	hl(0, "@string.special.url", { fg = c.blue, underline = true })
	hl(0, "@string.special.path", { fg = c.blue })

	hl(0, "@character", { fg = c.comptime })
	hl(0, "@character.special", { fg = c.fg_dim })

	hl(0, "@number", { fg = c.comptime })
	-- hl(0, "@number.float", { fg = c.comptime })

	hl(0, "@boolean", { fg = c.comptime })

	-- Types
	hl(0, "@type", { fg = c.type_name })
	hl(0, "@type.builtin", { fg = c.type_name })
	hl(0, "@type.definition", { fg = c.type_name })
	hl(0, "@type.qualifier", { fg = c.fg_dim })

	hl(0, "@attribute", { fg = c.purple })
	-- hl(0, "@attribute.builtin", { })
	hl(0, "@property", { fg = c.fg })

	-- Functions
	hl(0, "@function", { fg = c.fg, italic = true })
	hl(0, "@function.builtin", { fg = c.fg, italic = true })
	-- hl(0, "@function.call",         { fg = c.comptime })
	hl(0, "@function.macro", { fg = c.purple, italic = true })
	-- hl(0, "@function.method",       { fg = c.comptime })
	-- hl(0, "@function.method.call",  { fg = c.comptime })

	hl(0, "@constructor", { fg = c.type_name })

	-- Keywords
	hl(0, "@keyword", { fg = c.fg_dim })
	-- hl(0, "@keyword.coroutine",     { fg = c.keyword })
	-- hl(0, "@keyword.function",      { fg = c.keyword })
	-- hl(0, "@keyword.operator",      { fg = c.keyword })
	-- hl(0, "@keyword.import",        { fg = c.keyword })
	-- hl(0, "@keyword.type",          { fg = c.keyword })
	-- hl(0, "@keyword.modifier",      { fg = c.keyword })
	-- hl(0, "@keyword.repeat",        { fg = c.keyword })
	-- hl(0, "@keyword.return",        { fg = c.keyword })
	hl(0, "@keyword.debug", { fg = c.magenta })
	-- hl(0, "@keyword.exception",     { })
	-- hl(0, "@keyword.conditional",   { fg = c.keyword })
	-- hl(0, "@keyword.conditional.ternary", { fg = c.fg })
	-- hl(0, "@keyword.directive", { fg = c.purple })
	-- hl(0, "@keyword.directive.define", { fg = c.comptime })

	-- Punctuation
	hl(0, "@punctuation", { fg = c.fg_dim })
	-- hl(0, "@punctuation.delimiter", {  })
	-- hl(0, "@punctuation.bracket",   { fg = c.fg_dim })
	-- hl(0, "@punctuation.special",   {  })

	-- Comments
	hl(0, "@comment", { fg = c.comment, italic = true })
	hl(0, "@comment.documentation", { fg = c.comment, italic = true })
	hl(0, "@comment.error", { fg = c.error })
	hl(0, "@comment.warning", { fg = c.warn })
	hl(0, "@comment.todo", { fg = c.keyword })
	hl(0, "@comment.note", { fg = c.hint })

	-- Markup
	hl(0, "@markup.strong", { bold = true })
	hl(0, "@markup.italic", { italic = true })
	hl(0, "@markup.strikethrough", { strikethrough = true })
	hl(0, "@markup.underline", { underline = true })
	hl(0, "@markup.heading", { fg = c.keyword })
	hl(0, "@markup.heading.1", { fg = c.keyword })
	hl(0, "@markup.heading.2", { fg = c.orange })
	hl(0, "@markup.heading.3", { fg = c.yellow })
	hl(0, "@markup.heading.4", { fg = c.type_name })
	hl(0, "@markup.heading.5", { fg = c.fg })
	hl(0, "@markup.heading.6", { fg = c.fg_dim })
	hl(0, "@markup.quote", { fg = c.comment, italic = true })
	hl(0, "@markup.math", { fg = c.fg, italic = true })
	hl(0, "@markup.link", { fg = c.blue, underline = true })
	hl(0, "@markup.link.label", { fg = c.fg })
	hl(0, "@markup.link.url", { fg = c.blue, underline = true })
	hl(0, "@markup.raw", { fg = c.literal })
	hl(0, "@markup.raw.block", { fg = c.fg })
	hl(0, "@markup.list", { fg = c.keyword })
	hl(0, "@markup.list.checked", { fg = c.green })
	hl(0, "@markup.list.unchecked", { fg = c.fg_dim })

	hl(0, "@diff.plus", { fg = c.git_add })
	hl(0, "@diff.minus", { fg = c.git_delete })
	hl(0, "@diff.delta", { fg = c.git_change })

	hl(0, "@tag", { fg = c.blue })
	hl(0, "@tag.attribute", { fg = c.fg })
	hl(0, "@tag.delimiter", { fg = c.fg })

	-- =========================================================================
	-- LSP Semantic Tokens
	-- =========================================================================

	-- gets applied on top of treesitter. declaring an empty highlight prevents automatic linkages from that declaration.

	hl(0, "@lsp", {})

	hl(0, "@lsp.type.type", { fg = c.type_name })
	hl(0, "@lsp.type.class", {})
	hl(0, "@lsp.type.struct", {})
	hl(0, "@lsp.type.interface", {})
	hl(0, "@lsp.type.typeAlias", {})
	hl(0, "@lsp.type.typeParameter", {})
	hl(0, "@lsp.type.parameter", {})
	hl(0, "@lsp.type.variable", {})
	hl(0, "@lsp.type.property", {})
	hl(0, "@lsp.type.function", { italic = true })
	hl(0, "@lsp.type.method", { italic = true })
	hl(0, "@lsp.type.namespace", { fg = c.fg_dim })
	hl(0, "@lsp.type.keyword", {})
	hl(0, "@lsp.type.comment", {})
	hl(0, "@lsp.type.string", {})
	hl(0, "@lsp.type.number", {})
	hl(0, "@lsp.type.regexp", {})
	hl(0, "@lsp.type.operator", {})
	hl(0, "@lsp.type.boolean", {})

	-- Keep LSP for these — treesitter can't distinguish them
	hl(0, "@lsp.type.enum", {})
	hl(0, "@lsp.type.enumMember", { fg = c.fg })
	hl(0, "@lsp.type.macro", { fg = c.purple, italic = true })
	hl(0, "@lsp.type.decorator", {})
	hl(0, "@lsp.type.annotation", {})

	-- rust-analyzer custom semantic token types
	hl(0, "@lsp.type.builtinType", {})
	hl(0, "@lsp.type.selfTypeKeyword", {})
	hl(0, "@lsp.type.selfKeyword", {})
	hl(0, "@lsp.type.lifetime", { fg = c.purple })
	hl(0, "@lsp.type.generic", {})
	hl(0, "@lsp.type.formatSpecifier", { fg = c.comptime })
	hl(0, "@lsp.type.unresolvedReference", {
		fg = c.fg,
		undercurl = true,
		sp = c.error,
	})
	hl(0, "@lsp.type.deriveHelper", { fg = c.purple })

	hl(0, "@lsp.mod.deprecated", { strikethrough = true })
	hl(0, "@lsp.mod.readonly", {})

	-- =========================================================================
	-- Diagnostics
	-- =========================================================================
	hl(0, "DiagnosticError", { fg = c.error })
	hl(0, "DiagnosticWarn", { fg = c.warn })
	hl(0, "DiagnosticHint", { fg = c.orange })
	hl(0, "DiagnosticInfo", { fg = c.info })
	hl(0, "DiagnosticOk", { fg = c.green })

	hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.error })
	hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = c.warn })
	hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = c.hint })
	hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = c.info })

	hl(0, "DiagnosticVirtualTextError", { fg = c.error })
	hl(0, "DiagnosticVirtualTextWarn", { fg = c.warn })
	hl(0, "DiagnosticVirtualTextHint", { fg = c.hint })
	hl(0, "DiagnosticVirtualTextInfo", { fg = c.info })

	hl(0, "DiagnosticSignError", { fg = c.error })
	hl(0, "DiagnosticSignWarn", { fg = c.warn })
	hl(0, "DiagnosticSignHint", { fg = c.hint })
	hl(0, "DiagnosticSignInfo", { fg = c.info })

	hl(0, "DiagnosticUnnecessary", {})

	-- =========================================================================
	-- Git / Diff
	-- =========================================================================
	hl(0, "DiffAdd", { fg = c.git_add })
	hl(0, "DiffChange", { fg = c.git_change })
	hl(0, "DiffDelete", { fg = c.git_delete })
	hl(0, "DiffText", { fg = c.fg })

	hl(0, "GitSignsAdd", { fg = c.git_add })
	hl(0, "GitSignsChange", { fg = c.git_change })
	hl(0, "GitSignsDelete", { fg = c.git_delete })

	-- =========================================================================
	-- Plugin: Telescope
	-- =========================================================================
	hl(0, "TelescopeNormal", { fg = c.fg, bg = c.bg_float })
	hl(0, "TelescopeBorder", { fg = c.fg_dim, bg = c.bg_float })
	hl(0, "TelescopeTitle", { fg = c.keyword, bg = c.bg_float })
	hl(0, "TelescopeSelection", { fg = c.fg, bg = c.bg_visual })
	hl(0, "TelescopeSelectionCaret", { fg = c.keyword })
	hl(0, "TelescopeMatching", { fg = c.keyword })
	hl(0, "TelescopePromptNormal", { fg = c.fg, bg = c.bg_darker })
	hl(0, "TelescopePromptBorder", { fg = c.fg_dim, bg = c.bg_darker })
	hl(0, "TelescopePromptPrefix", { fg = c.keyword })

	-- =========================================================================
	-- Plugin: nvim-cmp
	-- =========================================================================
	hl(0, "CmpItemAbbr", { fg = c.fg })
	hl(0, "CmpItemAbbrDeprecated", { fg = c.fg_dim, strikethrough = true })
	hl(0, "CmpItemAbbrMatch", { fg = c.keyword })
	hl(0, "CmpItemAbbrMatchFuzzy", { fg = c.orange })
	hl(0, "CmpItemKind", { fg = c.type_name })
	hl(0, "CmpItemMenu", { fg = c.fg_dim })

	-- =========================================================================
	-- Plugin: neo-tree
	-- =========================================================================
	hl(0, "NeoTreeNormal", { fg = c.fg, bg = c.bg_darker })
	hl(0, "NeoTreeNormalNC", { fg = c.fg, bg = c.bg_darker })
	hl(0, "NeoTreeDirectoryIcon", { fg = c.blue })
	hl(0, "NeoTreeDirectoryName", { fg = c.blue })
	hl(0, "NeoTreeFileName", { fg = c.fg })
	hl(0, "NeoTreeGitAdded", { fg = c.git_add })
	hl(0, "NeoTreeGitModified", { fg = c.git_change })
	hl(0, "NeoTreeGitDeleted", { fg = c.git_delete })

	-- =========================================================================
	-- Plugin: which-key
	-- =========================================================================
	hl(0, "WhichKey", { fg = c.keyword })
	hl(0, "WhichKeyGroup", { fg = c.type_name })
	hl(0, "WhichKeyDesc", { fg = c.fg })
	hl(0, "WhichKeySeparator", { fg = c.fg_dim })
	hl(0, "WhichKeyBorder", { fg = c.fg_dim, bg = c.bg_float })
	hl(0, "WhichKeyNormal", { fg = c.fg, bg = c.bg_float })

	-- =========================================================================
	-- Plugin: indent-blankline
	-- =========================================================================
	hl(0, "IblIndent", { fg = c.bg_cursor })
	hl(0, "IblScope", { fg = c.fg_dim })

	-- =========================================================================
	-- Plugin: nvim-notify
	-- =========================================================================
	hl(0, "NotifyERRORBorder", { fg = c.error })
	hl(0, "NotifyWARNBorder", { fg = c.warn })
	hl(0, "NotifyINFOBorder", { fg = c.info })
	hl(0, "NotifyHINTBorder", { fg = c.hint })
	hl(0, "NotifyDEBUGBorder", { fg = c.fg_dim })
	hl(0, "NotifyERRORTitle", { fg = c.error })
	hl(0, "NotifyWARNTitle", { fg = c.warn })
	hl(0, "NotifyINFOTitle", { fg = c.info })
	hl(0, "NotifyHINTTitle", { fg = c.hint })
	hl(0, "NotifyERRORBody", { fg = c.fg, bg = c.bg })
	hl(0, "NotifyWARNBody", { fg = c.fg, bg = c.bg })
	hl(0, "NotifyINFOBody", { fg = c.fg, bg = c.bg })
	hl(0, "NotifyHINTBody", { fg = c.fg, bg = c.bg })
end

return M
