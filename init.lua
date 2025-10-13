-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.filetype.add({
  extension = {
    glsl = "glsl", -- maps `.custom` files to GLSL
  },
})
