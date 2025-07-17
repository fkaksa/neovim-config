-- local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- TODO this needs to be moved to attachBuffer event
local keymap = vim.keymap
keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr, desc = '[L] References' })
keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { desc = '[T] Search LSP definitions' })
keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', { desc = '[T] Search LSP type definitions' })
keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { desc = '[T] Search LSP implementations' })
keymap.set({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[L] Code Action' })
keymap.set('n', '<leader>lR', vim.lsp.buf.rename, { buffer = bufnr, desc = '[L] Rename' })

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'basedpyright', 'bashls', 'dockerls', 'gopls', 'groovyls', 'helm_ls', 'jsonls', 'kotlin_language_server', 'lemminx', 'lua_ls', 'marksman', 'terraformls', 'tflint', 'yamlls', }
})


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
  -- formatting = lsp_zero.cmp_format(),
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
    completeopt = 'menu,menuone,noinsert,fuzzy,popup',
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

-- TODO
-- vim.api.nvim_create_autocmd('LspAttach', {
--   group = vim.api.nvim_create_augroup('my.lsp', {}),
--   callback = function(args)
--     local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--     if client:supports_method('textDocument/implementation') then
--       -- Create a keymap for vim.lsp.buf.implementation ...
--     end
--     -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
--     if client:supports_method('textDocument/completion') then
--       -- Optional: trigger autocompletion on EVERY keypress. May be slow!
--       -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
--       -- client.server_capabilities.completionProvider.triggerCharacters = chars
--       vim.lsp.completion.enable(false, client.id, args.buf, { autotrigger = true })
--       vim.keymap.set('i', '<C-Space>', function()
--         vim.lsp.completion.get()
--       end)
--     end

--     -- Auto-format ("lint") on save.
--     -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
--     if not client:supports_method('textDocument/willSaveWaitUntil')
--         and client:supports_method('textDocument/formatting') then
--       vim.api.nvim_create_autocmd('BufWritePre', {
--         group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
--         buffer = args.buf,
--         callback = function()
--           vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
--         end,
--       })
--     end
--   end,
-- })

vim.diagnostic.config({
  virtual_lines = {
    -- Show diagnostics on the current line
    current_line = true,
  },
  underline = true,
  update_in_insert = false,
  -- show pop up window up or down
  -- false means down
  severity_sort = false,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('*', {
  capabilities = capabilities,
  root_markers = { '.git' },
})
