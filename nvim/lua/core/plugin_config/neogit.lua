local wk = require("which-key")

require("gitsigns").setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Next changes" })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Previous changes" })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
    map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Stage hunk" })
    map("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Reset hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage File" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset File" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Unstage hunk" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>hb", function() gs.blame_line { full = true } end, { desc = "blame hunk" })
    map("n", "<leader>hl", gs.toggle_current_line_blame, { desc = "Toggle Blaming current line" })
    map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
    map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
    map("n", "<leader>ht", gs.toggle_deleted, { desc = "Toggle deleted" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}

require("neogit").setup {
  {
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = {
      telescope = true,
      diffview = true,
      fzf_lua = true,
    },
  },
}

wk.register({
  g = {
    name = "NeoGit",
    g = { "<cmd>Neogit kind=split<CR>", "Open NeoGit" },
    h = { "<cmd>DiffviewFileHistory %<CR>", "View file history" },
    o = { "<cmd>DiffviewOpen<CR>", "Open Diffview" },
    c = { "<cmd>DiffviewClose<CR>", "Close Diffview" },
    q = { "<cmd>VimuxCloseRunner<CR>", "Close tmux runner" },
    x = { "<cmd>VimuxInterruptRunner<CR>", "Interrupt command in the runner" },
    z = { "<cmd>VimuxZoomRunner<CR>", "Zoom" },
    cl = { "<cmd>VimuxClearTerminalScreen<CR>", "Clear the terminal screen" },
  },
}, { prefix = "<leader>" })
