vim.lsp.config('yamlls', {
  filetypes = { 'yaml', 'yaml.ansible', 'yaml.docker-compose' },
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
