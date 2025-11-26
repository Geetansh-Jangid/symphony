return{
  -- zen-mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        options = {
          laststatus = 0,
        },
        tmux = true,
        kitty = { enabled = false, font = "+4" },
        alacritty = { enabled = true, font = "18" },
      },
   },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").setup({})
	end,
	priority = 1000,

-- statusline
    {
      'nvim-lualine/lualine.nvim',
      config = function ()
        local mode = {
            'mode',
            fmt = function(str)
                return ' ' .. str
            end,
        }
    require('lualine').setup({
      options = {
      theme = 'auto'
    }
})
   end
  }
}
