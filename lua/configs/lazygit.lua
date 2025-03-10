vim.g.lazygit_on_exit_callback = function()
    require("nvim-tree.api").tree.reload()
    require("neo-tree.command").execute "refresh"
end

return {
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
}
