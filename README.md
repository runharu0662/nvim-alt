# simple: 日本語・Markdown 用 Neovim

`simple` は日本語の文章・Markdown 編集用、`cpp` は競技プログラミング用です。

## 日本語入力

- [Deno](https://deno.com/) を PATH に配置します。
- [SKK 辞書](https://skk-dev.github.io/dict/)の `SKK-JISYO.L` を展開し、`~/.skk/SKK-JISYO.L` に配置します。
- 挿入・コマンドラインモードの `<C-j>` で skkeleton を切り替えます。
- 変換中は `<C-n>` / `<C-p>` で候補移動、`<C-y>` で確定、`<C-e>` でキャンセルします。
- 辞書の場所は `init.lua` で `vim.g.skk_dictionary_path` を指定できます。

Deno がない環境では skkeleton は読み込みません。辞書がない場合は初回使用時に通知します。

## Markdown

- 画面幅で折り返します。自動折り返しでファイルに改行は挿入しません。
- `j` / `k` は表示行単位、回数指定時はファイルの行単位で移動します。
- Markdown では nvim-cmp と Copilot の自動補完を無効にしています。
- `<leader>pc` は `[[リンク]]` のファイル作成、`<leader>po` はリンクを開きます。
- `<leader>pi` の画像貼り付けには `pngpaste` と `vim.g.obsidian_vault_path` の設定が必要です。

LSP・整形ツールは自動インストールしません。必要なものは手動で追加してください。
