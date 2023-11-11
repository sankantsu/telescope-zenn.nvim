local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"

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

local article_picker = function (opts)
  opts = opts or {}
  opts.entry_maker = vim.F.if_nil(opts.entry_maker, entry_maker(opts))
  local cmd = { "npx", "zenn", "list:articles", "--format", "json" }
  pickers.new(opts, {
    prompt_title = "Zenn articles",
    finder = finders.new_oneshot_job(cmd, opts),
    sorter = conf.generic_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

return {
  article_picker = article_picker,
}
