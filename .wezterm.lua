local wezterm = require 'wezterm'
local launch_menu = {}
local act = wezterm.action

wezterm.on('update-right-status',
function(window, pane)
    local name = window:active_key_table()
    if name then
        name = 'TABLE: ' .. name
    end
    window:set_right_status(name or '')
end)


if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
          .. vsvers
          .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end
end


return {
  font = wezterm.font_with_fallback {
      {
          family = 'mononoki Nerd Font Mono',
          weight = 'Regular',
      },
      {
          family = 'Hack Nerd Font Mono',
          weight = 'Bold',
      },
      {
          family = 'Monoid Nerd Font Mono',
          weight = 'Bold',
      },
  },
  font_size = 18,
  color_scheme = 'iceberg-dark',
  default_prog = {"wsl.exe"},
  window_background_opacity = 0.7,
  leader = {key = 'Space', mods = 'SHIFT', timeout_milliseconds = 2000},
  keys = {
    {
      key = 'mapped:\'',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'},
    },
    {
      key = 'mapped:\"',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'},
    },
    {
      key = 'r',
      mods = 'LEADER',
      action = act.ActivateKeyTable{
        name = 'resize_pane',
        one_shot = false,
      },
    },
    {
      key = 'a',
      mods = 'LEADER',
      action = act.ActivateKeyTable{
        name = 'activate_pane',
        timeout_milliseconds = 1000,
      },
    },
  },
  key_tables = {
      resize_pane = {
          {key = 'LeftArrow', action = act.AdjustPaneSize{'Left', 1}},
          {key = 'h', action = act.AdjustPaneSize{'Left', 1}},
          {key = 'RightArrow', action = act.AdjustPaneSize{'Right', 1}},
          {key = 'l', action = act.AdjustPaneSize{'Right', 1}},
          {key = 'UpArrow', action = act.AdjustPaneSize{'Up', 1}},
          {key = 'k', action = act.AdjustPaneSize {'Up', 1}},
          {key = 'DownArrow', action = act.AdjustPaneSize{'Down', 1}},
          {key = 'j', action = act.AdjustPaneSize{'Down', 1}},
          {key = 'Escape', action = 'PopKeyTable'},
      },
    activate_pane = {
        {key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
        {key = 'h', action = act.ActivatePaneDirection 'Left' },
        {key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
        {key = 'l', action = act.ActivatePaneDirection 'Right' },
        {key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
        {key = 'k', action = act.ActivatePaneDirection 'Up' },
        {key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
        {key = 'j', action = act.ActivatePaneDirection 'Down' },
    },
  },
}

