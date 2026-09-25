return {
  {
    "dccsillag/magma-nvim",
    lazy = false,
    build = ":UpdateRemotePlugins",

    init = function()
      vim.g.magma_automatically_open_output = false
      vim.g.magma_image_provider = "ueberzug" -- TODO: For further inspection. If pc upgrades, refer to official installation
    end,
  },
}
