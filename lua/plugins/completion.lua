local myconfig = require("raghu")
return {
  {
    "hrsh7th/nvim-cmp",
    event = {
      "InsertEnter",
      "CmdlineEnter"
    },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
          {"L3MON4D3/LuaSnip"},
        },
      },
    },
    config = myconfig.configurePlugin,
  }

}
