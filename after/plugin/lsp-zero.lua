local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local keymap = vim.keymap

  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false
  })

  -- extra keymaps
  keymap.set({ 'n' }, 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr, desc = '[L] References' })
  keymap.set({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[L] Code Action' })
  keymap.set({ 'n' }, '<leader>lr', vim.lsp.buf.rename, { buffer = bufnr, desc = '[L] Rename' })

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end)

-- Format code
vim.keymap.set(
  'n', '<leader>f',
  function()
    if vim.bo.filetype == 'markdown' then
      vim.bo.textwidth = 160
      vim.o.colorcolumn = '160'
      vim.api.nvim_command(':w')
      vim.api.nvim_command(':silent !deno fmt %')
      print('Deno format complete')
    else
      vim.api.nvim_command(':Format')
    end
  end,
  { desc = '[B] Format buffer with external tool of language server' }
)

-- too see if the lsp is working properly you can use the following command
-- :lua require('lsp-zero.check').inspect_settings('<server>')
-- e.g.
-- :lua require('lsp-zero.check').inspect_settings('yamlls')
local handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["lua_ls"] = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end,
  ['yamlls'] = function()
    require('lspconfig').yamlls.setup({
      filetypes = { 'yaml', 'yml' },
      settings = {
        yaml = {
          schemas = {
            -- helm unittest
            ["https://raw.githubusercontent.com/helm-unittest/helm-unittest/v0.4.1/schema/helm-testsuite.json"] =
            "tests/*_test.yaml",
            ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
            ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
            ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
            ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
            "*docker-compose*.{yml,yaml}",
            ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/helmfile.json"] =
            "helmfile.{yml,yaml}",
            -- kubernetes = "/*.yaml",
          },
          schemaDownload = { enable = true },
          validate = true,
          completion = true,
          hover = true
        },
      },
    })
  end,
  ['bashls'] = function()
    require('lspconfig').bashls.setup({
      filetypes = { 'sh', 'zsh' },
      settings = {
        bash = {
          format = {
            enable = true,
          },
        }
      }
    })
  end,
  ['groovyls'] = function()
    require('lspconfig').groovyls.setup({
      filetypes = { 'groovy', 'jenkinsfile' },
      settings = {
        groovy = {
          format = {
            enable = true,
          },
        }
      }
    })
  end,
  ['dockerls'] = function()
    require('lspconfig').dockerls.setup({
      filetypes = { 'dockerfile' },
    })
  end,
  ['gopls'] = function()
    require('lspconfig').gopls.setup({
      filetypes = { 'go' },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    })
  end,
  ['jsonls'] = function()
    require('lspconfig').jsonls.setup({
      filetypes = { 'json' },
      settings = {
        json = {
          schemas = {
            {
              fileMatch = { 'package.json' },
              url = 'https://json.schemastore.org/package.json',
            },
            {
              fileMatch = { 'tsconfig*.json' },
              url = 'https://json.schemastore.org/tsconfig.json',
            },
            {
              fileMatch = { '.eslintrc.json' },
              url = 'https://json.schemastore.org/eslintrc.json',
            },
            {
              fileMatch = { '.prettierrc', '.prettierrc.json' },
              url = 'https://json.schemastore.org/prettierrc.json',
            },
            {
              fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
              url = 'https://json.schemastore.org/babelrc.json',
            },
            {
              fileMatch = { 'lerna.json' },
              url = 'https://json.schemastore.org/lerna.json',
            },
            {
              fileMatch = { 'now.json', 'vercel.json' },
              url = 'https://json.schemastore.org/now.json',
            },
            {
              fileMatch = { 'tsconfig*.json' },
              url = 'https://json.schemastore.org/tsconfig.json',
            },
            {
              fileMatch = { 'jest.config.js' },
              url = 'https://json.schemastore.org/jest-config.json',
            },
          },
        },
      },
    })
  end,
}

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = { 'bashls', 'helm_ls', 'jsonls', 'lua_ls', 'marksman', 'yamlls', 'groovyls', 'dockerls', 'gopls' },
})
require('mason-lspconfig').setup_handlers(handlers)

--
-- cmp settings
--

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
cmp.setup({
  sources = {
    -- Copilot Source
    { name = "copilot",  group_index = 2 },
    -- Other Sources
    { name = "nvim_lsp", group_index = 2 },
    { name = "path",     group_index = 2 },
    { name = 'nvim_lua', group_index = 2 },
    { name = "luasnip" },
    { name = 'buffer',   keyword_length = 3 },
  },
  formatting = lsp_zero.cmp_format(),
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({ behavior = 'insert' })
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = 'insert' })
      else
        cmp.complete()
      end
    end),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
})
