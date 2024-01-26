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
    -- Toggle check-boxes
    ["<leader>ch"] = {
      action = function()
        return obsidian.util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },

  -- disable default zettelkasten id, just use the title
  note_id_func = function(title) return title end,
  note_frontmatter_func = function(note)
    local out = { tags = note.tags, aliases = note.aliases }

    local is_daily = false
    for _, tag in pairs(note.tags) do
      if tag == "daily-notes" then
        is_daily = true
        break
      end
    end

    if not is_daily and note.aliases ~= nil and not vim.tbl_isempty(note.aliases) then
      local index = nil
      for k, v in pairs(note) do
        if v == note.title then
          index = k
        end
      end
      if index ~= nil then
        note.aliases.remove(index)
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
