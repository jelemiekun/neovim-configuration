return {
  {
    "dccsillag/magma-nvim",
    lazy = false,
    build = ":UpdateRemotePlugins",

    init = function()
      vim.g.magma_automatically_open_output = false
      vim.g.magma_image_provider = "kitty"
      vim.g.magma_output_window_borders = false
    end,
  },
}
