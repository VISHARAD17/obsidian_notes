--- init.java file content



-- =============================================================================
-- init_fast.lua — Neovim 0.12 | Java 8 & 17+ | Maximum Performance
-- Uses: vim.pack (builtin), vim.lsp.config/enable (0.11+), builtin treesitter
-- No legacy syntax highlighting. No lazy.nvim. No require('lspconfig').setup()
-- =============================================================================

-- Set leader key FIRST
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── 0. PERFORMANCE: disable built-in plugins we don't need ──────────────────
local disabled_builtins = {
  "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
  "getscript", "getscriptPlugin", "vimball", "vimballPlugin",
  "2html_plugin", "matchit", "matchparen",
  "logiPat", "rrhelper", "netrw", "netrwPlugin",
  "netrwSettings", "netrwFileHandlers",
}
for _, plugin in ipairs(disabled_builtins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Disable netrw in favour of built-in :Ex or a file picker
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- ── 1. OPTIONS ───────────────────────────────────────────────────────────────
local opt = vim.opt

-- UI
opt.number         = true
opt.relativenumber = false        -- relative numbers cause full-column redraw on scroll
opt.signcolumn     = "yes:1"      -- fixed width; prevents layout shift
opt.cursorline     = true
opt.termguicolors  = true
opt.laststatus     = 3
opt.showmode       = false        -- mode shown in statusline instead
opt.pumheight      = 15           -- popup menu height
opt.pumblend       = 10           -- slight transparency
opt.scrolloff      = 8
opt.sidescrolloff  = 8

-- Performance
opt.updatetime     = 100          -- faster CursorHold / diagnostics
opt.timeoutlen     = 300
opt.redrawtime     = 1500

-- Editing
opt.expandtab      = true
opt.tabstop        = 4
opt.shiftwidth     = 4
opt.smartindent    = true
opt.wrap           = false
opt.breakindent    = true
opt.undofile       = true
opt.undolevels     = 1000

-- Cursor
opt.guicursor      = "a:blinkwait0-blinkoff0-blinkon0,n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Spell checking (disabled globally for perf; enable per-filetype if needed)
opt.spell          = false
opt.spelllang      = { "en_us" }

-- Search
opt.ignorecase     = true
opt.smartcase      = true
opt.hlsearch       = true
opt.incsearch      = true

-- Clipboard
-- Clipboard (schedule after UiEnter to avoid slowing startup)
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Splits
opt.splitbelow     = true
opt.splitright     = true

-- Completion (builtin, 0.11+)
opt.completeopt    = { "menuone", "noinsert", "noselect", "popup" }

-- Folding (manual = no computation on scroll)
opt.foldmethod     = "manual"
opt.foldlevel      = 99
opt.foldlevelstart = 99
opt.indentexpr     = ""           -- disable filetype indent overrides (e.g. GetJavaIndent)

-- ── 2. BOOTSTRAP: vim.pack (Neovim 0.12 builtin package manager) ─────────────
-- vim.pack.add() clones/updates plugins from git into the stdpath('data') pack
-- path and immediately adds them to the runtimepath.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "blink.cmp" and (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.system({ "cargo", "build", "--release" }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  -- nvim-lspconfig: provides lsp/ config files discovered by vim.lsp.config()
  -- require('lspconfig').setup() is DEPRECATED; we use vim.lsp.enable() instead
  "https://github.com/neovim/nvim-lspconfig",

  { src = "https://github.com/saghen/blink.cmp", version = "main" },

  -- Colorscheme (fast, pure Lua, treesitter-aware)
  "https://github.com/folke/tokyonight.nvim",

  -- fzf-lua - fastest fuzzy finder (uses fzf binary)
  "https://github.com/ibhagwan/fzf-lua",

  -- oil.nvim - fast file explorer (buffer-style)
  "https://github.com/stevearc/oil.nvim",

  -- icons for oil.nvim
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- incline.nvim - floating filename in top-right of each window
  "https://github.com/b0o/incline.nvim",

  -- flash.nvim - fast cursor jump
  "https://github.com/folke/flash.nvim",

  -- nvim-jdtls - handles Java LSP multi-module, workspace, Eclipse project quirks
  "https://github.com/mfussenegger/nvim-jdtls",
})

-- ── 3. COLORSCHEME ───────────────────────────────────────────────────────────
vim.cmd.colorscheme("fleet_dark")
vim.api.nvim_set_hl(0, "DiffText", { bg = "#2a4a6a", fg = "#ffffff", bold = true })

-- ── 4. TREESITTER ────────────────────────────────────────────────────────────
-- Start treesitter highlighting for filetypes with installed parsers
local ts_skip = { [""] = true, oil = true, help = true, qf = true, netrw = true, checkhealth = true }
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    if ts_skip[vim.bo[ev.buf].filetype] or vim.bo[ev.buf].buftype ~= "" then return end
    pcall(vim.treesitter.start, ev.buf)
  end,
})

-- ── 4b. TREESITTER TEXTOBJECTS (builtin, no plugin) ──────────────────────────
-- vaf = select outer function, vac = select outer class. Zero cost until used.
local function ts_select_parent(types)
  local node = vim.treesitter.get_node()
  while node do
    if types[node:type()] then
      local sr, sc, er, ec = node:range()
      vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
      vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
      vim.cmd("normal! gv")
      return
    end
    node = node:parent()
  end
end

local fn_types = {
  function_declaration = true, method_declaration = true,
  function_definition = true, function_item = true,
  arrow_function = true, method_definition = true,
}
local class_types = {
  class_declaration = true, class_definition = true,
  struct_item = true, impl_item = true, interface_declaration = true,
}

vim.keymap.set("x", "af", function() ts_select_parent(fn_types) end, { desc = "Select outer function" })
vim.keymap.set("x", "ac", function() ts_select_parent(class_types) end, { desc = "Select outer class" })
vim.keymap.set("o", "af", function() ts_select_parent(fn_types) end, { desc = "Outer function" })
vim.keymap.set("o", "ac", function() ts_select_parent(class_types) end, { desc = "Outer class" })

-- ── 5. LSP CONFIGURATION (vim.lsp.config / vim.lsp.enable — 0.11+ native) ───
--
-- nvim-lspconfig ships lsp/<server>.lua files that vim.lsp.config() auto-finds.
-- We override / extend with vim.lsp.config() and then call vim.lsp.enable().
-- Do NOT use require('lspconfig').<server>.setup{} — that API is deprecated.

-- Global LSP capabilities: enable snippet support + additional completion items
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

-- Disable expensive file-watching on large repos (big Java monorepos will choke)
if capabilities.workspace then
  capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }
end

-- Apply capabilities globally to all LSP servers
vim.lsp.config("*", { capabilities = capabilities })

-- ── 5a. Java LSP: see ~/.config/nvim/ftplugin/java.lua (via nvim-jdtls) ─────

-- ── 5b. Lua LSP (for editing this config file itself) ────────────────────────
-- Install: brew install lua-language-server  OR  npm i -g lua-language-server
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime  = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.enable("lua_ls")

-- ── 6. LSP KEYMAPS (set on LspAttach — only active when LSP is running) ──────
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then client.server_capabilities.semanticTokensProvider = nil end

    local buf  = args.buf
    vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local map  = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
    end

    -- Navigation
    map("n", "gd",         vim.lsp.buf.definition,       "Go to Definition")
    map("n", "gD",         vim.lsp.buf.declaration,      "Go to Declaration")
    map("n", "gi",         vim.lsp.buf.implementation,   "Go to Implementation")
    map("n", "gr",         vim.lsp.buf.references,       "Find References")
    map("n", "<leader>fr", function()
      require("fzf-lua").lsp_references({ winopts = { preview = { hidden = "nohidden" } } })
    end, "Find References (fzf)")
    map("n", "gt",         vim.lsp.buf.type_definition,  "Go to Type Definition")

    -- Info
    map("n", "K",          vim.lsp.buf.hover,            "Hover Documentation")

    -- Actions
    map("n", "<leader>rn", vim.lsp.buf.rename,           "Rename Symbol")
    map("n", "<leader>ca", vim.lsp.buf.code_action,      "Code Action")
    map("v", "<leader>ca", vim.lsp.buf.code_action,      "Code Action (visual)")
    map("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format Buffer")

    -- Workspace
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,    "Add Workspace Folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List Workspace Folders")

    -- Inlay hints
    map("n", "<leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle Inlay Hints")

    -- LSP control (0.12 new :lsp command)
    map("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>",  "LSP Info")
    map("n", "<leader>lr", "<cmd>lsp restart<cr>",          "LSP Restart")
  end,
})

-- ── 7. DIAGNOSTICS ───────────────────────────────────────────────────────────
-- Disable diagnostics completely
vim.diagnostic.config({
  virtual_text     = false,
  signs            = false,
  underline        = true,
  update_in_insert = false,
  severity_sort    = true,
  float = {
    focusable = false,
    style     = "minimal",
    border    = "rounded",
    source    = "always",
  },
})

-- Diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- sort diagnostics: errors first, then warnings, hints, info
local function sort_diags(diags)
  table.sort(diags, function(a, b) return a.severity < b.severity end)
  return diags
end

-- <Space>cd → current buffer diagnostics
vim.keymap.set("n", "<leader>cd", function()
  local items = vim.diagnostic.toqflist(sort_diags(vim.diagnostic.get(0)))
  vim.fn.setqflist({}, " ", { title = "Current Buffer Diagnostics", items = items })
  vim.cmd("copen")
end, { desc = "Show current buffer diagnostics in quickfix", silent = true })

-- <Space>d → diagnostics for files in current directory
vim.keymap.set("n", "<leader>d", function()
  local cwd = vim.fn.expand("%:p:h")
  local filtered = vim.tbl_filter(function(d)
    return vim.startswith(vim.api.nvim_buf_get_name(d.bufnr), cwd)
  end, vim.diagnostic.get())
  local items = vim.diagnostic.toqflist(sort_diags(filtered))
  vim.fn.setqflist({}, " ", { title = "Directory Diagnostics", items = items })
  vim.cmd("copen")
end, { desc = "Show current directory diagnostics in quickfix", silent = true })

-- <Space>D → workspace-wide diagnostics (entire git repo)
vim.keymap.set("n", "<leader>D", function()
  local items = vim.diagnostic.toqflist(sort_diags(vim.diagnostic.get()))
  vim.fn.setqflist({}, " ", { title = "Workspace Diagnostics", items = items })
  vim.cmd("copen")
end, { desc = "Show workspace diagnostics in quickfix", silent = true })

-- Navigate diagnostics inline
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show Line Diagnostic" })

-- ── 8. COMPLETION (blink.cmp) ─────────────────────────────────────────────────
local ok, blink = pcall(require, "blink.cmp")
if ok then
  blink.setup({
    keymap = {
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
        show_in_snippet = false,
      },
      menu = {
        auto_show = false,
        draw = {
          columns = { { "label", "label_description", gap = 1 }, { "kind" } },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
      },
    },
    sources = {
      default = { "lsp", "path", "buffer" },
      providers = {
        buffer = { max_items = 5 },
      },
    },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust" },
  })

  -- Set fuzzy match highlight to blue
  vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#569cd6", bold = true })
end

-- ── 9. JAVA-SPECIFIC FILETYPE SETTINGS ───────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local opt_local = vim.opt_local
    opt_local.tabstop     = 4
    opt_local.shiftwidth  = 4
    opt_local.expandtab   = true
    opt_local.textwidth   = 120
    opt_local.colorcolumn = "120"
  end,
})

-- ── 10. GENERAL KEYMAPS ───────────────────────────────────────────────────────
local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window Left"  })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down"  })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up"    })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- Resize windows
map("n", "<C-Up>",    "<cmd>resize +2<cr>")
map("n", "<C-Down>",  "<cmd>resize -2<cr>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- Buffer nav
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>",     { desc = "Next Buffer" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear Search Highlight" })

-- Stay in indent mode when indenting in visual
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==",        { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==",        { desc = "Move Line Up"   })
map("v", "<A-j>", ":m '>+1<cr>gv=gv",        { desc = "Move Block Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv",        { desc = "Move Block Up"   })

-- Quickfix navigation
map("n", "<leader>qo", "<cmd>copen<cr>",  { desc = "Open Quickfix" })
map("n", "<leader>qc", "<cmd>cclose<cr>", { desc = "Close Quickfix" })
map("n", "[q",         "<cmd>cprev<cr>",  { desc = "Prev Quickfix" })
map("n", "]q",         "<cmd>cnext<cr>",  { desc = "Next Quickfix" })

-- Save / Quit
map({ "n", "i" }, "<C-s>", "<cmd>w<cr><Esc>", { desc = "Save" })
map("n",          "<leader>q", "<cmd>q<cr>",  { desc = "Quit" })

-- Tab operations
map("n", "<leader>tn", "<cmd>tabe<cr>",  { desc = "New Tab" })
map("n", "<leader>tc", "<cmd>tabc<cr>",  { desc = "Close Tab" })
map("n", "<leader>t]", "<cmd>tabn<cr>",  { desc = "Next Tab" })
map("n", "<leader>t[", "<cmd>tabp<cr>",  { desc = "Prev Tab" })

-- ── FZF-LUA ──────────────────────────────────────────────────────────────────
local fzf_ok, fzf = pcall(require, "fzf-lua")
if fzf_ok then
  fzf.setup({
    "default",
    winopts = { preview = { hidden = "hidden" } },
    files = {
      fd_opts = "--type f --hidden --follow --exclude .git -E '*.class' -E bin",
      rg_opts = "--files --hidden --follow -g '!*.class' -g '!bin/'",
    },
    grep = {
      rg_opts = "--column --line-number --no-heading --color=always --smart-case -g '!*.class' -g '!bin/'",
    },
    keymap = {
      fzf = {
        ["ctrl-j"] = "down",
        ["ctrl-k"] = "up",
      },
    },
  })

  map("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document Symbols" })
  map("n", "<leader>fg", function()
    fzf.git_status({ winopts = { preview = { hidden = "nohidden" } } })
  end, { desc = "Git Status" })
  map("n", "<leader>fd", function()
    fzf.diagnostics_document({ winopts = { preview = { hidden = "nohidden" } } })
  end, { desc = "Document Diagnostics" })
  map("n", "<leader>fD", fzf.diagnostics_workspace, { desc = "Workspace Diagnostics" })
  map("n", "<leader>ff", fzf.files,       { desc = "Find Files" })
  map("n", "<leader>c",  function() fzf.files({ cwd = vim.fn.expand("%:p:h") }) end, { desc = "Find Files (current dir)" })
  map("n", "<leader>b",  fzf.buffers,     { desc = "Find Buffers" })
  map("n", "<leader>g",  function()
    fzf.live_grep({ winopts = { preview = { hidden = "nohidden" } } })
  end, { desc = "Live Grep" })
end

-- ── OIL.NVIM ─────────────────────────────────────────────────────────────────
local oil_ok, oil = pcall(require, "oil")
if oil_ok then
  oil.setup({
    default_file_explorer = true,
    float = {
      padding = 2,
      border = "rounded",
      max_width = 60,
      max_height = 30,
    },
    columns = { "icon", "size" },
    view_options = {
      show_hidden = true,
    },
  })
  map("n", "<leader>e", function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].filetype == "oil" then
      oil.close()
    else
      oil.open_float()
    end
  end, { desc = "Toggle File Explorer" })
  map("n", "<leader>E", function()
    oil.open_float(vim.fn.expand("%:p:h"))
  end, { desc = "Open Current Dir in Explorer" })
end

-- ── INCLINE.NVIM ─────────────────────────────────────────────────────────────
local incline_ok, incline = pcall(require, "incline")
if incline_ok then
  incline.setup({
    render = function(props)
      return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    end,
    window = { placement = { horizontal = "right", vertical = "top" } },
  })
end

-- ── FLASH.NVIM ───────────────────────────────────────────────────────────────
local flash_ok, flash = pcall(require, "flash")
if flash_ok then
  flash.setup({
    modes = { char = { enabled = false }, search = { enabled = false } },
  })
  map("n", "s", function() flash.jump() end, { desc = "Flash Jump" })
end

-- ── 11. STATUSLINE (minimal, no plugin needed) ───────────────────────────────
-- Cache git branch (fetched once on startup — no repeated shell calls)
local _git_branch_cache = ""
vim.system({"git", "branch", "--show-current"}, { text = true }, function(obj)
  _git_branch_cache = (obj.stdout or ""):gsub("%s+$", "")
end)

-- Cache diagnostics (avoid calling vim.diagnostic.get on every statusline redraw)
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    vim.cmd.redrawstatus()
  end,
})

_G.statusline = function()
  local mode_map = {
    n  = { label = "NORMAL",  hl = "%#StatusLineNormal#"  },
    i  = { label = "INSERT",  hl = "%#StatusLineInsert#"  },
    v  = { label = "VISUAL",  hl = "%#StatusLineVisual#"  },
    V  = { label = "V-LINE",  hl = "%#StatusLineVisual#"  },
    ["\22"] = { label = "V-BLOCK", hl = "%#StatusLineVisual#" },
    c  = { label = "COMMAND", hl = "%#StatusLineCommand#" },
    R  = { label = "REPLACE", hl = "%#StatusLineReplace#" },
    t  = { label = "TERMINAL",hl = "%#StatusLineInsert#"  },
  }
  local mode_code = vim.api.nvim_get_mode().mode:sub(1, 1)
  local mode = mode_map[mode_code] or { label = mode_code, hl = "%#StatusLine#" }
  local diff = vim.opt.diff:get() and " %#DiffText# DIFF %#StatusLine#" or ""
  local branch = _git_branch_cache ~= "" and (" " .. _git_branch_cache) or ""
  local modified = vim.bo.modified and " ●" or ""
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local diag = errors > 0 and ("%#DiagnosticError# ●%#StatusLine# (" .. errors .. ")") or ""
  return table.concat({
    mode.hl .. " " .. mode.label .. " %#StatusLine#" .. diff,
    "%<%f",
    "%r" .. modified .. diag,
    "%=",
    branch,
  }, "  ")
end

-- Mode highlight colors
vim.api.nvim_set_hl(0, "StatusLineNormal",  { fg = "#000000", bg = "#7aa2f7", bold = true })
vim.api.nvim_set_hl(0, "StatusLineInsert",  { fg = "#000000", bg = "#9ece6a", bold = true })
vim.api.nvim_set_hl(0, "StatusLineVisual",  { fg = "#000000", bg = "#bb9af7", bold = true })
vim.api.nvim_set_hl(0, "StatusLineCommand", { fg = "#000000", bg = "#e0af68", bold = true })

opt.statusline = "%!v:lua.statusline()"

-- ── 12. AUTO-UPDATE PARSERS ON CONFIG RELOAD ─────────────────────────────────
-- Run :TSUpdate manually after first install, or uncomment the line below
-- to auto-update every time you open Neovim (slow on first run):


-- ── DONE ──────────────────────────────────────────────────────────────────────
-- First run checklist:
--   1. :checkhealth vim.lsp      — verify jdtls is found & configured
--   2. :checkhealth nvim         — check treesitter parsers
--   3. Open a Java file          — parsers auto-install, jdtls attaches
--   4. <Space>d                  — diagnostics → quickfix list
--   5. gd / gr / K / <leader>ca — LSP navigation & actions
--   6. :lsp restart              — restart jdtls if stuck
-- =============================================================================

-- ── CUSTOM: :VLspStatus — show LSP progress ─────────────────────────────────
vim.api.nvim_create_user_command('VLspStatus', function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print('No LSP attached')
    return
  end
  for _, c in ipairs(clients) do
    local active = {}
    for _, val in pairs(c.progress) do
      if type(val) == 'table' and val.kind == 'begin' or (type(val) == 'table' and val.kind == 'report' and val.percentage) then
        local pct = val.percentage and (val.percentage .. '%') or ''
        local msg = val.message or ''
        local title = val.title or ''
        if title ~= '' or pct ~= '' then
          table.insert(active, vim.trim(title .. ' ' .. pct .. ' ' .. msg))
        end
      end
    end
    if #active == 0 then
      print(('[%s] ✓ ready'):format(c.name))
    else
      print(('[%s] %s'):format(c.name, table.concat(active, ' | ')))
    end
  end
end, {})


-- /ftplugin/java.lua

local JAVA8_HOME = "/Users/visharadborsutkar/Library/Java/JavaVirtualMachines/corretto-1.8.0_472/Contents/Home"
local JAVA21_HOME = "/Users/visharadborsutkar/Library/Java/JavaVirtualMachines/corretto-21.0.9/Contents/Home"

local LOMBOK_JAR = "/Users/visharadborsutkar/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.44/503fd0b002dbb237fa4656cf4b8021666a8aebac/lombok-1.18.44.jar"

local root_dir = vim.fs.root(0, { "settings.gradle", "settings.gradle.kts", "mvnw", "gradlew" })
  or vim.fs.root(0, { "pom.xml", "build.gradle", "build.gradle.kts" })
if not root_dir then return end

-- Detect Java 8 projects
local java8 = false
local bf = root_dir .. "/build.gradle"
if vim.fn.filereadable(bf) == 1 then
  local content = table.concat(vim.fn.readfile(bf), "\n")
  java8 = content:match("VERSION_1_8") or content:match("sourceCompatibility.*1%.8") or false
end

local project_name = vim.fs.basename(root_dir)
vim.env.JAVA_HOME = JAVA21_HOME

require("jdtls").start_or_attach({
  cmd = {
    "jdtls",
    "--jvm-arg=-javaagent:" .. LOMBOK_JAR,
    "-data", vim.fn.stdpath("cache") .. "/jdtls/workspaces/" .. project_name,
  },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          { name = "JavaSE-1.8", path = JAVA8_HOME },
          { name = "JavaSE-21", path = JAVA21_HOME },
        },
      },
      import = {
        gradle = {
          java = { home = java8 and JAVA8_HOME or JAVA21_HOME },
        },
      },
    },
  },
})




--- 