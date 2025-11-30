return {
  { "savq/melange-nvim", lazy = true },
  { "AlexvZyl/nordic.nvim", lazy = true },
  { "xero/miasma.nvim", lazy = true },
  { "tiagovla/tokyodark.nvim", lazy = true, opts = { transparent_background = true } },
  { "rebelot/kanagawa.nvim", lazy = true, opts = { transparent = false, theme = "wave" } },
  { "ellisonleao/gruvbox.nvim", lazy = true, opts = { transparent_mode = true } },
  { "catppuccin/nvim", name = "catppuccin", lazy = true, opts = { transparent_background = false, flavour = "mocha" } },
  { "folke/tokyonight.nvim", lazy = true, opts = { style = "night", transparent = false } },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = { styles = { transparency = false } },
  },
  -- superior gruvbox variant
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_transparent_background = 1
    end,
  },
  -- custom theme
  {
    "bjarneo/aether.nvim",
    name = "aether",
    lazy = true,
    opts = {
      disable_italics = false,
      colors = {
        base00 = "#0f0f0f",
        base01 = "#5e5959",
        base02 = "#0f0f0f",
        base03 = "#5e5959",
        base04 = "#e6caab",
        base05 = "#eadccc",
        base06 = "#eadccc",
        base07 = "#e6caab",
        base08 = "#e25d6c",
        base09 = "#e9838f",
        base0A = "#f4bb54",
        base0B = "#cea37f",
        base0C = "#e8ab3b",
        base0D = "#e2be8a",
        base0E = "#f66151",
        base0F = "#edb95a",
      },
    },
  },
  -- fav theme (only this will be loaded on startup)
  {
    "vague2k/vague.nvim",
    priority = 1000,
    lazy = false,
    opts = { transparent = true },
    config = function(_, opts)
      require("vague").setup(opts)
      vim.cmd.colorscheme "vague"
    end,
  },
}
