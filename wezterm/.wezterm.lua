local wezterm = require('wezterm')
local act = wezterm.action


local function isViProcess(pane)
    -- get_foreground_process_name On Linux, macOS and Windows,
    -- the process can be queried to determine this path. Other operating systems
    -- (notably, FreeBSD and other unix systems) are not currently supported
    return pane:get_foreground_process_name():find('n?vim') ~= nil or pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(
        -- This should match the keybinds you set in Neovim.
            act.SendKey({ key = vim_direction, mods = 'CTRL' }),
            pane
        )
    else
        window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)

local my_launch_menu = {}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    -- local my_default_prog = { 'powershell.exe' }
    local my_default_prog = {'C:\\msys64\\usr\\bin'}
    table.insert(my_launch_menu, {
        label = "MSYS UCRT64",
        args = { "cmd.exe ", "/k", "C:\\msys64\\msys2_shell.cmd -defterm -here -no-start -ucrt64 -shell bash" },
    })
    -- config.default_prog = { "pwsh", "-nol" }
end



return {
    color_scheme = "Catppuccin Frappe",
    -- default_prog = my_default_prog,
    window_decorations = "RESIZE",
    font_size = 10.0,
    font = wezterm.font_with_fallback {
        "JetBrains Mono",
        "Fira Code",
        "Cascadia Code PL",
    },

    -- underline_thickness = "2px",
    -- underline_position = "-3px",

    -- dpi = 192.0,
    -- default_prog = { 'powershell.exe' , "-nol"},
    default_prog = { "pwsh", "-NoLogo" },
    default_cwd = "/c/Proj/",
    
    -- To try to limit cpu usage
	animation_fps = 10,
	cursor_blink_rate = 1000,
    
    -- default_prog = {"C:\\cygwin64\\bin\\bash.exe", "--login", "-i"},
    -- default_cwd = "/cygdrive/c/Proj/",

    leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 },
    front_end = "WebGpu",
    webgpu_power_preference = "HighPerformance",
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    -- hide_tab_bar_if_only_one_tab = true,
    keys = {
        -- move between split panes
        -- resize panes
        { key = 'h',  mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-left') },
        { key = 'j',  mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-down') },
        { key = 'k',  mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-up') },
        { key = 'l',  mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-right') },
        { key = "h",  mods = "LEADER|CTRL",  action = wezterm.action { AdjustPaneSize = { "Left", 3 } } },
        { key = "j",  mods = "LEADER|CTRL",  action = wezterm.action { AdjustPaneSize = { "Down", 3 } } },
        { key = "k",  mods = "LEADER|CTRL",  action = wezterm.action { AdjustPaneSize = { "Up", 3 } } },
        { key = "l",  mods = "LEADER|CTRL",  action = wezterm.action { AdjustPaneSize = { "Right", 3 } } },
        -- mimic tmux
        { key = "a",  mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
        { key = "-",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
        { key = "\\", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
        { key = "s",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
        { key = "v",  mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
        { key = "e",  mods = "LEADER",       action = act.RotatePanes 'Clockwise'}, 
        { key = "r",  mods = "LEADER",       action = act.RotatePanes 'CounterClockwise'}, 
        { key = "o",  mods = "LEADER",       action = "TogglePaneZoomState" },
        { key = "z",  mods = "LEADER",       action = "TogglePaneZoomState" },
        { key = "c",  mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
        { key = "1",  mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
        { key = "2",  mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
        { key = "3",  mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
        { key = "4",  mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
        { key = "5",  mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
        { key = "6",  mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
        { key = "7",  mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
        { key = "8",  mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
        { key = "9",  mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
        { key = "&",  mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
        { key = "d",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
        { key = "x",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
        { key = "[",  mods = "LEADER",       action = wezterm.action.ActivateCopyMode },
    },
}
