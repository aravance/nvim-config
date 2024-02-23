local workspaces = {}
if vim.loop.os_uname().sysname == "Darwin" then
  table.insert(workspaces, {
    name = "work",
    path = "~/vaults/work",
  })
end
table.insert(workspaces, {
  name = "personal",
  path = "~/vaults/personal",
})

local stat = vim.loop.fs_stat(vim.fn.expand("~") .. "/vaults/work/config.lua")
if stat and stat.type == "file" then
  dofile(vim.fn.expand("~") .. "/vaults/work/config.lua")
end

local events = {}
for _, ws in pairs(workspaces) do
  table.insert(events, "BufReadPre " .. ws.path .. "/**.md")
  table.insert(events, "BufNewFile " .. ws.path .. "/**.md")
end

local function toggle_checkbox(checkmark, affix)
  local line = vim.api.nvim_get_current_line()
  if not string.match(line, "^%s*- %[.%]") then
    -- not a checkbox
    return
  end
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

  local is_checked = string.match(line, "- %[%S%]")
  if is_checked then
    line = string.gsub(line, "- %[%S%]", "- [ ]", 1)
    line = string.gsub(line, "%s*" .. affix .. " %d%d%d%d%-%d%d%-%d%d", "")
  else
    line = string.gsub(line, "- %[ %]", "- [" .. checkmark .. "]")
    local pattern = "%s?" .. affix .. " %d%d%d%d%-%d%d%-%d%d"
    if not string.find(line, pattern) then
      pattern = "%s?$"
    end
    line = string.gsub(line, pattern, " " .. affix .. " " .. os.date("%Y-%m-%d"), 1)
  end
  vim.api.nvim_buf_set_lines(0, row - 1, row, true, { line })
end

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- use the latest commit
  ft = "markdown",
  event = events,
  dependencies = {
    "nvim-lua/plenary.nvim",           -- Required
    "hrsh7th/nvim-cmp",                -- Optional
    "nvim-telescope/telescope.nvim",   -- Optional
    "nvim-treesitter/nvim-treesitter", -- Optional
    -- "pomo.nvim",                    -- Optional
  },
  keys = {
    { "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "Open [O]bsidian [f]ile" },
    { "<leader>od", "<cmd>ObsidianToday<CR>",       desc = "[O]bsidian to[d]ay" },
    { "<leader>oy", "<cmd>ObsidianYesterday<CR>",   desc = "[O]bsidian [y]esterday" },
    { "<leader>ot", "<cmd>ObsidianTomorrow<CR>",    desc = "[O]bsidian [t]omorrow" },
    { "<leader>og", "<cmd>ObsidianSearch<CR>",      desc = "[O]bsidian [g]rep" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>",   desc = "[O]bsidian [b]acklinks" },
    { "<leader>oa", "<cmd>ObsidianTags<CR>",        desc = "[O]bsidian t[a]gs" },
    { "<leader>op", "<cmd>ObsidianTemplate<CR>",    desc = "[O]bsidian tem[p]late" },
    { "<leader>ow", "<cmd>ObsidianWorkspace<CR>",   desc = "[O]bsidian switch [w]orkspace" },
  },
  opts = {
    workspaces = workspaces,

    log_level = vim.log.levels.INFO,
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      substitutions = {
        ["date:MMMM D, YYYY"] = function()
          return os.date("%B %-d, %Y")
        end,
      },
    },

    notes_subdir = "notes",
    new_notes_location = "notes_subdir",

    daily_notes = {
      folder = "daily",
      template = "daily.md",
    },

    mappings = {
      -- Overrides the "gf" mapping to work on markdown/wiki links within your vault
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes with tasks support
      ["<leader>cc"] = {
        action = function() toggle_checkbox("-", "❌") end,
        opts = { buffer = true },
      },
      ["<leader>ch"] = {
        action = function() toggle_checkbox("x", "✅") end,
        opts = { buffer = true },
      },
    },

    -- disable default zettelkasten id, just use the title
    note_id_func = function(title) return title end,
    follow_url_func = function(url)
      local opencmd
      if vim.loop.os_uname().sysname == "Linux" then
        opencmd = "xdg-open"
      else
        opencmd = "open"
      end
      vim.fn.jobstart({ opencmd, url })
    end,
    note_frontmatter_func = function(note)
      local out = { tags = note.tags }

      local is_daily = false
      for _, tag in pairs(note.tags) do
        if tag == "daily-notes" then
          is_daily = true
          break
        end
      end

      if note.aliases ~= nil and not vim.tbl_isempty(note.aliases) then
        local aliases = {}
        local index = 1
        for _, v in pairs(note.aliases) do
          if is_daily or v ~= note.id then
            aliases[index] = v
            index = index + 1
          end
        end
        if not vim.tbl_isempty(aliases) then
          out.aliases = aliases
        end
      end

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
  },
}
