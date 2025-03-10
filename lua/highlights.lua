vim.api.nvim_set_hl(0, "@tag.tsx", { link = "Type" })
vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { link = "Constant" })
vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@variable", { link = "Type" })
vim.api.nvim_set_hl(0, "@variable.tsx", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@variable.member.tsx", { link = "Type" })

vim.api.nvim_set_hl(0, "@include.typescript", { link = "@keyword.typescript" })
vim.api.nvim_set_hl(0, "@keyword.import.typescript", { link = "@keyword.typescript" })
vim.api.nvim_set_hl(0, "@keyword.function.typescript", { link = "@keyword.typescript" })

vim.api.nvim_set_hl(0, "@punctuation.special.typescript", { link = "@keyword.typescript" })
vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.declaration.typescript", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.typescript", { italic = true })
vim.api.nvim_set_hl(0, "@lsp.type.variable.lua", { link = "@function" })

vim.api.nvim_set_hl(0, "NeoTreeNormal", { link = "DarkerBG" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { link = "DarkerBG" })

-- vim.api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.typescript", { link = "Constant" })
