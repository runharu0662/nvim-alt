vim.fn["skkeleton#config"]({
	eggLikeNewline = true,
	registerConvertResult = true,
	globalDictionaries = { "~/.skk/SKK-JISYO.L" },
	userDictionary = "~/.skk/skk-jisyo.user",
	kanaTable = "rom-kana",
	immediatelyCancel = true,
	keepState = true,
	showCandidatesCount = true,
	indicator = {
		hira = "[あ]",
		kata = "[ア]",
		zenkaku = "[Ａ]",
		abbrev = "[Aa]",
		latin = "[A]",
		wideLatin = "[Ａ]",
	},
})
