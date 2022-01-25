local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- require "lsp.lsp-installer"
-- require("lsp.handlers").setup()
-- require "lsp.null-ls"

require'lspconfig'.pyright.setup{}

require'lspconfig'.jdtls.setup{
   cmd = { 'jdtls' },
   root_dir = function(fname)
      return require'lspconfig'.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
   end
}

require'lspconfig'.omnisharp.setup {
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "/Users/michaelbarnes/Downloads/omnisharp-osx/run", "--languageserver" , "--hostPID", tostring(pid) },
}

require'lspconfig'.rust_analyzer.setup{}

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  indent = { enable = true }
}
