return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["Y"] = "copy_path",
                },
              },
            },
            actions = {
              copy_path = function(_, item)
                local modify = vim.fn.fnamemodify
                local filepath = item.file
                local filename = modify(filepath, ":t")
                local values = {
                  filepath,
                  modify(filepath, ":."),
                  modify(filepath, ":~"),
                  filename,
                  modify(filename, ":r"),
                  modify(filename, ":e"),
                }
                local items = {
                  "Absolute path: " .. values[1],
                  "Path relative to CWD: " .. values[2],
                  "Path relative to HOME: " .. values[3],
                  "Filename: " .. values[4],
                }
                if vim.fn.isdirectory(filepath) == 0 then
                  vim.list_extend(items, {
                    "Filename without extension: " .. values[5],
                    "Extension of the filename: " .. values[6],
                  })
                end
                vim.ui.select(items, { prompt = "Choose to copy to clipboard:" }, function(choice, i)
                  if not choice then
                    vim.notify("Selection cancelled")
                    return
                  end
                  if not i then
                    vim.notify("Invalid selection")
                    return
                  end
                  local result = values[i]
                  vim.fn.setreg('"', result) -- Neovim unnamed register
                  vim.fn.setreg("+", result) -- System clipboard
                  vim.notify("Copied: " .. result)
                end)
              end,
            },
          },
        },
      },
    },
  },
}
