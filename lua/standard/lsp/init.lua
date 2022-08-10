local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify("lspconfig not found!") 
	return
end

require("standard.lsp.lsp-installer")
require("standard.lsp.handlers").setup()
require("standard.lsp.null-ls")
