require("hexide.pluginConfig.lazyPackageManager")

local tableUtils = require("hexide.utils.table")
local completionPlugins = require("hexide.pluginConfig.completion")
local telescopePlugins = require("hexide.pluginConfig.telescope")
local treesitterPlugins = require("hexide.pluginConfig.treesitter")
local gitPlugins = require("hexide.pluginConfig.git")
local tabPlugins = require("hexide.pluginConfig.barbar")
local neoTreePlugins = require("hexide.pluginConfig.neoTree")
local lspConfigPlugins = require("hexide.pluginConfig.lspConfig")
local legendaryPlugins = require("hexide.pluginConfig.legendaryPlugins")
local motionPlugins = require("hexide.pluginConfig.motion")
local searchPlugins = require("hexide.pluginConfig.search")

local commonPlugins = {
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"vim-scripts/ReplaceWithRegister",
}

local colorSchemes = {
	{
		"joshdick/onedark.vim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
}

local airLinePlugins = {
	{
		"vim-airline/vim-airline",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
}

local internalPlugins = tableUtils.spreadTables(
	commonPlugins,
	legendaryPlugins,
	colorSchemes,
	tabPlugins,
	treesitterPlugins,
	lspConfigPlugins,
	airLinePlugins,
	telescopePlugins,
	completionPlugins,
	neoTreePlugins,
	gitPlugins,
	motionPlugins,
	searchPlugins
)

local plugins = internalPlugins

local hasCustomOpts, userCustomOpts = pcall(require, "hexide.userConfig")

if hasCustomOpts then
	plugins = tableUtils.spreadTables(plugins, userCustomOpts.plugins)
end

local opts = {}

require("lazy").setup(plugins, opts)
