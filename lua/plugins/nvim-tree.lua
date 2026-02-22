-- File explorer plugin configuration --

return {
  -- Main nvim-tree plugin (file explorer)
  "nvim-tree/nvim-tree.lua",

  -- Optional dependency for file/folder icons
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Adds icons to the tree view
  },

  -- Key mappings for toggling the file explorer
  keys = {
    { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file explorer" },
  },

  config = function()
    -- Initialize and configure nvim-tree
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive", -- Sort files with case sensitivity
      },
      view = {
        width = 30, -- Width of the file explorer window (in columns)
      },
      renderer = {
        group_empty = true, -- Group empty folders together in the view
      },
    })
  end,
}

