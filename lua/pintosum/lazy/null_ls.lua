return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.eslint,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.blue,
      }
    })
  end
}
