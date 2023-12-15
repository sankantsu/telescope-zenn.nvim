# telescope-zenn.nvim

`telescope-zenn.nvim` は、Zenn の記事執筆を支援するための `telescope.nvim` の拡張です。

<img width="1582" alt="telescope-zenn-nvim" src="https://github.com/sankantsu/telescope-zenn.nvim/assets/52688583/467897cb-3998-4d8d-9fec-9d33a54b92d5">

## Feature

- Slug と同時に記事タイトルを確認および対話的に検索しながら編集する記事を選択できます。
  - topics の文字列も検索対象となります。

## Install

- packer.nvim

```lua
use {
  "sankantsu/telescope-zenn.nvim", requires = { { "nvim-telescope/telescope.nvim" } }
}
```

- lazy.nvim

```lua
require("lazy").setup({
  { "sankantsu/telescope-zenn.nvim", dependencies = { "nvim-telescope/telescope.nvim", } },
})
```

## Command, Keymap

- `:Telescope zenn article_picker`: 記事選択画面を起動します。

キーマップ設定例

```lua
vim.keymap.set('n', '<leader>fz', telescope.extensions.zenn.article_picker)
```

## ⚠️注意点

- Zenn と Github 連携している**レポジトリ内のルートディレクトリで nvim を起動する**ことが必要です。
  - 記事候補の作成に zenn-cli の機能を用いており、zenn-cli がプロジェクトのルートディレクトリ以外で期待する出力を返さないことによる制約です。

## Actions

Zenn のプロジェクト内のファイル操作を行うためのカスタムアクションを定義しています。

name     | description    | default mapping (normal mode)
---------|----------------|------------------------------
`create` | 新規記事を作成 | `c`
`delete` | 記事を削除     | `d`

## Optional settings

Slug の表示幅を設定するオプションを用意しています。以下は、デフォルト相当の設定の記述方法

```lua
require("telescope").setup({
  extensions = {
    zenn = {
      slug_display_length = 7,
    },
  },
})
```

## License

This software is released under the MIT License, see LICENSE.
