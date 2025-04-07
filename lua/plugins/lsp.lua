return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} }, -- lsp status updates
    'b0o/schemastore.nvim', -- access to schemastore catalog for json
  },
  config = function()
    require 'plugins.custom.lsp'
  end,
}
