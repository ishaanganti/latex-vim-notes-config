local setup, nvimtree = pcall(require, "nvim-tree")

if not setup then
    return
end

--Recommended settings from the nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


nvimtree.setup()
