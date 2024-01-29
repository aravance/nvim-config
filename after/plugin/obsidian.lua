local obsidian = require('obsidian')
obsidian.setup {
  workspaces = {
    {
      name = 'personal',
      path = '~/vaults/personal'
    },
  },

  notes_subdir = "notes",

  daily_notes = {
    folder = "daily",
    template = nil,
  },

  completion = {
    new_notes_location = "notes_subdir",
  },

  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault
    ["gf"] = {
      action = function()
        return obsidian.util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes with tasks support
    ["<leader>ch"] = {
      action = function()
        local line = vim.api.nvim_get_current_line()
        if not string.match(line, '^%s*- %[.%]') then
          return
        end
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))

        local is_checked = string.match(line, '- %[%S%]')
        if is_checked then
          line = string.gsub(line, '- %[%S%]', '- [ ]', 1)
          line = string.gsub(line, '%s*✅ %d%d%d%d%-%d%d%-%d%d', '')
        else
          line = string.gsub(line, '- %[ %]', '- [x]')
          local pattern = '%s?✅ %d%d%d%d%-%d%d%-%d%d'
          if not string.find(line, pattern) then
            pattern = '%s?$'
          end
          line = string.gsub(line, pattern, ' ✅ ' .. os.date('%Y-%m-%d'), 1)
        end
        vim.api.nvim_buf_set_lines(0, row - 1, row, true, { line })
      end,
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
        print('aliases.' .. tostring(k) .. ' = ' .. tostring(v))
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
}

vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Open [O]bsidian [F]ile" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "[O]bsidian To[d]ay" })
vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", { desc = "[O]bsidian [Y]esterday" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTomorrow<CR>", { desc = "[O]bsidian [T]omorrow" })
vim.keymap.set("n", "<leader>og", "<cmd>ObsidianSearch<CR>", { desc = "[O]bsidian [T]omorrow" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "[O]bsidian [T]omorrow" })
vim.keymap.set("n", "<leader>oa", "<cmd>ObsidianTags<CR>", { desc = "[O]bsidian [T]omorrow" })