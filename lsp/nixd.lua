return {
    root_markers = { "flake.nix", ".git" },
    cmd = { "nixd" },
    -- filetypes = { "nix" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "nixfmt" },
            },
            options = {
                nixos = {
                    -- expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
                    expr = "import <nixpkgs/nixos/modules>",
                },
                home_manager = {
                    -- expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."cem@Cem-Ryzen".options',
                    -- expr = "import <home-manager/modules>",
                    expr = '(builtins.getFlake "/home/cem/.config/nix").homeConfigurations."cem@Cem-Ryzen".options',
                },
                -- nix_darwin = {
                --     expr = '(builtins.getFlake ("git+file://" + toString ./.)).darwinConfigurations."ruixi@k-on".options',
                -- },
            },
        },
    },
}
