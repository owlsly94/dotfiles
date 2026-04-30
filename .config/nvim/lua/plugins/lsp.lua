return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- Keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, noremap = true, silent = true }
          local map = vim.keymap.set
          map("n", "gD",         vim.lsp.buf.declaration,     opts)
          map("n", "gd",         vim.lsp.buf.definition,      opts)
          map("n", "K",          vim.lsp.buf.hover,           opts)
          map("n", "gi",         vim.lsp.buf.implementation,  opts)
          map("n", "gr",         vim.lsp.buf.references,      opts)
          map("n", "<space>D",   vim.lsp.buf.type_definition, opts)
          map("n", "<space>rn",  vim.lsp.buf.rename,          opts)
          map("n", "<space>ca",  vim.lsp.buf.code_action,     opts)
          map("n", "<space>wa",  vim.lsp.buf.add_workspace_folder, opts)
          map("n", "<space>wr",  vim.lsp.buf.remove_workspace_folder, opts)
          map("n", "<space>wl",  function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          map("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          map("n", "<space>f", function()
            vim.diagnostic.setloclist()
          end, opts)
        end,
      })

      -- Servers
      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.enable("ts_ls")

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      })
      vim.lsp.enable("lua_ls")
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "lua_ls" },
      })
    end,
  },
}
