local zenn = require("telescope_zenn")
local config = require("telescope_zenn.config")

local setup = function (ext_config)
  config.setup(ext_config)
end

local article_picker = function (opts)
  opts = opts or {}

  local attach_mappings = function (prompt_bufnr, map)
    for mode, tbl in pairs(config.mappings) do
      for key, action in pairs(tbl) do
        map(mode, key, action, { nowait = true })
      end
    end
    return true
  end
  if opts.attach_mappings then
    local opts_attach = opts.attach_mappings
    opts.attach_mappings = function (prompt_bufnr, map)
      attach_mappings(prompt_bufnr, map)
      return opts_attach(prompt_bufnr, map)
    end
  else
    opts.attach_mappings = attach_mappings
  end

  local extended = vim.tbl_extend("force", config, opts)
  zenn.article_picker(extended)
end

return require("telescope").register_extension {
  setup = setup,
  exports = {
    article_picker = article_picker,
  }
}
