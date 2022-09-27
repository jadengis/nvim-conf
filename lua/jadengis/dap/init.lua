local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end
local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
  return
end

local adapters = { "mix_task" }

-- Load all adapters
for _, adapter in pairs(adapters) do
  local has_opts, adapter_opts = pcall(require, "jadengis.dap.opts." .. adapter)
  if has_opts then
    dap.adapters[adapter] = adapter_opts
  end
end

-- Read environmental dap configurations
require('dap.ext.vscode').load_launchjs(nil, { mix_task = { "elixir" } })

-- Configure Signs
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })

-- Setup UI
dapui.setup {}

-- Event listeners to auto-pop UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
