local wezterm = require 'wezterm'
local io = require 'io'
local os = require 'os'
local launch_menu = {}
local act = wezterm.action


--wezterm.on(
--  'update-right-status',
--  function(window, pane)
--    local name = window:active_key_table()
--    if name then
--        name = 'TABLE: ' .. name
--    end
--    window:set_right_status(name or '')
--  end
--)

-- windows
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  --font_dirs = {
  --  "$HOME\\git\\dotfiles\\.fonts"
  --}
  default_prog = {"wsl.exe"},
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      -- wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')
      wezterm.glob('Microsoft Visual Studio/20*')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'wsl.exe',
        -- 'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
          .. vsvers
          .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end
  for i=1, #launch_menu
  do
    wezterm.log_info(launch_menu[i])
  end

-- linux
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  default_prog = {"/usr/bin/zsh"}
  window_background_image = ""
-- mac
elseif wezterm.target_triple == 'x86_64-apple-darwin' then
  default_prog = {"nu"}
  window_background_image = ""
end

function print_window_size(window)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}
  print(window_dims)
end

wezterm.on(
  'trigger-vim-with-visible-text',
  function(window, pane)
    local viewport_text = pane:get_lines_as_text()
    local name = os.tmpname()
    local f = io.open(name, 'w+')
    f:write(viewport_text)
    f:flush()
    f:close()
    window:perform_action(
      act.SpawnCommandInNewWindow{
        args = {'vim', name},
      },
      pane)
    wezterm.sleep_ms(1000)
    os.remove(name)
  end
)

wezterm.on(
  "plumb-selection",
  function(window, pane)
    local sel = window:get_selection_text_for_pane(pane);
    window:perform_action(
      wezterm.action{
        SplitHorizontal = {
          args = {
            "nu", "-c", "echo " .. json.encode(sel) .. " | deno run -A c:\\Users\\bucchiman\\.dotfiles\\wezterm\\plumb.ts | fzf "
          }
        },
        pane
      }
    )
  end
)


return {
  -- font_dirs = font_dirs,
  font_size = 18,
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
  selection_word_boundary = ' \t\n{[}]()"\'',
  color_scheme = 'iceberg-dark',
  default_prog = default_prog,
  window_background_opacity = 0.7,
  leader = {key = 'Space', mods = 'SHIFT', timeout_milliseconds = 2000},
  keys = {
    {
      key = 'E',
      mods = 'CTRL',
      action = act.EmitEvent 'trigger-vim-with-visible-text'
    },
    {
      key = 'mapped:\'',
      mods = 'LEADER',
      action = wezterm.action.SplitHorizontal {domain = 'CurrentPaneDomain'},
    },
    {
      key = 'mapped:\"',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitVertical {domain = 'CurrentPaneDomain'},
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

