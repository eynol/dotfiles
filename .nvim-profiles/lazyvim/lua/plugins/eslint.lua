local util = require("lspconfig.util")
local lsp = vim.lsp

local function dd(arg)
  local objects = vim.tbl_map(vim.inspect, { arg })
  print(unpack(objects))
end

local root_file = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  ".eslintrc.json",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
}

return {
  {
    "neovim/nvim-lspconfig",
    -- other settings removed for brevity
    opts = {
      ---@type table<string, vim.lsp.Config>
      servers = {
        eslint = {
          settings = {
            -- root_dir = "./",
            nodePath = "infra/node_modules/",
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { { mode = "auto" } },
            format = false,
          },
          root_dir = function(bufnr, on_dir)
            -- The project root is where the LSP can be started from
            -- As stated in the documentation above, this LSP supports monorepos and simple projects.
            -- We select then from the project root, which is identified by the presence of a package
            -- manager lock file.
            local root_markers =
              { "package-lock.json", "eden.monorepo.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
            -- Give the root markers equal priority by wrapping them in a table
            root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
              or vim.list_extend(root_markers, { ".git" })

            -- exclude deno
            if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
              return
            end

            -- We fallback to the current working directory if no project root is found
            local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

            -- We know that the buffer is using ESLint if it has a config file
            -- in its directory tree.
            --
            -- Eslint used to support package.json files as config files, but it doesn't anymore.
            -- We keep this for backward compatibility.
            local filename = vim.api.nvim_buf_get_name(bufnr)
            local eslint_config_files_with_package_json = util.insert_package_json(root_file, "eslintConfig", filename)
            local is_buffer_using_eslint = vim.fs.find(eslint_config_files_with_package_json, {
              path = filename,
              type = "file",
              limit = 1,
              upward = true,
              stop = vim.fs.dirname(project_root),
            })[1]
            if not is_buffer_using_eslint then
              return
            end

            on_dir(project_root)
            -- dd(project_root)
            -- -- return "/Users/bytedance/byted/service-data-fe/"
            -- local ok, result = pcall(
            --   vim.fn.writefile,
            --   { vim.fn.json_encode(project_root) },
            --   "/Users/bytedance/byted/service-data-fe/test.json"
            -- )
            --
            -- if ok then
            --   print("Okay")
            -- else
            --   print(result)
            -- end
            --
            return project_root
          end,
        },
      },
    },
  },
}
