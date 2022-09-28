local status_ok, lsp_installer = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

local servers = { "angularls", "tsserver", "jsonls", "html", "cssls", "tailwindcss", "elixirls", "sumneko_lua" }

lsp_installer.setup {
  ensure_installed = servers,
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("jadengis.lsp.handlers").on_attach,
    capabilities = require("jadengis.lsp.handlers").capabilities,
  }

  -- Apply custom settings for all required LSPs
  local has_custom_opts, server_custom_opts = pcall(require, "jadengis.lsp.opts." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  lspconfig[server].setup(opts)
end
