local zenn = require("telescope_zenn")

local config = {}

local setup = function (ext_config)
  config.slug_display_length = ext_config.slug_display_length or 7
end

local article_picker = function (opts)
  opts = opts or {}
  local extended = vim.tbl_extend("force", config, opts)
  zenn.article_picker(extended)
end

return require("telescope").register_extension {
  setup = setup,
  exports = {
    article_picker = article_picker,
  }
}
