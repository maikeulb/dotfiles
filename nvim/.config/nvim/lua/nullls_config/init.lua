local null_ls = require'null-ls'
require("null-ls").setup({
  sources = {
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.formatting.clang_format,
    -- null_ls.builtins.formatting.codespell,
    -- null_ls.builtins.formatting.fish_indent,
    -- null_ls.builtins.formatting.fixjson,
    -- null_ls.builtins.formatting.google_java_format,
    -- null_ls.builtins.formatting.lua_format,
    -- null_ls.builtins.formatting.markdownlint,
    -- null_ls.builtins.formatting.pg_format,
    -- null_ls.builtins.formatting.rustfmt,
    -- null_ls.builtins.formatting.shfmt,
    -- null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.misspell,
    null_ls.builtins.diagnostics.proselint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.code_actions.gitsigns,
    -- null_ls.builtins.code_actions.gitrebase,
    -- null_ls.builtins.code_actions.proselint
  },
})

-- require('lint').linters_by_ft = {
  -- cpp = {'cpplint', 'clangtidy'}
-- }
