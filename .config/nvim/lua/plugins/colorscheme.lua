return {
  {
    'sainnhe/gruvbox-material',
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },

{
  "vague2k/vague.nvim",
  lazy = true,
  priority = 1000,
    opts = {
      transparent = true,
    },
  config = function()
    vim.cmd.colorscheme('vague')
  end,
}, 

{
    "rose-pine/neovim",
    lazy = true,
    name = "rose-pine",
    priority = 1000,
    config = function()
    require("rose-pine").setup({
    disable_background = true,
    })
        vim.cmd('colorscheme rose-pine')
    end,
	},
}
