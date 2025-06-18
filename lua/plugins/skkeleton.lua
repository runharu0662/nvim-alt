return {
	"vim-skk/skkeleton",
	dependencies = { "vim-denops/denops.vim" },
	lazy = false,
	config = function()
		vim.fn["skkeleton#config"]({
			eggLikeNewline = true,
			registerConvertResult = true,
			globalDictionaries = { "~/.skk/SKK-JISYO.L" },
			userDictionary = "~/.skk/skk-jisyo.user",
			kanaTable = "rom-kana",
			immediatelyCancel = true,
			keepState = true,
			showCandidatesCount = true,
			markerHenkan = ">",
			markerOkuri = "-",
			indicator = {
				hira = "[あ]",
				kata = "[ア]",
				hankata = "[ｱ]",
				zenkaku = "[Ａ]",
				abbrev = "[Aa]",
				latin = "[A]",
				wideLatin = "[Ａ]",
			},
		})

		-- 候補移動（n/p）やトグル切替（C-xなど）
		vim.fn["skkeleton#register_keymap"]("henkan", "<C-n>", "nextCandidate")
		vim.fn["skkeleton#register_keymap"]("henkan", "<C-p>", "prevCandidate")

		-- SKK起動トグル（<C-x>推奨、<C-j>は衝突注意）
		vim.keymap.set("i", "<C-x>", "<Plug>(skkeleton-toggle)")
		vim.keymap.set("c", "<C-x>", "<Plug>(skkeleton-toggle)")
	end,
}
