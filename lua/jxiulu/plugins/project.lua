return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup({
            detection_methods = { "lsp", "pattern" },
            patterns = { ".git", "Makefile", "makefile", "GNUmakefile", "CMakeLists.txt", "Cargo.toml", "dune-project" },
            silent_chdir = true,
        })
    end
}
