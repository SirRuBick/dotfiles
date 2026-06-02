local ok_wk, wk = pcall(require, "which-key")
local wk_icons = require("icons").whichkey
if ok_wk then
	wk.add({
		{ "<leader>b", group = wk_icons.b },
		{ "<leader>d", group = wk_icons.d },
		{ "<leader>e", group = wk_icons.e },
		{ "<leader>f", group = wk_icons.f },
		{ "<leader>g", group = wk_icons.g },
		{ "<leader>l", group = wk_icons.l },
		{ "<leader>o", group = wk_icons.o },
		{ "<leader>q", group = wk_icons.q },
		{ "<leader>t", group = wk_icons.t },
		{ "<leader>u", group = wk_icons.u },
	})
end

