# web: Go・Web・Cloud / IaC・日本語執筆用 Neovim

`web` は `simple` の日本語・Markdown 設定を基に、既存操作を保持して開発機能を追加した構成です。
`full` は従来の全部入り構成、`cpp` は競技プログラミング構成です。

Neovim は編集・検索・LSP・整形・lint・Git 差分・記事執筆を担当します。
build / test / terraform plan・apply / AWS CLI / Docker / kubectl は WezTerm + Zsh で実行します。
既存の ToggleTerm キーは互換性のため保持し、CLI ラッパーや自動実行機能は追加していません。

## 言語と担当ツール

| 対象 | LSP / diagnostics | 整形 |
|---|---|---|
| Go / go.mod / go.sum / go.work | gopls | Go は goimports → gofmt → gopls の優先順、mod / sum は対応する LSP 機能のみ |
| TypeScript / JavaScript / TSX / JSX | ts_ls、ESLint LSP | Prettier、未導入なら対応する LSP |
| HTML / CSS | html / cssls | Prettier、未導入なら対応する LSP |
| JSON / JSONC | jsonls | Prettier、未導入なら jsonls |
| YAML | yamlls | Prettier、未導入なら対応する LSP |
| Terraform / tfvars | terraformls、tflint の言語サーバー | terraform fmt（バッファ内容を標準入力で整形）→ terraformls |
| HCL | Treesitter の構文ハイライト | 一般 HCL に Terraform 整形を強制しない |
| Dockerfile | dockerls | 対応する LSP |
| shell | bashls | shfmt、未導入なら対応する LSP |
| Markdown | Treesitter、日本語入力、記事用コマンド | 明示操作時のみ Prettier |
| 設定用 Lua | lua_ls | StyLua、未導入なら対応する LSP |

LSP はプロジェクト内の `node_modules/.bin` → Mason / PATH の実行ファイルを探します。
未導入のサーバーは起動せず、ファイルを開くだけではツールをインストールしません。
Prettier はプロジェクトの実行ファイルと設定を優先します。
ESLint はプロジェクトの ESLint 設定に従って診断・コードアクションを提供し、整形役にはしません。
`eslint_d` や none-ls の ESLint ソースは重ねて登録していません。

## 開発ツールの導入

Neovim 0.11 以降の LSP・組み込み snippet API を使います。Node 系 LSP / Prettier / ESLint には Node.js、Go の開発には Go が必要です。
必要なものだけ `:Mason` または環境のパッケージマネージャーで導入してください。

LSP は次のコマンドで必要な分を導入できます。

```vim
:LspInstall gopls ts_ls eslint html cssls jsonls yamlls terraformls dockerls bashls lua_ls
```

formatter / lint は `:Mason` で `goimports`、`prettier`、`shfmt`、`stylua`、`tflint` を選べます。
`gofmt` は Go、`terraform` は Terraform CLI の導入で提供されます。
Web プロジェクトの Prettier / ESLint はプロジェクト側の devDependencies に置く運用を優先してください。
検索の `rg` / `fd` は Zsh の PATH に導入します。Mason の `ensure_installed` に設定しても汎用 CLI は導入されないため、その誤設定を除去しました。
`setup_apt.sh` は Ubuntu の基本導入用で、各言語の runtime は一括導入しません。

## キー操作と保存時の動作

`<leader>` は Space です。既存のマッピングは保持しています。

| 操作 | キー / コマンド |
|---|---|
| ファイルツリー | `<leader>e` |
| ファイル / 全文 / バッファ / ヘルプ検索 | `<leader>ff` / `fg` / `fb` / `fh` |
| 整形 | `<leader>n`（整形先を一つだけ選択） |
| rename / code action | `<leader>rn` / `ca` |
| definition / references | `gd` / `gr`（LSP 接続時、既存の割り当てがなければ追加） |
| Go / TS の import 整理 | `:OrganizeImports`（該当 LSP 接続時） |
| ESLint の修正 | `:LspEslintFixAll` または既存の code action |
| Git 差分の部分表示 / index と比較 | `<leader>gd` / `gl`（新規追加） |
| Copilot の切り替え | `<leader>lt` |
| 既存のターミナル | `<leader>tf` / `tv` / `th` |

コード保存時は formatter を一つ選んで同期整形します。Go では goimports があれば import 整理も行います。
ESLint の fix-all は保存時に強制しません。
Markdown は保存時の自動整形を行わず、記事の改行・空白を保持します。
整形ツールがなくても保存はできます。明示的な整形操作で利用可能な整形先がない場合は通知します。

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


## プラグインの分類

依頼に記載された KEEP / REMOVE / REVIEW で分類しています。4つ目の分類名は未指定です。
今回、新規プラグインの追加・既存プラグインの削除は行っていません。
削除候補でも既存キーや UI に影響するものは REVIEW に残しました。

| 分類 | プラグイン | 判断 |
|---|---|---|
| KEEP | lazy.nvim | 管理と lockfile を維持 |
| KEEP | nvim-treesitter | 対象言語の syntax highlight |
| KEEP | telescope.nvim、plenary.nvim | 既存のファイル・全文検索、依存ライブラリ |
| KEEP | nvim-lspconfig、mason.nvim、mason-lspconfig.nvim | LSP 設定と手動のツール導入 |
| KEEP | none-ls.nvim、mason-null-ls.nvim | 既存の formatter 連携。ソース登録を明示化 |
| KEEP | nvim-cmp、cmp-nvim-lsp、cmp-buffer | 既存の補完キーを保持、組み込み snippet 展開を追加 |
| KEEP | gitsigns.nvim | Git 差分表示と確認 |
| KEEP | skkeleton、denops.vim | 日本語入力 |
| KEEP | copilot.lua、CopilotChat.nvim | 現在の AI 操作を保持 |
| KEEP | neo-tree.nvim、nvim-web-devicons、nui.nvim | 既存のファイル操作と UI 依存 |
| KEEP | hop.nvim、nvim-autopairs、which-key.nvim | 既存の移動・入力・キー案内 |
| KEEP | lspsaga.nvim | 既存の code action 操作 |
| REVIEW | toggleterm.nvim | 実行の主役は WezTerm。既存 tf / tv / th を守るため保持 |
| REVIEW | tokyonight.nvim、lualine.nvim、alpha-nvim、ascii.nvim | 見た目・開始画面。今回の用途整理では変更しない |
| REVIEW | nvim-notify、noice.nvim、fidget.nvim | 通知・進捗の表示用途を確認してから整理。既存の通知検索も保持 |
| REVIEW | indent-blankline.nvim、nvim-cursorline、neoscroll.nvim | 装飾とスクロールの好みを確認してから整理 |
| REMOVE | プラグイン該当なし | 重複だけを理由にワークフローを削除しない |

設定上の重複は除去しました。自動登録で任意の formatter が増える処理、複数 LSP に同時に整形を頼む処理、無効な Mason の検索 CLI 導入設定が対象です。
lockfile の既存 commit は維持しています。AWS 専用プラグイン、build / test runner、ターミナル機能の追加はありません。

## 検証

`tests/development.lua` は既存プラグインを読み、サーバー・parser の存在、simple のマッピング保持、整形先の選択、Markdown 保存時の保護を確認します。
ネットワークでプラグインを取得するテストではありません。Go が導入されている場合は、一時ファイルで実際の none-ls 経由の Go 整形も確認します。
通常の init / lazy 起動も、外部取得と Denops worker、parser 導入を止めた環境で確認済みです。外部 LSP との実通信・ESLint / Prettier の実プロジェクト動作・日本語変換・画像貼り付けは未確認です。

```sh
NVIM_APPNAME=nvim-web-test \
XDG_DATA_HOME=/tmp/nvim-web-test/data \
XDG_STATE_HOME=/tmp/nvim-web-test/state \
XDG_CACHE_HOME=/tmp/nvim-web-test/cache \
NVIM_LOG_FILE=/tmp/nvim-web-test.log \
NVIM_TEST_PLUGINS="$HOME/.local/share/nvim-alt/lazy" \
nvim --headless --noplugin -u NONE -i NONE \
  '+lua local ok, err = pcall(dofile, "tests/development.lua"); if not ok then print(err); vim.cmd("cquit 1") end' +qa
```

参考: [mason-lspconfig](https://github.com/mason-org/mason-lspconfig.nvim)、[none-ls](https://github.com/nvimtools/none-ls.nvim)、[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)、[skkeleton](https://github.com/vim-skk/skkeleton)。
