if vim.g.loaded_gitsmith then
  return
end
vim.g.loaded_gitsmith = true

vim.api.nvim_create_user_command("Gitsmith", function()
  require("gitsmith").open()
end, { desc = "Open gitsmith" })

vim.api.nvim_create_user_command("GitsmithToggle", function()
  require("gitsmith").toggle()
end, { desc = "Toggle gitsmith" })
