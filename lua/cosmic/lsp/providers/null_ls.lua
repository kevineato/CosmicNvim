local u = require('cosmic.utils')
local defaults = require('cosmic.lsp.providers.defaults')
local config = require('cosmic.core.user')
local null_ls = require('null-ls')

local null_ls_config = {}
if config.lsp.servers.null_ls and config.lsp.servers.null_ls.setup then
  null_ls_config = config.lsp.servers.null_ls.setup(null_ls)
end

-- how to disable sources?
if null_ls_config.default_cosmic_sources then
  null_ls_config.sources = u.merge_list({
    null_ls.builtins.code_actions.eslint_d.with({
      prefer_local = 'node_modules/.bin',
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
      prefer_local = 'node_modules/.bin',
    }),
    null_ls.builtins.formatting.eslint_d.with({
      prefer_local = 'node_modules/.bin',
    }),
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.prettierd.with({
      env = {
        PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
      },
    }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.code_actions.gitsigns,
  }, null_ls_config.sources or {})
end

null_ls.setup(u.merge(defaults, null_ls_config))
