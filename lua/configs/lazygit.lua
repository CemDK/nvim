vim.g.lazygit_on_exit_callback = function()
    require("neo-tree.sources.filesystem.commands").refresh(require("neo-tree.sources.manager").get_state "filesystem")
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
