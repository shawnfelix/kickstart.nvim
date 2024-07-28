-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- Define a custom function to switch to an existing window if the file is already open
local function switch_to_existing_window(state)
  local node = state.tree:get_node()
  if node.type == 'file' then
    local file_path = node:get_id()
    -- Iterate over all windows and check if the buffer is open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name == file_path then
        vim.api.nvim_set_current_win(win)
        return
      end
    end
  end
  -- If the file is not open in any window, open it in the current window
  print 'not found................'
  require('neo-tree.sources.filesystem.commands').open(state)
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      window = {
        position = 'right',
        mappings = {
          ['\\'] = 'close_window',
          ['<CR>'] = switch_to_existing_window,
        },
      },
      filtered_items = {
        hide_hidden = false,
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true,
      },
    },
  },
}
