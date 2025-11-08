local wezterm = require 'wezterm'

-- local act = wezterm.action
local config = wezterm.config_builder()
local keys = {}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

local scheme_name = 'rose-pine'
local selection_highlight = '#342d43'
local scheme_def = wezterm.color.get_builtin_schemes()[scheme_name]

config.color_scheme = scheme_name
config.colors = {
  selection_bg = selection_highlight,
  tab_bar = {
    background = scheme_def.background,
    active_tab = {
      bg_color = selection_highlight,
      fg_color = scheme_def.foreground,
    },
    inactive_tab = {
      bg_color = scheme_def.background,
      fg_color = scheme_def.foreground,
    },
    inactive_tab_hover = {
      bg_color = scheme_def.background,
      fg_color = scheme_def.foreground,
    },
    new_tab = {
      bg_color = scheme_def.background,
      fg_color = scheme_def.foreground,
    },
  },
}

-- Tab config
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

wezterm.on("update-status", function(window, pane)
  local workspace_name = string.gsub(window:active_workspace(), "(.*[/\\])(.*)", "%2")
  local status_text = string.format("[%s]", workspace_name)
  local desired_padding = 1 -- Number of spaces to add as padding
  local padded_left_status = wezterm.pad_left(status_text, #status_text + desired_padding)
  local padded_both_status = wezterm.pad_right(padded_left_status, #padded_left_status + desired_padding)
  window:set_left_status(padded_both_status)
end)

-- Workspace switcher plugin
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
workspace_switcher.apply_to_config(config)
config.default_workspace = "~"
table.insert(keys, {
  key = "s",
  mods = "LEADER",
  action = workspace_switcher.switch_workspace(),
})

config.keys = keys

return config
