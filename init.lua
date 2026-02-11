-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.filetype.add({
  extension = {
    glsl = "glsl", -- maps `.custom` files to GLSL
  },
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.tex",
  command = "silent! !latexmk -pdf %",
})
