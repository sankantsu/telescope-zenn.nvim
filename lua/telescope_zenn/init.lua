local Path = require("plenary.path")
local Job = require("plenary.job")
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local zenn_finder = require("telescope_zenn.finder")

local ensure_zenn_cli_executable = function ()
  -- Ensure cwd is node.js project root
  local file = Path:new("./package.json")
  print(vim.inspect(file))
  if not file:exists() then
    vim.notify("./package.json not found. Please ensure that you are at the zenn directory root.", vim.log.levels.WARN)
    return false
  end

  -- Ensure zenn-cli is installed
  local res, code = Job:new({
    command = "npx",
    args = { "zenn", "--help" },
  }):sync()
  if code ~= 0 then
    vim.notify("Zenn cli is not executable. Please ensure that you are at the zenn directory root.", vim.log.levels.WARN)
    return false
  end
  return true
end

local article_picker = function (opts)
  if not ensure_zenn_cli_executable() then
    return
  end
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
