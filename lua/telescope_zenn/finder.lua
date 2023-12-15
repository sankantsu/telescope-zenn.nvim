local finders = require "telescope.finders"
local entry_display = require "telescope.pickers.entry_display"
local config = require "telescope_zenn.config"

local M = {}

local entry_maker = function (opts)
  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = opts.slug_display_length },
      { width = 2 },
      { remaining = true },
    },
  }

  local make_display = function (entry)
    local metadata = entry.value
    local slug_abbrev = string.sub(metadata.slug, 0, opts.slug_display_length)
    return displayer {
      { slug_abbrev, "TelescopeResultsIdentifier" },
      metadata.emoji,
      metadata.title,
    }
  end

  return function (entry)
    local metadata = vim.json.decode(entry)
    return {
      value = metadata,
      -- add topic tags to improve searchability
      ordinal = metadata.slug .. " " .. metadata.title
                .. " " .. table.concat(metadata.topics, " "),
      display = make_display,
      path = "articles/" .. metadata.slug .. ".md",
    }
  end
end

M.make_finder = function (opts)
  opts.entry_maker = entry_maker(config)
  return setmetatable({
    close = function (self)
      self._finder = nil
    end,
  }, {
    __call = function (self, ...)
      local cmd = { "npx", "zenn", "list:articles", "--format", "json" }
      self._finder = finders.new_oneshot_job(cmd, opts)
      self._finder(...)
    end
  })
end

return M
