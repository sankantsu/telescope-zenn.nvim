local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local zenn_finder = require("telescope_zenn.finder")

local article_picker = function (opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Zenn articles",
    finder = zenn_finder.make_finder(opts),
    sorter = conf.generic_sorter(opts),
    previewer = conf.file_previewer(opts),
  }):find()
end

return {
  article_picker = article_picker,
}
