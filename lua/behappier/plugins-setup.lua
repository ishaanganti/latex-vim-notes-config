-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
    return
end


return packer.startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim") -- lua functions that many other plugins use

    use("junegunn/seoul256.vim") -- preferred colorscheme
    use ("karoliskoncevicius/sacredforest-vim") -- colorscheme option
    use("sainnhe/everforest")
    use("christoomey/vim-tmux-navigator") -- for navigation between vim splits
    use("szw/vim-maximizer") -- maximizes and restores current window

    --LATEX PLUGINS
    use("lervag/vimtex")
    vim.g.vimtex_indent_enabled = 0
    use("SirVer/ultisnips")
       
    --KEYBIND PLUGINS 
    use("tpope/vim-surround")
    use("vim-scripts/ReplaceWithRegister")

    --IMPROVE COMMENTING
    use("numToStr/Comment.nvim")

    -- FILE EXPLORER
    use("nvim-tree/nvim-tree.lua")

    -- AUTOSAVE
    use({
        "Pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                enabled = false, 
                debounce_delay = 1000
            }
        end,
    })

    -- AUTOCOMPLETION FOR CODING
    -- NEED TO REVISE ASAP
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "quangnguyen30192/cmp-nvim-ultisnips",
            config = function()
                -- optional call to setup (see customization section)
                require("cmp_nvim_ultisnips").setup{}
            end,
            -- If you want to enable filetype detection based on treesitter:
            -- requires = { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
            require("cmp").setup({
                snippet = {
                    expand = function(args)
                        vim.fn["UltiSnips#Anon"](args.body)
                    end,
                },
                sources = {
                    { name = "ultisnips" },
                    -- more sources
                },
            })
        end,
    })


    if packer_bootstrap then
        require("packer").sync()
    end
end)








