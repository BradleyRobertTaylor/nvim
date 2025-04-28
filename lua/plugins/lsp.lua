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
    local keymap = require('bradleytaylor.utils').keymap

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
        end
        local builtin = require 'telescope.builtin'

        -- map('gd', builtin.lsp_definitions, 'Go to definition')
        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gr', builtin.lsp_references, 'Show list of references')
        map('gI', builtin.lsp_implementations, 'Go to implementation')
        map('<leader>ds', builtin.lsp_document_symbols, 'Show document symbols')
        map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, 'Show workspace symbols')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
      end,
    })

    -- diagnostics keymaps
    keymap('n', '[d', function()
      vim.diagnostic.jump { count = -1, float = true }
    end, 'Previous diagnostic message')
    keymap('n', ']d', function()
      vim.diagnostic.jump { count = 1, float = true }
    end, 'Next diagnostic message')
    keymap('n', '<leader>d', vim.diagnostic.open_float, 'Show diagnostic error')
    keymap('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic quickfix list')

    -- change diagnostic symbols
    vim.diagnostic.config {
      virtual_text = {
        prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
      },
      float = { border = 'rounded' },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = '󰠠 ',
          [vim.diagnostic.severity.HINT] = '󰠠 ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
    }

    local servers = {
      lua_ls = {},
      html = {},
      graphql = {
        filetypes = { 'graphql', 'gql', 'typescriptreact', 'javascriptreact' },
      },
      marksman = {},
      gopls = {},
      dockerls = {},
      ts_ls = {
        settings = {
          implicitProjectConfiguration = {
            checkJs = true,
          },
        },
      },
      eslint = {},
      pyright = {},
      ruff = {},
      cssls = {},
      tailwindcss = {},
      jsonls = {
        settings = {
          -- configure schemastore for autocomplete in json files
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      astro = {},
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    -- additional tools that aren't LSP servers
    vim.list_extend(ensure_installed, {
      'stylua',
      'prettier',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    local cmp = require 'cmp_nvim_lsp'
    local capabilities = cmp.default_capabilities()
    local lspconfig = require 'lspconfig'
    for name, config in pairs(servers) do
      lspconfig[name].setup(vim.tbl_deep_extend('force', {}, {
        capabilities = capabilities,
      }, config))
    end
  end,
}
