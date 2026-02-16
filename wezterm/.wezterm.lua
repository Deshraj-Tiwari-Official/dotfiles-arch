local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- =========================================================
-- CORE SETTINGS
-- =========================================================
config.front_end = "WebGpu"
config.enable_wayland = false
config.warn_about_missing_glyphs = false
config.scrollback_lines = 10000
config.animation_fps = 60
config.default_workspace = "home"

-- =========================================================
-- VISUALS & THEME
-- =========================================================
config.window_background_opacity = 0.95

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.6,
}

config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 11.0

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32

config.colors = {
  foreground = '#f8f8f2',
  background = '#0D1117',
  cursor_bg = '#bbbbbb',
  cursor_fg = '#0D1117',
  cursor_border = '#bbbbbb',
  selection_fg = '#1e1f28',
  selection_bg = '#44475a',
  scrollbar_thumb = '#44475a',
  split = '#44475a',
  ansi = {
    '#000000', '#ff5555', '#50fa7b', '#f0fa8b',
    '#8AADF4', '#ff78c5', '#8ae9fc', '#bbbbbb',
  },
  brights = {
    '#545454', '#ff5454', '#50fa7b', '#f0fa8b',
    '#8AADF4', '#ff78c5', '#8ae9fc', '#ffffff',
  },
  tab_bar = {
    background = '#0D1117',
  },
}

-- =========================================================
-- CUSTOM TAB BAR LOGIC
-- =========================================================
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local index = tab.tab_index + 1
  local title = tab.active_pane.title
  local zoom_icon = tab.active_pane.is_zoomed and " [Z]" or ""

  if tab.is_active then
    return {
      { Background = { Color = '#0D1117' } },
      { Foreground = { Color = '#8AADF4' } },
      { Attribute = { Intensity = 'Bold' } },
      { Text = ' ' .. index .. ': ' .. title .. zoom_icon .. ' ' },
    }
  end

  return {
    { Background = { Color = '#0D1117' } },
    { Foreground = { Color = '#808080' } },
    { Text = ' ' .. index .. ': ' .. title .. ' ' },
  }
end)

wezterm.on('update-status', function(window, pane)
  local leader = window:leader_is_active()

  if leader then
    window:set_left_status(wezterm.format({
      { Foreground = { Color = '#0D1117' } },
      { Background = { Color = '#8AADF4' } },
      { Attribute = { Intensity = 'Bold' } },
      { Text = ' 󰘳 LEADER ' }
    }))
  else
    window:set_left_status('')
  end
end)

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  local workspace = window:active_workspace()

  local cells = {}

  -- Resize Mode Indicator
  if name == 'resize_pane' then
    table.insert(cells, { Background = { Color = '#ff5555' } })
    table.insert(cells, { Foreground = { Color = '#0D1117' } })
    table.insert(cells, { Attribute = { Intensity = 'Bold' } })
    table.insert(cells, { Text = ' RESIZE MODE | ESC TO EXIT ' })
    table.insert(cells, { ResetAttributes = 'Flush' })

    -- Set the Right Status
    window:set_right_status(wezterm.format({
      { Foreground = { Color = '#BF616A' } },
      { Attribute = { Intensity = 'Bold' } },
      { Text = '  RESIZE MODE ACTIVE (ESC TO EXIT)  ' },
    }))
  else
    window:set_right_status('')
  end

  -- Workspace
  table.insert(cells, { Foreground = { Color = '#8AADF4' } })
  table.insert(cells, { Text = '   ' .. workspace .. '  ' })

  window:set_right_status(wezterm.format(cells))
end)

-- =========================================================
-- KEYBINDINGS
-- =========================================================
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = math.maxinteger}

config.keys = {
  -- Splits
  { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '_', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- Navigation
  { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },

  -- Tabs
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },

  -- Renaming (Built-in Prompt)
  { key = '$', mods = 'LEADER|SHIFT', action = act.PromptInputLine {
    description = 'Enter new name for workspace',
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
      end
    end),
  }},

  -- Resize Mode
  { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false } },

  -- Fonts
  { key = '+', mods = 'CTRL', action = act.IncreaseFontSize },
  { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
  { key = '0', mods = 'CTRL', action = act.ResetFontSize },

  -- Copy Mode
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
}

-- =========================================================
-- KEY TABLES
-- =========================================================
config.key_tables = {
  resize_pane = {
    { key = 'h', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 5 } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
  copy_mode = wezterm.gui.default_key_tables().copy_mode,
}

-- Add search binding to copy_mode
table.insert(config.key_tables.copy_mode, {
  key = '/',
  mods = 'NONE',
  action = act.Search { CaseInSensitiveString = '' }
})

return config
