return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        keymaps = {
          init_selection = "<C-x>",
          node_incremental = "<C-x>",
          node_decremental = "<C-->",
        },
      },
    },
  },
}
