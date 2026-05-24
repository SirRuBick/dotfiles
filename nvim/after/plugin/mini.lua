-- mini.nvim configuration

-- mini.statusline
local ok_status, mini_statusline = pcall(require, "mini.statusline")
if ok_status then
	mini_statusline.setup({
		content = {
			active = function()
				local mode, mode_hl = mini_statusline.section_mode({ trunc_width = 120 })
				local git = mini_statusline.section_git({ trunc_width = 75 })
				local diagnostics = mini_statusline.section_diagnostics({ trunc_width = 75 })
				local filename = mini_statusline.section_filename({ trunc_width = 140 })
				local fileinfo = mini_statusline.section_fileinfo({ trunc_width = 120 })
				local location = mini_statusline.section_location({ trunc_width = 75 })
				local search = mini_statusline.section_searchcount({ trunc_width = 75 })

				return mini_statusline.combine_groups({
					{ hl = mode_hl, strings = { mode } },
					{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
					"%<",
					{ hl = "MiniStatuslineFilename", strings = { filename } },
					"%=",
					{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
					{ hl = mode_hl, strings = { search, location } },
				})
			end,
		},
		use_icons = true,
	})

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bold = true, bg = "#45475a", fg = "#cdd6f4" })
			vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { bg = "#45475a", fg = "#89b4fa" })
			vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { bg = "#45475a", fg = "#a6e3a1" })
		end,
	})
end

-- mini.starter (start screen)
local ok_starter, mini_starter = pcall(require, "mini.starter")
if ok_starter then
	mini_starter.setup({
		-- 		header = [[
		-- ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⣄⣠⠤⠴⠞⠓⠶⠤⣶⣶⣶⡄⠀⠀⠀⠀                                                      ALEXSHAN
		-- ⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⡟⠀⠀⠀⠀       ████ ██████           █████      ██
		-- ⠀⠀⠀⠀⠀⠀⠀⠀⡻⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⠀⠀⠀⠀      ███████████             █████ 
		-- ⠀⠀⢠⣾⣿⣶⡤⢴⠁⠀⠀⣠⣴⣶⣦⣄⠀⠀⠀⢠⣾⣿⣿⡄⠀⠀⠀      █████████ ███████████████████ ███   ███████████
		-- ⠀⠀⠘⣿⠋⠁⠀⣿⠀⠀⢸⣿⣿⣟⣻⣿⠇⠀⠀⠘⢿⣯⣽⣿⣆⠀⠀     █████████  ███    █████████████ █████ ██████████████
		-- ⠀⠀⢰⠃⠀⠀⠀⢹⠀⠀⠀⠻⠿⠿⠿⠋⠀⠀⠻⠛⠀⠉⠉⠁⣸⠀⠀    █████████ ██████████ █████████ █████ █████ ████ █████
		-- ⣤⣶⣼⡀⠀⠀⠀⣼⣿⣷⣶⣤⣤⣤⣤⡀⠀⠀⠀⠀⠀⠀⣀⣴⣧⡀⠀  ███████████ ███    ███ █████████ █████ █████ ████ █████
		-- ⠻⠿⠿⠷⠤⠤⠤⠿⠿⠿⠿⠿⠿⠿⠿⣇⠤⠤⠤⠴⠶⠿⠿⠿⠿⠁⠀ ██████  █████████████████████ ████ █████ █████ ████ ██████
		-- ]],
		header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⢿⠉⠉⠉⠹⢶⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠋⠀⠘⡀⠀⠀⡄⠀⠈⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⢇⣀⣰⠃⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣋⡀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠛⡆⠀⠀⡔⠉⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⣧⠤⣀⣀⣀⣀⣀⡤⣼⢿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⣶⡇⢀⢾⣖⣶⠃⠀⣠⢤⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⡀⠉⠉⠁⠀⠀⠉⠉⢀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⣤⣇⣼⢤⣍⡏⣠⣾⣅⡼⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⠹⣦⠀⠀⠀⠀⠀⣠⠏⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣭⣭⣿⣌⣉⣿⣾⣤⣹⠟⠀⣀⡀⣀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣨⡆⣻⣷⠤⠤⠤⣼⣿⣼⣿⣷⡶⢶⣤⡀⠀⠀⠀⠀⢠⢶⠲⣄⢠⠃⠙⡍⢀⡙⡉⢻⣬⣽⣥⡖⢿⣷⡤⠊
⠀⠀⠀⠀⣀⠤⠖⢒⣶⣫⣾⣿⣷⠐⢒⣉⣓⣳⣾⠿⣉⣠⠗⠛⣩⠿⠓⠈⠉⠉⠚⢦⣴⣫⢛⣦⣵⠎⠁⠈⠑⡄⠀⢧⣘⠿⠚⠁⠀⠀
⠀⣠⣴⠞⠁⣠⠖⠉⠈⠻⣿⣚⡾⠿⠋⠉⠀⠀⠈⠙⠾⣀⣠⣊⢀⣠⣤⣤⣤⣄⣀⡸⢧⣴⠾⠃⠸⡀⠀⠀⢀⠇⡀⢈⡇⠀⠀⠀⠀⠀
⢰⢁⣼⠆⠀⠀⠀⠀⠀⣟⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣭⡿⠉⡰⠁⣼⣿⠏⠀⣼⡄⠀⠀⢀⠈⠑⠊⠁⠀⢠⡿                                               ALEXSHAN
⡜⣸⠃⠀⠀⣤⠤⠤⠤⠤⠤⠤⣠⠀⠀⠀⠀⠀⠀⠀⠻⢯⣽⣿⠁⢠⠁⢸⣿⡏⠀⢸⣿⣿⣗⡉⠁⠀⠀⠑⢄⡴⠃ ████ ██████           █████      ██
⣇⣿⠀⠀⠀⠘⡄⠀⠀⠀⢀⠔⠁⠀⠀⠀⠀⠀⠀⠀⠀⢈⣿⣿⣤⣴⣤⣿⣿⣷⣒⢮⣾⣝⣧⠙⣿⣿⣿⣿⡟⠀⠀███████████             █████ 
⢻⣿⠀⠀⠀⠀⠹⡀⣠⠞⠁⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⡥⢾⡿⢿⣿⣿⣿⣿⣝⢿⣷⣾⣿⣿⣶⣶⣾⣷⠟⠀⠀ █████████ ███████████████████ ███   ███████████
⢨⣻⡀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣨⣯⡀⠀⠸⣧⣾⣿⣭⣿⡿⠛⠛⠛⠛⠛⠛⠛⠛⠉⠀   █████████  ███    █████████████ █████ ██████████████
⢸⣿⢣⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣛⠿⠔⣛⣄⢰⣿⣿⠿⠟⢻⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  █████████ ██████████ █████████ █████ █████ ████ █████
⠺⣿⠈⢇⢀⣀⣀⣀⣀⡀⠀⠀⢀⡔⠁⠀⢈⡤⣖⣻⡷⢟⣻⣿⣿⣧⣴⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ███████████ ███    ███ █████████ █████ █████ ████ █████
⡧⣿⡇⢈⣿⣿⢰⡄⠀⢹⠢⣄⠎⠀⢀⡴⠋⠀⢀⣀⣠⣼⡏⢻⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀██████  █████████████████████ ████ █████ █████ ████ ██████
]],
		items = {
			{ name = "Find file", action = "FzfLua files", section = "Actions" },
			{ name = "Live grep", action = "FzfLua live_grep", section = "Actions" },
			{ name = "Recent files", action = "FzfLua oldfiles", section = "Actions" },
			mini_starter.sections.builtin_actions(),
		},
		content_hooks = {
			mini_starter.gen_hook.adding_bullet(),
			mini_starter.gen_hook.indexing("all", { "Builtin actions" }),
			mini_starter.gen_hook.aligning("center", "center"),
		},
		footer = "  " .. os.date("%A, %d %B %Y"),
	})
end
