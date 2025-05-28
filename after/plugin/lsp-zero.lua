local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local telescope = require("telescope.builtin")
--
-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'
--
-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

lsp_zero.on_attach(function(client, bufnr)
  local keymap = vim.keymap

  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false
  })

  -- extra keymaps
  keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr, desc = '[L] References' })
  keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { desc = '[T] Search LSP definitions' })
  keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', { desc = '[T] Search LSP type definitions' })
  keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { desc = '[T] Search LSP implementations' })
  keymap.set({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[L] Code Action' })
  keymap.set('n', '<leader>lR', vim.lsp.buf.rename, { buffer = bufnr, desc = '[L] Rename' })
end)

lsp_zero.ui({
  float_border = 'rounded',
  sign_text = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»',
  },
})

-- too see if the lsp is working properly you can use the following command
-- :lua require('lsp-zero.check').inspect_settings('<server>')
-- e.g.
-- :lua require('lsp-zero.check').inspect_settings('yamlls')
local handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      settings = {
        -- TODO: not working as expected
        inlay_hints = { enabled = true },
      }
    }
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
  ['helm_ls'] = function()
    require('lspconfig').helm_ls.setup({
      logLevel = "info",
      valuesFiles = {
        mainValuesFile = "values.yaml",
        lintOverlayValuesFile = "values.lint.yaml",
        additionalValuesFilesGlobPattern = "values*.yaml"
      },
      yamlls = {
        enabled = true,
        enabledForFilesGlob = "*.{yaml,yml}",
        diagnosticsLimit = 50,
        showDiagnosticsDirectly = false,
        path = "yaml-language-server",
        config = {
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
            kubernetes = "/*.yaml",
          },
          schemaStore = {
            enable = true,
          },
          validate = true,
          completion = true,
          hover = true,
          format = {
            enable = true,
          },
          -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
        }
      }
    })
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
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            -- kubernetes = "/*.yaml",
          },
          schemaStore = {
            enable = true,
          },
          validate = true,
          completion = true,
          hover = true,
          format = {
            enable = true,
          },
          trace = {
            server = "verbose"
          },
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
      filetypes = { 'go', 'gomod', 'gowrok', 'gotpml' },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          completeUnimported = true,
          usePlaceholders = true,
          hints = {
            assignVariableTypes = true,
          }
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
  ['lemminx'] = function()
    require('lspconfig').lemminx.setup({
      filetypes = { 'xml' },
    })
  end,
  ['marksman'] = function()
    require('lspconfig').marksman.setup({
      filetypes = { 'markdown' },
    })
  end,
  ['basedpyright'] = function()
    require('lspconfig').basedpyright.setup({
      filetypes = { 'python' },
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'basic',
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          }
        }
      }
    })
  end,
  ['terraformls'] = function()
    require('lspconfig').terraformls.setup({
      -- on_attach = function(client)
      -- end,
      cmd = { "terraform-ls", "serve", "-req-concurrency", "20" },
      validations = {
        enableEnhancedValidation = true,
      },
      init_options = {
        experimentalFeatures = {
          prefillRequiredFields = true,
          validateOnSave = true,
        }
      }
    })
  end,
  ['tflint'] = function()
    require('lspconfig').tflint.setup({})
  end,
  ['kotlin_language_server'] = function()
    require('lspconfig').kotlin_language_server.setup({})
  end,
}

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'bashls', 'helm_ls', 'jsonls', 'lua_ls', 'marksman', 'yamlls', 'groovyls', 'dockerls', 'gopls', 'lemminx', 'marksman', 'basedpyright', 'terraformls', 'tflint', 'kotlin_language_server' },
})
require('mason-lspconfig').setup_handlers(handlers)

--
-- cmp settings
--

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

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
    ['<TAB>'] = cmp.mapping.confirm({
      -- documentation says this is important.
      -- I don't know why.
      behavior = cmp.ConfirmBehavior.Replace,
      select = false
    }),
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

-- TODO: Workaround (2024-03-29): When yaml file is opened that should be handled by helm_ls language server.
-- Only helm_ls client should be started. Because helm template can be .yaml file yamlls will also be started.
-- This autocommand will stop yamlls client if filetype is helm.
-- This should be solved differently, yamlls shoudn't be started at all. Check if there is some option for that
-- implemented in helm_ls at some point.
vim.api.nvim_create_autocmd(
  'LspAttach',
  {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if vim.bo[args.buf].filetype == 'helm' and client.name == 'yamlls' then
        vim.cmd('LspStop ' .. args.data.client_id)
      end
    end
  }
)
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = 'Chart.yaml',
  callback = function()
    vim.opt_local.filetype = 'helm'
  end
})

-- copied by https://github.com/MariaSolOs/dotfiles/blob/bda5388e484497b8c88d9137c627c0f24ec295d7/.config/nvim/lua/lsp.lua#L193
local methods = vim.lsp.protocol.Methods
local md_namespace = vim.api.nvim_create_namespace 'mariasolos/lsp_float'
---LSP handler that adds extra inline highlights, keymaps, and window options.
---Code inspired from `noice`.
---@param handler fun(err: any, result: any, ctx: any, config: any): integer, integer
---@return function
local function enhanced_float_handler(handler)
  return function(err, result, ctx, config)
    local buf, win = handler(
      err,
      result,
      ctx,
      vim.tbl_deep_extend('force', config or {}, {
        border = 'rounded',
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
      })
    )

    if not buf or not win then
      return
    end

    -- Conceal everything.
    vim.wo[win].concealcursor = 'n'

    -- Extra highlights.
    for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
      for pattern, hl_group in pairs {
        ['|%S-|'] = '@text.reference',
        ['@%S+'] = '@parameter',
        ['^%s*(Parameters:)'] = '@text.title',
        ['^%s*(Return:)'] = '@text.title',
        ['^%s*(See also:)'] = '@text.title',
        ['{%S-}'] = '@parameter',
      } do
        local from = 1 ---@type integer?
        while from do
          local to
          from, to = line:find(pattern, from)
          if from then
            vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
              end_col = to,
              hl_group = hl_group,
            })
          end
          from = to and to + 1 or nil
        end
      end
    end
  end
end

vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover)
vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help)
