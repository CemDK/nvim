**My NVIM config**

## Dependencies

<details>
<summary>This Neovim configuration requires several external dependencies to be installed on your system for full functionality.</summary>

### Build Dependencies

#### Make Build System

- **make** - Required for compiling native extensions for:
  - telescope-fzf-native.nvim
  - avante.nvim
  - LuaSnip (regex support in snippets)

### Git Tools

- **git** - No explanation needed :)
- **lazygit** - Terminal UI for git

### Language Servers & Tools

The configuration uses Mason to automatically install some language servers, but requires these system runtimes:

#### Required Runtimes

- **Node.js/npm** - For JavaScript/TypeScript ecosystem tools
- **Lua/LuaJIT** - For Lua development

#### Language-Specific Tools

- **Tree-sitter** - For syntax highlighting and parsing
- **nixd** - Nix language server (if using Nix)
- **nixfmt** - Nix formatter (if using Nix)

### Search & Navigation Tools

- **fzf** - Fuzzy finder for telescope and fzf-lua
- **ripgrep (rg)** - Fast text search (recommended for Telescope)
- **fd** - Fast file finder (recommended for Telescope)

### Installation Notes

1. **Mason Integration**: Language servers, formatters, and linters listed in `lua/configs/mason-tool-installer.lua` are automatically managed by Mason, but require the underlying runtimes to be installed.

2. **Platform Support**: Most tools support Linux/macOS/Windows. Windows users may need additional setup for make-based builds or use nvim inside WSL.

3. **Optional Dependencies**: Some plugins like vim-wakatime (requires wakatime-cli) are conditionally enabled.

</details>

## TODO

- [ ] add numToStr/Comment.nvim (comments in .tsx files are sometimes messed up, use this instead?)
- [x] fix menu-neo-tree.lua (right-click menu etc., although I don't use the mouse btw.)
- [ ] make everything/mason work on nixOS, don't want to migrate config to nixvim
- [ ] add better user experience for new installs (make sure dependencies are installed, hint which need to be installed fzf, etc.
- [ ] run commands that need to be ran (e.g. copilot auth, etc.)
- [ ] refactor lsp stuff

## Credits

1) NvChad starter <https://github.com/NvChad/starter> my config is based on nvchad's starter. It made a lot of things easier!
2) Lazyvim starter <https://github.com/LazyVim/starter> as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
