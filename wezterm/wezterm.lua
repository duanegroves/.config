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

local function expand_home_path(p)
  return p:gsub("^~", os.getenv("HOME"))
end

local function get_path_basename(path)
  return string.gsub(path, "(.*[/\\])(.*)", "%2")
end

local function get_git_branch(path)
  local success, branch_name, stderr = wezterm.run_child_process({
    "git", "-C", path, "rev-parse", "--abbrev-ref", "HEAD"
  })
  if not success then
    return nil
  else
    return branch_name:gsub("^%s+", ""):gsub("%s+$", "")
  end
end

local function set_around_padding(text, padding_size)
  local padded_left_status = wezterm.pad_left(text, #text + padding_size)
  return  wezterm.pad_right(padded_left_status, #padded_left_status + padding_size)
end

wezterm.on("update-status", function(window, pane)
  local workspace = window:active_workspace()
  window:set_left_status(
    string.format(" [%s] ", get_path_basename(workspace))
  )
  local branch_name = get_git_branch(expand_home_path(workspace))
  branch_name = branch_name and (" " .. branch_name .. " ") or ""
  window:set_right_status(branch_name)
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
