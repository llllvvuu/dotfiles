--- @type LazyPluginSpec
return {
  "michaelb/sniprun",
  enabled = function()
    return vim.fn.executable("cargo")
  end,
  build = "bash install.sh",
  cmd = { "SnipRun" },
}
