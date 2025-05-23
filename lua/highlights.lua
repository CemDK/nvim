-- general
vim.api.nvim_set_hl(0, "@variable", { link = "Type" })

-- typescript tsx
vim.api.nvim_set_hl(0, "@tag.tsx", { link = "Type" })
vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { link = "Constant" })
vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@variable.tsx", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@variable.member.tsx", { link = "Type" })
vim.api.nvim_set_hl(0, "@include.typescript", { link = "@keyword.typescript" })
vim.api.nvim_set_hl(0, "@keyword.exception", { link = "@keyword.typescript" })
vim.api.nvim_set_hl(0, "@keyword.import.typescript", { link = "@keyword.typescript" })
vim.api.nvim_set_hl(0, "@keyword.function.typescript", { link = "@keyword.typescript" })
vim.api.nvim_set_hl(0, "@punctuation.special.typescript", { link = "@keyword.typescript" })
vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.declaration.typescript", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.typescript", { italic = true })
-- vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.typescriptreact", { link = "Constant" })
vim.api.nvim_set_hl(0, "@lsp.variable.typescript", { link = "Variable" })
vim.api.nvim_set_hl(0, "@variable.typescript", { link = "Variable" })
vim.api.nvim_set_hl(0, "@type.builtin.tsx", { link = "Type" })
vim.api.nvim_set_hl(0, "@lsp.mod.local.typescript", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.typescript", { link = "Variable" })

-- css
vim.api.nvim_set_hl(0, "@variable.css", { link = "@variable.member" })

-- lua
vim.api.nvim_set_hl(0, "@variable.lua", { link = "Type" })
vim.api.nvim_set_hl(0, "@function.builtin.lua", { link = "Special" })

-- NeoTree
vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "DarkerBG" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "DarkerBG" })
