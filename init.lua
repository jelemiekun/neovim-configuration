-- bootstrap lazy.nvim, LazyVim and your plugins
--
-- For old AMD machine, remove if upgraded TODO:
vim.env.PATH = vim.fn.expand("~/venvs/amd/bin") .. ":" .. vim.env.PATH
vim.g.python3_host_prog = vim.fn.expand("~/venvs/amd/bin/python")
-- Remove until here

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

vim.opt.colorcolumn = "80"

require("user.lsp")
