return {
  "folke/which-key.nvim",
  priority = 999,
  config = function()
    local wk = require("which-key")
    local vscode = require("vscode")

    wk.setup {}
    --
    wk.add {
      { "<leader>+", "<C-a>", desc = "Increment number" },
      { "<leader>-", "<C-x>", desc = "Decrement number" },
      { "x", '"_x', desc = "Not save in clipboard" },
      {
        "<leader>nh",
        function()
          vim.cmd("nohlsearch")
          vscode.action("workbench.files.action.refreshFilesExplorer")
        end,
        desc = "Clear highlights",
      },
    }

    -- Splitting windows
    wk.add {
      { "<leader>s", group = "Split Window" },
      { "<leader>se", "<C-w>=", desc = "Make split window equal width" },
      { "<leader>sh", "<C-w>s", desc = "Split window horizontally" },
      { "<leader>sq", ":close<CR>", desc = "Close current split window" },
      { "<leader>sv", "<C-w>v", desc = "Split window vertically" },
    }

    -- Navigation
    wk.add {
      {
        "H",
        function()
          vscode.action("workbench.action.previousEditorInGroup")
        end,
        desc = "Go to previous tab",
      },
      {
        "L",
        function()
          vscode.action("workbench.action.nextEditorInGroup")
        end,
        desc = "Go to next tab",
      },
      -- Problems
      {
        "[d",
        function()
          vscode.action("editor.action.marker.next")
        end,
        desc = "Go to next problem",
      },
      {
        "]d",
        function()
          vscode.action("editor.action.marker.prev")
        end,
        desc = "Go to previous probem",
      },
      {
        "<leader>d",
        function()
          vscode.action("workbench.actions.view.problems")
        end,
        desc = "Go to next tab",
      },
      -- Changes
      {
        "[c",
        function()
          vscode.action("workbench.action.editor.previousChange")
        end,
        desc = "Go to previouschange",
      },
      {
        "]c",
        function()
          vscode.action("workbench.action.editor.nextChange")
        end,
        desc = "Go to next change",
      },
    }
    -- Arc
    wk.add {
      {
        "<leader>hp",
        function()
          vscode.action("editor.action.dirtydiff.next")
        end,
        desc = "Arcadia: Stage change",
      },
      {
        "<leader>hd",
        function()
          vscode.action("arc.openChangeWithHead")
        end,
        desc = "Arcadia: Stage change",
      },
      {
        "<leader>hs",
        function()
          vscode.action("arc.stageChange", {
            range = { vim.fn.line(".") - 1, vim.fn.line(".") - 1 },
          })
        end,
        desc = "Arcadia: Stage change",
      },
      {
        "<leader>hS",
        function()
          vscode.action("arc.stage", {
            range = { vim.fn.line(".") - 1, vim.fn.line(".") - 1 },
          })
        end,
        desc = "Arcadia: Stage File",
      },
      {
        "<leader>hu",
        function()
          vscode.action("arc.unstage")
        end,
        desc = "Arcadia: Unstage change",
      },
      {
        "<leader>hU",
        function()
          vscode.action("arc.unstageAll")
        end,
        desc = "Arcadia: Unstage All",
      },
      {
        "<leader>hr",
        function()
          vscode.action("arc.revertChange")
          -- vscode.action("git.revertSelectedRanges")
        end,
        desc = "Arcadia: Revert change",
      },
      {
        "<leader>hR",
        function()
          vscode.action("arc.revertAll")
        end,
        desc = "Arcadia: Revert file",
      },
      {
        "<leader>hb",
        function()
          vscode.action("arc.blame.toggleCurrentLineDecorations")
        end,
        desc = "Arcadia: Blame Line",
      },
    }

    -- LSP
    wk.add {
      {
        "<C-k>",
        function()
          vscode.action("editor.action.showHover")
        end,
        desc = "Show hower",
      },
      {
        "ff",
        function()
          vscode.action("editor.action.formatDocument")
        end,
        desc = "Format file",
      },
      {
        "<leader>ca",
        function()
          vscode.action("editor.action.codeAction")
        end,
        desc = "Code actions",
      },
      {
        "<leader>rn",
        function()
          vscode.action("editor.action.rename")
        end,
        desc = "Rename",
      },
    }

    -- Folding
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

    -- Terminal
    wk.add {
      {
        "<leader>vo",
        function()
          vscode.action("terminal.focus")
        end,
        desc = "Terminal focus",
      },
    }

    -- Aka telescope
    wk.add {
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
        desc = "Find text in file Focus",
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
