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
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },   -- Optional
    { "hrsh7th/nvim-cmp" },                -- Optional
    { "nvim-treesitter/nvim-treesitter" }, -- Optional
    -- { "pomo.nvim" },                    -- Optional
  },
  keys = {
    { "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", desc = "Open [O]bsidian [F]ile" },
    { "<leader>od", "<cmd>ObsidianToday<CR>",       desc = "[O]bsidian To[d]ay" },
    { "<leader>oy", "<cmd>ObsidianYesterday<CR>",   desc = "[O]bsidian [Y]esterday" },
    { "<leader>ot", "<cmd>ObsidianTomorrow<CR>",    desc = "[O]bsidian [T]omorrow" },
    { "<leader>og", "<cmd>ObsidianSearch<CR>",      desc = "[O]bsidian [G]rep" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>",   desc = "[O]bsidian [B]acklinks" },
    { "<leader>oa", "<cmd>ObsidianTags<CR>",        desc = "[O]bsidian T[a]gs" },
    { "<leader>op", "<cmd>ObsidianTemplate<CR>",    desc = "[O]bsidian Tem[p]late" },
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
        for k, v in pairs(note.aliases) do
          print("aliases." .. tostring(k) .. " = " .. tostring(v))
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
