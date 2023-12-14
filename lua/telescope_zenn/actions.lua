local Job = require("plenary.job")
local action_state = require("telescope.actions.state")

local actions = {}

actions.create = function (prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)

  local res, code = Job:new({
    command = "npx",
    args = { "zenn", "new:article", "--machine-readable" },
  }):sync()

  if code ~= 0 then
    vim.notify("Failed to create new article.", vim.log.levels.WARN)
    return
  end

  local path = res[1]
  if path then
    local finder = current_picker.finder
    current_picker:refresh(finder)
  end
end

return actions
