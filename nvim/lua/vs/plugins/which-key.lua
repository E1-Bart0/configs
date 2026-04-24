return {
  "folke/which-key.nvim",
  priority = 999,
  config = function()
    local wk = require("which-key")
    local vscode = require("vscode")

    wk.setup {}

    -- ============================================================================
    -- BASIC OPERATIONS
    -- ============================================================================
    wk.add {
      { "<leader>+", "<C-a>", desc = "Increment number" },
      { "<leader>-", "<C-x>", desc = "Decrement number" },
      { "x", '"_x', desc = "Delete without clipboard", mode = { "n", "x" } },
      {
        "<leader>nh",
        function()
          vim.cmd("nohlsearch")
          vscode.action("workbench.files.action.refreshFilesExplorer")
        end,
        desc = "Clear highlights & refresh explorer",
      },
    }

    -- ============================================================================
    -- WINDOW MANAGEMENT
    -- ============================================================================
    wk.add {
      { "<leader>s", group = "Split Window" },
      { "<leader>se", "<C-w>=", desc = "Make splits equal width" },
      { "<leader>sh", "<C-w>s", desc = "Split horizontally" },
      { "<leader>sq", ":close<CR>", desc = "Close current split" },
      { "<leader>sv", "<C-w>v", desc = "Split vertically" },
    }

    -- ============================================================================
    -- NAVIGATION
    -- ============================================================================
    wk.add {
      -- Tab navigation (H/L) - complements VS Code's Ctrl+hjkl for windows
      {
        "H",
        function()
          vscode.action("workbench.action.previousEditorInGroup")
        end,
        desc = "Previous tab",
      },
      {
        "L",
        function()
          vscode.action("workbench.action.nextEditorInGroup")
        end,
        desc = "Next tab",
      },
      
      -- Problems navigation
      {
        "[d",
        function()
          vscode.action("editor.action.marker.next")
        end,
        desc = "Next problem",
      },
      {
        "]d",
        function()
          vscode.action("editor.action.marker.prev")
        end,
        desc = "Previous problem",
      },
      {
        "<leader>d",
        function()
          vscode.action("workbench.actions.view.problems")
        end,
        desc = "Show problems panel",
      },
      
      -- Changes navigation
      {
        "[c",
        function()
          vscode.action("workbench.action.editor.previousChange")
        end,
        desc = "Previous change",
      },
      {
        "]c",
        function()
          vscode.action("workbench.action.editor.nextChange")
        end,
        desc = "Next change",
      },
    }

    -- ============================================================================
    -- ARC (VERSION CONTROL)
    -- ============================================================================
    wk.add {
      { "<leader>h", group = "Arc/Git" },
      {
        "<leader>hp",
        function()
          vscode.action("editor.action.dirtydiff.next")
        end,
        desc = "Next hunk",
      },
      {
        "<leader>hd",
        function()
          vscode.action("arc.openChangeWithHead")
        end,
        desc = "Diff with HEAD",
      },
      {
        "<leader>hs",
        function()
          vscode.action("arc.stage", { group = "inline" })
        end,
        desc = "Stage change",
      },
      {
        "<leader>hS",
        function()
          vscode.action("arc.stageFile")
        end,
        desc = "Stage file",
      },
      {
        "<leader>hu",
        function()
          vscode.action("arc.unstage", { group = "inline" })
        end,
        desc = "Unstage change",
      },
      {
        "<leader>hU",
        function()
          vscode.action("arc.unstageAll")
        end,
        desc = "Unstage all",
      },
      {
        "<leader>hr",
        function()
          vscode.notify("Reverting change...")
          vscode.action("arc.revertChange", { group = "inline" })
        end,
        desc = "Revert change",
      },
      {
        "<leader>hR",
        function()
          vscode.action("arc.revertAll")
        end,
        desc = "Revert file",
      },
      {
        "<leader>hb",
        function()
          vscode.action("arc.blame.toggleCurrentLineDecorations")
        end,
        desc = "Toggle blame",
      },
    }

    -- ============================================================================
    -- LSP & CODE ACTIONS
    -- ============================================================================
    wk.add {
      {
        "gi",
        function()
          vscode.action("editor.action.goToImplementation")
        end,
        desc = "Go to implementation",
      },
      {
        "<C-k>",
        function()
          vscode.action("editor.action.showHover")
        end,
        desc = "Show hover",
      },
      {
        "ff",
        function()
          vscode.action("editor.action.formatDocument")
        end,
        desc = "Format document",
      },
      {
        "<leader>ca",
        function()
          vscode.action("editor.action.codeAction")
        end,
        mode = { "n", "x" },
        desc = "Code actions",
      },
      {
        "<leader>rn",
        function()
          vscode.action("editor.action.rename")
        end,
        desc = "Rename symbol",
      },
    }

    -- ============================================================================
    -- FOLDING
    -- ============================================================================
    wk.add {
      {
        "zc",
        function()
          vscode.action("editor.fold")
        end,
        desc = "Fold",
      },
      {
        "zC",
        function()
          vscode.action("editor.foldRecursively")
        end,
        desc = "Fold recursively",
      },
      {
        "zM",
        function()
          vscode.action("editor.foldAll")
        end,
        desc = "Fold all",
      },
      {
        "zo",
        function()
          vscode.action("editor.unfold")
        end,
        desc = "Unfold",
      },
      {
        "zO",
        function()
          vscode.action("editor.unfoldRecursively")
        end,
        desc = "Unfold recursively",
      },
      {
        "zR",
        function()
          vscode.action("editor.unfoldAll")
        end,
        desc = "Unfold all",
      },
    }

    -- ============================================================================
    -- TERMINAL
    -- ============================================================================
    wk.add {
      {
        "<leader>vo",
        function()
          vscode.action("terminal.focus")
        end,
        desc = "Focus terminal",
      },
      {
        "<leader>vg",
        function()
          vscode.action("workbench.action.terminal.sendSequence", {
            args = {
              text = "clear; go run '${file}'",
            },
          })
          vscode.action("terminal.focus")
        end,
        desc = "Run Go file",
      },
    }

    -- ============================================================================
    -- FUZZY FINDER (Telescope-like)
    -- ============================================================================
    wk.add {
      { "<leader>f", group = "Find" },
      {
        "<leader>ff",
        function()
          vscode.action("workbench.action.quickOpen")
        end,
        desc = "Find file",
      },
      {
        "<leader>ft",
        function()
          vscode.action("workbench.action.findInFiles")
        end,
        desc = "Find text in files",
      },
      {
        "<leader>fT",
        function()
          vscode.action("workbench.action.showAllEditors")
        end,
        desc = "Find tab",
      },
    }
  end,
}
