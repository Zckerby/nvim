--==================================================================================================
-- THEMES  (themery.nvim theme switcher + colorscheme plugins)
--==================================================================================================

vim.pack.add({
	"https://github.com/zaldih/themery.nvim",
	"https://github.com/wtfox/jellybeans.nvim",
	"https://github.com/olimorris/onedarkpro.nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	{ src = "https://github.com/navarasu/onedark.nvim", version = "v0.1.0" },
	"https://github.com/shaunsingh/nord.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/devbydaniel/houston.nvim",
	"https://github.com/LunarVim/templeos.nvim",
	"https://github.com/Shadorain/shadotheme",
	"https://github.com/scottmckendry/cyberdream.nvim",
})

require("themery").setup({
	themes = {
		{ name = "Jellybean Light", colorscheme = "jellybeans-light" },
		{ name = "Jellybean Dark", colorscheme = "jellybeans-muted" },
		{ name = "Jellybean Mid Light", colorscheme = "jellybeans-mono-light" },
		{ name = "Vim Trip", colorscheme = "vim" },
		{ name = "Jellybeans Dark Mono", colorscheme = "jellybeans-muted" },
		{ name = "Very Dark", colorscheme = "onedark_dark" },
		{ name = "Light One", colorscheme = "onelight" },
		{ name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
		{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
		{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
		{ name = "onedark dark", colorscheme = "onedark_dark" },
		{ name = "nord", colorscheme = "nord" },
		{ name = "rose pine light", colorscheme = "rose-pine-dawn" },
		{ name = "rose pine sunset", colorscheme = "rose-pine-moon" },
		{ name = "houston", colorscheme = "houston" },
		{ name = "purplePink", colorscheme = "shado" },
		{ name = "temple", colorscheme = "templeos" },
		{ name = "Cyberdream", colorscheme = "cyberdream", before = [[require("cyberdream").setup({ transparent = false })]] },
		{ name = "Cyberdream Light", colorscheme = "cyberdream-light", before = [[require("cyberdream").setup({ transparent = false })]] },
		{ name = "Cyberdream Muted", colorscheme = "cyberdream-muted", before = [[require("cyberdream").setup({ transparent = false })]] },
		{ name = "Cyberdream Transparent", colorscheme = "cyberdream", before = [[require("cyberdream").setup({ transparent = true })]] },
		{ name = "Cyberdream Light Transparent", colorscheme = "cyberdream-light", before = [[require("cyberdream").setup({ transparent = true })]] },
		{ name = "Cyberdream Muted Transparent", colorscheme = "cyberdream-muted", before = [[require("cyberdream").setup({ transparent = true })]] },
	},
	livePreview = true,
})
