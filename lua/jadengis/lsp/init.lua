local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("jadengis.lsp.lsp-installer")
require("jadengis.lsp.null-ls")
require("jadengis.lsp.handlers").setup()
