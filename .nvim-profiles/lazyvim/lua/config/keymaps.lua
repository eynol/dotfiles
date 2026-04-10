-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use `vim.keymap.set` instead
local map = vim.keymap.set

map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Try get hover info" })

-- 获取系统信息
local os_info = vim.loop.os_uname()
-- 判断是否为 macOS
local is_macos = os_info.sysname == "Darwin"

-- map("v", "<M-j>", ":'<,'>m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<M-k>", ":'<,'>m '<-2<cr>gv=gv", { desc = "Move up" })
map("v", "<M-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move down" })
map("v", "<M-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move up" })
map("v", "<M-up>", "<cmd>m '<-2<cr>gv=gv", { desc = "Move up" })
map("v", "<M-down>", "<cmd>m '>+1<cr>gv=gv", { desc = "Move down" })
map("n", "<M-up>", "<cmd>m .-2<cr>==", { desc = "Move down" })
map("n", "<M-down>", "<cmd>m .+1<cr>==", { desc = "Move up" })
map("i", "<M-up>", "<cmd>m .-2<cr>", { desc = "Move down" })
map("i", "<M-down>", "<cmd>m .+1<cr>", { desc = "Move up" })
-- 后续使用：if 条件判断执行对应逻辑
if is_macos then
  print("当前运行环境是 macOS")
  -- 这里写 macOS 专属配置，比如映射专属快捷键、设置特定选项
  -- 示例：macOS 下设置剪贴板与系统共享
  --  vim.opt.clipboard = "unnamedplus"
  map("n", "<D-s>", "<cmd>w<CR>", { desc = "Save" })
  map("v", "<D-c>", '"+y', { desc = "Copy to clipboard" }) -- Copy
else
  print("当前不是 macOS 环境")
end
if vim.g.neovide then
  map("n", "<D-s>", ":w<CR>", { silent = true, desc = "save file" }) -- Save
  map("v", "<D-c>", '"+y', { desc = "Copy to system clipboard" }) -- Copy
  map("n", "<D-v>", '"+P') -- Paste normal mode
  map("v", "<D-v>", '"+P') -- Paste visual mode
  map("c", "<D-v>", "<C-R>+") -- Paste command mode
  map("i", "<D-v>", "<C-R>+") -- Paste insert mode
end
-- if vim.fn.getenv("USER") == "bytedance" then
--   local get_git_root_dir = function()
--     local git_root = vim.fn.system({ "git", "rev-parse", "--show-toplevel" })
--     return git_root:gsub("\n", "")
--   end
--   local eden_lint = function(is_staged)
--     local is_git = os.execute("git rev-parse HEAD > /dev/null 2>&1")
--     if is_git ~= 0 then
--       print("is_git", is_git)
--       return
--     end
--     local git_root = get_git_root_dir()
--     local bin_file = git_root .. "/infra/node_modules/.bin/eden-lint"
--     -- print(vim.inspect(bin_file))
--     local command_path = vim.fs.normalize(bin_file)
--
--     -- git files
--     -- local files = vim.fn.system({ "git", "ls-files", (is_staged and "--stage" or "--modified") })
--     local files = vim.fn.system("git diff --name-only " .. (is_staged and "--cached" or ""))
--     files = files:gsub("\n", " ")
--
--     if files:len() == 0 then
--       print(vim.inspect("nothing changed"))
--       return
--     end
--
--     local command = command_path .. " format " .. currentFilePath
--     print(vim.inspect(command))
--     local result = vim.fn.system(command)
--     print(vim.inspect(result))
--     vim.cmd("e")
--   end
--   local eden_current = function(file)
--     local git_root = get_git_root_dir()
--     local bin_file = git_root .. "/infra/node_modules/.bin/eden-lint"
--     -- print(vim.inspect(bin_file))
--     local command_path = vim.fs.normalize(bin_file)
--     local currentFilePath = vim.fn.expand("%:p")
--
--     local command = command_path .. " format " .. currentFilePath
--     vim.notify("call:" .. command)
--     local result = vim.fn.system(command)
--     vim.cmd("e")
--
--     -- vim.notify(vim.inspect(result))
--     -- vim.notify(result)
--     print(vim.inspect(result))
--   end
--   map("n", "<leader>clc", function()
--     eden_current()
--   end, { desc = "Eden-lint current " })
--   map("n", "<leader>cll", function()
--     eden_lint(false)
--   end, { desc = "Eden-lint modified" })
--   map("n", "<leader>cls", function()
--     eden_lint(true)
--   end, { desc = "Eden-lint staged" })
-- end

local TSComment = function()
  local mode = vim.fn.mode()
  vim.cmd('echomsg "' .. mode .. '"')
  if string.match(mode, "n") then
    return [[:s:^\(\s*/\)/\(.*\)$:\1**\2*/:<cr>]]
  else
    return [[:s:^\(\s*/\)/\(.*\)$:\1**\2*/:<cr>]]
  end
end
map("n", "gcC", TSComment, { expr = true, desc = "TSComment Line" })
map("v", "gC", TSComment, { expr = true, desc = "TSComment Convert" })
