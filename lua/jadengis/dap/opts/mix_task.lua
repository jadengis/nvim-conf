local opts = {
  type = "executable",
  command = vim.fn.stdpath("data") .. '/mason/packages/elixir-ls/debugger.sh', -- debugger.bat for windows
  args = {}
}
return opts
