return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map("n", "]h", function()
        if vim.wo.diff then return "]h" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Git Next Hunk" })
      map("n", "[h", function()
        if vim.wo.diff then return "[h" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Git Previous Hunk" })

      map("n", "<leader>hs", gs.stage_hunk, { desc = "Git [H]unk [S]tage" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "Git [H]unk [R]eset" })
      map("n", "<leader>hS", gs.stage_buffer, { desc = "Git Buffer [H]unk [S]tage" })
      map("n", "<leader>hR", gs.reset_buffer, { desc = "Git Buffer [H]unk [R]eset" })
      map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Git [H]unk [U]ndo stage" })
      map("n", "<leader>hp", gs.preview_hunk_inline, { desc = "Git [H]unk [P]review" })
      map("n", "<leader>hP", gs.preview_hunk, { desc = "Git [H]unk [P]review full" })
      map("n", "<leader>hb", function()
        gs.blame_line { full = false }
      end, { desc = "Git [H]unk [B]lame" })
      map("n", "<leader>hB", function()
        gs.blame_line { full = true }
      end, { desc = "Git [H]unk [B]lame full" })
      map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Git [T]oggle [B]lame" })
      map("n", "<leader>td", gs.toggle_deleted, { desc = "Git [T]oggle [D]eleted hunks" })
      map("n", "<leader>hd", gs.diffthis, { desc = "Git [H]unk [D]iff" })
      map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Git [H]unk [D]iff HEAD" })
      map("v", "<leader>hs", function()
        gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
      end, { desc = "[G]it [R]eset hunk" })
      map("v", "<leader>hr", function()
        gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
      end, { desc = "[G]it [R]eset hunk" })

      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
    end,
  },
}
