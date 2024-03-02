-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use `vim.keymap.set` instead
local map = vim.keymap.set

map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Try get hover info" })

if vim.fn.getenv("USER") == "bytedance" then
  local get_git_root_dir = function()
    local git_root = vim.fn.system({ "git", "rev-parse", "--show-toplevel" })
    return git_root:gsub("\n", "")
  end
  local eden_lint = function(is_staged)
    local is_git = os.execute("git rev-parse HEAD > /dev/null 2>&1")
    if is_git ~= 0 then
      print("is_git", is_git)
      return
    end
    local git_root = get_git_root_dir()
    local bin_file = git_root .. "/infra/node_modules/.bin/eden-lint"
    -- print(vim.inspect(bin_file))
    local command_path = vim.fs.normalize(bin_file)

    -- git files
    -- local files = vim.fn.system({ "git", "ls-files", (is_staged and "--stage" or "--modified") })
    local files = vim.fn.system("git diff --name-only " .. (is_staged and "--cached" or ""))

    print(vim.inspect(files))
  end
  local eden_current = function(file)
    local git_root = get_git_root_dir()
    local bin_file = git_root .. "/infra/node_modules/.bin/eden-lint"
    -- print(vim.inspect(bin_file))
    local command_path = vim.fs.normalize(bin_file)
    local currentFilePath = vim.fn.expand("%:p")

    local result = vim.fn.system(command_path .. " --fix " .. currentFilePath)
    print(result)
  end
  map("n", "<leader>clc", function()
    eden_current()
  end, { desc = "Eden-lint modified" })
  map("n", "<leader>cll", function()
    eden_lint(false)
  end, { desc = "Eden-lint modified" })
  map("n", "<leader>cls", function()
    eden_lint(true)
  end, { desc = "Eden-lint staged" })
end
