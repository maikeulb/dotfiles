-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/michaelbarnes/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/michaelbarnes/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/michaelbarnes/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/michaelbarnes/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/michaelbarnes/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  FastFold = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/FastFold",
    url = "https://github.com/Konfekt/FastFold"
  },
  SimpylFold = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/SimpylFold",
    url = "https://github.com/tmhedberg/SimpylFold"
  },
  ale = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/ale",
    url = "https://github.com/w0rp/ale"
  },
  ["any-jump.vim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/any-jump.vim",
    url = "https://github.com/pechorin/any-jump.vim"
  },
  ["braceless.vim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/braceless.vim",
    url = "https://github.com/tweekmonster/braceless.vim"
  },
  ["clever-f.vim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/clever-f.vim",
    url = "https://github.com/rhysd/clever-f.vim"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/completion-nvim",
    url = "https://github.com/nvim-lua/completion-nvim"
  },
  delimitMate = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/delimitMate",
    url = "https://github.com/Raimondi/delimitMate"
  },
  dracula = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/dracula",
    url = "https://github.com/dracula/vim"
  },
  fzf = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["goyo.vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/nvim-lspinstall",
    url = "https://github.com/anott03/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["quick-scope"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/quick-scope",
    url = "https://github.com/unblevable/quick-scope"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-airline",
    url = "https://github.com/vim-airline/vim-airline"
  },
  ["vim-argumentative"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-argumentative",
    url = "https://github.com/PeterRincker/vim-argumentative"
  },
  ["vim-autoformat"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-autoformat",
    url = "https://github.com/Chiel92/vim-autoformat"
  },
  ["vim-codefmt"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-codefmt",
    url = "https://github.com/google/vim-codefmt"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-cool"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-cool",
    url = "https://github.com/romainl/vim-cool"
  },
  ["vim-csharp"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-csharp",
    url = "https://github.com/OrangeT/vim-csharp"
  },
  ["vim-diminactive"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-diminactive",
    url = "https://github.com/blueyed/vim-diminactive"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-dirvish",
    url = "https://github.com/justinmk/vim-dirvish"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim",
    url = "https://github.com/radenling/vim-dispatch-neovim"
  },
  ["vim-easyclip"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-easyclip",
    url = "https://github.com/svermeulen/vim-easyclip"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-glaive"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-glaive",
    url = "https://github.com/google/vim-glaive"
  },
  ["vim-grepper"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-grepper",
    url = "https://github.com/mhinz/vim-grepper"
  },
  ["vim-gutentags"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-gutentags",
    url = "https://github.com/ludovicchabant/vim-gutentags"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-indent-object",
    url = "https://github.com/michaeljsmith/vim-indent-object"
  },
  ["vim-maktaba"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-maktaba",
    url = "https://github.com/google/vim-maktaba"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-maximizer"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-maximizer",
    url = "https://github.com/szw/vim-maximizer"
  },
  ["vim-pencil"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-pencil",
    url = "https://github.com/reedes/vim-pencil"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-qf",
    url = "https://github.com/romainl/vim-qf"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-rsi",
    url = "https://github.com/tpope/vim-rsi"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tmux"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-tmux",
    url = "https://github.com/tmux-plugins/vim-tmux"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-virtualenv"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-virtualenv",
    url = "https://github.com/jmcantrell/vim-virtualenv"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/start/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  },
  ["vim-yaml"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-yaml",
    url = "https://github.com/avakhov/vim-yaml"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType charp ++once lua require("packer.load")({'vim-csharp'}, { ft = "charp" }, _G.packer_plugins)]]
vim.cmd [[au FileType py ++once lua require("packer.load")({'vim-virtualenv', 'SimpylFold'}, { ft = "py" }, _G.packer_plugins)]]
vim.cmd [[au FileType yaml ++once lua require("packer.load")({'vim-yaml'}, { ft = "yaml" }, _G.packer_plugins)]]
vim.cmd [[au FileType tmux ++once lua require("packer.load")({'vim-tmux'}, { ft = "tmux" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-pencil', 'goyo.vim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-tmux/ftdetect/tmux.vim]], true)
vim.cmd [[source /Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-tmux/ftdetect/tmux.vim]]
time([[Sourcing ftdetect script at: /Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-tmux/ftdetect/tmux.vim]], false)
time([[Sourcing ftdetect script at: /Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-csharp/ftdetect/cs.vim]], true)
vim.cmd [[source /Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-csharp/ftdetect/cs.vim]]
time([[Sourcing ftdetect script at: /Users/michaelbarnes/.local/share/nvim/site/pack/packer/opt/vim-csharp/ftdetect/cs.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
