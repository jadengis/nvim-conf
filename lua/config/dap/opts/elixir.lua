local M = {}
M.adapters = {
  mix_task = {
    type = "executable",
    command = vim.fn.stdpath("data") .. '/mason/packages/elixir-ls/debugger.sh', -- debugger.bat for windows
    args = {}
  }
}
M.configurations = {
  elixir = {
    {
      type = "mix_task",
      name = "Current Test",
      task = 'test',
      taskArgs = function()
        local name = vim.api.nvim_buf_get_name(0)
        return { "--trace", name }
      end,
      request = "launch",
      startApps = true, -- for Phoenix projects
      projectDir = "${workspaceFolder}",
      requireFiles = function()
        local name = vim.api.nvim_buf_get_name(0)
        return {
          "test/**/test_helper.exs",
          name,
        }

      end
    },
  }
}
return M
