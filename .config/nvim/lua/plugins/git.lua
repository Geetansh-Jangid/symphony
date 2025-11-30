return {
  -- git signs
  { "lewis6991/gitsigns.nvim" },

  -- for more advanced feature
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Fugitive Panel" })
    end,
  },

  -- git tui
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },
}
