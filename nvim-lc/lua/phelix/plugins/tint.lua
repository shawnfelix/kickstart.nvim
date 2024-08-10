-- dim the inactive windows
--

return {
  'levouh/tint.nvim',
  version = '*',
  config = function()
    require('tint').setup {
      tint_background_colors = true,

      transforms = {
        require('tint.transforms').tint(10),
      },
    }
  end,
}
