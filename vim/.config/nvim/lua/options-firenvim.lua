vim.g.firenvim_config.localSettings[".*"] = { takeover = "never" }

local timer

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function()
    if timer and not timer:is_closing() then
      timer:stop()
      timer:close()
    end
    timer = vim.defer_fn(function() vim.cmd([[ write ]]) end, 500)
  end,
})
