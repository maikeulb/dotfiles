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
