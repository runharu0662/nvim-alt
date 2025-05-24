return {
    "thinca/vim-quickrun",
    config = function()
        vim.cmd([[
      let g:quickrun_config = {}

      " C++用の設定
      let g:quickrun_config['cpp'] = {
      \  'cmdopt' : '-std=c++20 -Wall',
      \  'hook/time/enable' : 1
      \}

      " デフォルトの出力設定（右に vertical split、幅は 40列くらい）
      let g:quickrun_config['_'] = {
      \  'outputter' : 'buffer',
      \  'outputter/buffer/split' : 'rightbelow vertical',
      \  'outputter/buffer/width' : 40,
      \  'outputter/buffer/into' : '',
      \  'outputter/buffer/close_on_empty' : 1,
      \  'hook/time/enable' : 1
      \}
    ]])
    end,
}
