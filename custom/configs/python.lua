local M = {}

local function get_python_path()
  -- Check for pyenv virtualenv in the current directory
  local cwd = vim.fn.getcwd()
  -- Check for .venv directory (common for virtualenv/venv)
  local venv_path = cwd .. "/.venv/bin/python"
  if vim.fn.executable(venv_path) == 1 then
    return venv_path
  end
  local which_python = vim.fn.system("which python")
  if vim.fn.executable(which_python) == 1 then
    return which_python
  end
  return vim.fn.system("which python3"):gsub("%s+", "")
end

M.setup = function()
    local lspconfig = require("lspconfig")
  
    -- Pyright setup
    lspconfig.pyright.setup({
        on_attach = function(client, bufnr)
            -- Optional: Add LSP keymaps here (e.g., goto definition)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        end,
        settings = {
            python = {
                python = {
                    -- Use the dynamically detected Python path
                    pythonPath = get_python_path(),
                    -- Optional: Configure type checking strictness
                    analysis = {
                        typeCheckingMode = "basic",  -- Options: "off", "basic", "strict"
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },  
                },
            },
        },
    })

    -- Null-ls setup for Black, Ruff, MyPy
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.black,   -- Black
            null_ls.builtins.diagnostics.ruff,   -- Ruff
            null_ls.builtins.diagnostics.mypy,   -- MyPy
        },
    })
end

 -- Format on save using Black
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function()
            vim.lsp.buf.formatting_sync()
        end,
    })

local dap = require('dap')

-- Set key mappings for debugging
vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })  -- Start/Continue
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true }) -- Step Over
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true }) -- Step Into
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true }) -- Step Out
vim.api.nvim_set_keymap('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true }) -- Toggle Breakpoint

return M
