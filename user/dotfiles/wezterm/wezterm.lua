local wezterm = require 'wezterm'

local config =  {
  color_scheme = 'GruvboxDarkHard',
  font_size = 12,
  font = 
    wezterm.font('CaskaydiaCove Nerd Font Mono', {weight="Regular", stretch='Normal', style=Normal}),
    --wezterm.font('Maple Mono NF', {weight="Regular", stretch='Normal', style=Normal}),
  adjust_window_size_when_changing_font_size = false,

  hide_mouse_cursor_when_typing = false,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
  window_padding = {
    left = 4,
    right = 0,
    top = 0,
    bottom = 0,
  },

  enable_wayland = false,

--  window_frame = {
--    border_left_width = '0cell',
--    border_right_width = '0cell',
--    border_bottom_height = '0cell',
--    border_top_height = '0cell',
--  }
}

return config
