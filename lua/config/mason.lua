require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "glsl_analyzer",
    "cmake_language_server",
    "java-language-server",
    "gradle-language-server",
    "kotlin-language-server",
    "lua-language-server",
    "html-lsp",
    "emmet-language-server", -- for html
    "css-lsp",
    "marksman", -- markdown files
  },
})
