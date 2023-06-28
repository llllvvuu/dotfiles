require('lualine').setup({
  options = { theme = 'tokyonight' },
  sections = {
    lualine_a = {
      {
        'filename',
        newfile_status = true,
        path = 1,
      }
    }
  }
})
