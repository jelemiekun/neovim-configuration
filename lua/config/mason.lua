require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "glsl_analyzer",
    "cmake_language_server",
  },
})
