-- https://gist.github.com/aghriss/90206887fef301febe6d644272bba367
local S = {}

-- define the files for each language
-- new words will be added to the last file in the language table
S.dictionaries = {
  ["en-US"] = {
    words = {
      vim.fn.stdpath("config") .. "/.ltex/words/en.txt",
    },
    ruleIds = {
      vim.fn.stdpath("config") .. "/.ltex/ruleIds/en.txt",
    },
    falsePositives = {
      vim.fn.stdpath("config") .. "/.ltex/falsePositives/en.txt",
    }
  },
}
S.mapping = {
  words = "dictionary",
  ruleIds = "disabledRules",
  falsePositives = "hideFalsePositives",
}

-- function to avoid interacting with the table directly
function S.getDictFiles(key, lang)
  local files = S.dictionaries[lang][key]
  if files then
    return files
  else
    return nil
  end
end

-- combine words from all the files. Each line should contain one word
function S.readDictFiles(key, lang)
  local files = S.getDictFiles(key, lang)
  local dict = {}
  if files then
    for _, file in ipairs(files) do
      local f = io.open(file, "r")
      if f then
        for l in f:lines() do
          table.insert(dict, l)
        end
      else
        print("Can not read dict file %q", file)
      end
    end
  else
    print("Lang %q has no files", lang)
  end
  return dict
end

-- Append words to the last element of the language files
function S.addWordsToFiles(key, lang, words)
  local files = S.getDictFiles(key, lang)
  if not files then
    return print("no dictionary file defined for lang %q", lang)
  else
    local file = io.open(files[#files - 0], "a+")
    if file then
      for _, word in ipairs(words) do
        file:write(word .. "\n")
      end
      file:close()
    else
      return print("Failed insert %q", vim.inspect(words))
    end
  end
end

-- The following part is a classic lspconfig config section
local lspconfig = require("lspconfig")
-- notifying wkspc will refresh the settings that contain the dictionary
local wkspc = "workspace/didChangeConfiguration"
-- instead of looping through the list of clients and check client.name == 'ltex' (which many solutions out there are doing)
-- We attach the command function to the bufer then ltex is loaded
local function on_attach(client, bufnr)
  require("navigator.lspclient.mapping").setup({ client = client, bufnr = bufnr }) -- setup navigator keymaps here,
  require("navigator.dochighlight").documentHighlight(bufnr)
  require("navigator.codeAction").code_action_prompt(bufnr)
  -- the second argumeng is named 'ctx', but we don't need it here
  --- command = {argument={...}, command=..., title=...}
  local addToDict = function(key)
    local wrapper = function(command, _)
      for _, arg in ipairs(command.arguments) do
        -- not the most efficent way, we could readDictFiles once per lang
        for lang, words in pairs(arg[key]) do
          S.addWordsToFiles(key, lang, words)
          local settings = S.mapping[key]
          client.config.settings.ltex[settings] = {
            [lang] = S.readDictFiles(key, lang),
          }
        end
      end
      -- notify the client of the new settings
      return client.notify(wkspc, client.config.settings)
    end
    return wrapper
  end
  -- add the function to handle the command
  -- then lsp.commands does not find the handler, it will look at opts.handler["workspace/executeCommand"]
  vim.lsp.commands["_ltex.addToDictionary"] = addToDict("words")
  vim.lsp.commands["_ltex.disableRules"] = addToDict("ruleIds")
  vim.lsp.commands["_ltex.hideFalsePositives"] = addToDict("falsePositives")
end
-- 'pluging.config.lspconfig' is from NvChad configuraion
lspconfig.ltex.setup({
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  filetypes = { "tex", "markdown", "py" },
  additionalRules = {
    enablePickyRules = true,
  },
  settings = {
    ltex = {
      completionEnabled = true,
      dictionary = {
        ["en-US"] = S.readDictFiles("words", "en-US"),
      },
      disabledRules = {
        ["en-US"] = S.readDictFiles("ruleIds", "en-US"),
      },
      hiddenFalsePositives = {
        ["en-US"] = S.readDictFiles("falsePositives", "en-US"),
      },
    },
  },
})
