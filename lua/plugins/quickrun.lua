-- plugins/jaq-nvim.lua
return {
	"thinca/vim-quickrun",
	config = function()
		-- QuickRun の設定
		vim.cmd([[
      let g:quickrun_config = {}

      " C++ファイルを実行する時に、実行時間を計測する
      let g:quickrun_config['cpp'] = {
      \  'cmdopt' : '-std=c++20 -Wall',
      \  'hook/time/enable' : 1
      \}

      " QuickRun のデフォルトの分割設定 (垂直分割)
      let g:quickrun_config['_'] = {
      \  'outputter/buffer/split' : '',
      \  'outputter/buffer/type' : 'popup',
      \  'outputter/buffer/into' : 'quickrun#preview#float',
      \  'hook/time/enable' : 1
      \}    ]])
	end,
}
