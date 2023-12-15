local zenn_actions = require("telescope_zenn.actions")

local config = {}

config.mappings = {
  ["n"] = {
    ["c"] = zenn_actions.create,
    ["d"] = zenn_actions.delete,
  },
}

config.setup = function (ext_config)
  config.slug_display_length = ext_config.slug_display_length or 7
end

return config
