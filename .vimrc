"---------------------------------------------------------
" 一般
" viとの互換を取らない
set nocompatible
" コマンド、検索のパターンを50個まで残す
set history=50

"---------------------------------------------------------
" 検索関連

" 検索文字列が小文字の場合は大文字小文字区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれていた場合は区別して検索する
set smartcase
" 検索時に最後までいったら最初に戻らない
set nowrapscan
" 検索文字列入力時に順次対象文字列にヒットさせない
set noincsearch


"---------------------------------------------------------
" 装飾関係

" 行番号を表示させる
set number
" タイトルをウインドウ枠に表示
set title
" ルーラーを表示
set ruler
" タブや改行を表示しない
set nolist
" 入力中のコマンドをステータスに表示する
set showcmd
" 括弧入力時の対応するかっこを表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" ハイライト
if &t_Co > 2 || has("gui_runnning")
  syntax on
  set hlsearch
endif
hi Comment ctermfg=2

"---------------------------------------------------------
" 文書編集関係
" ノーマルモードでもエンターキーで改行を挿入
noremap <CR> o<ESC>
" カーソル行の強調表示
" set cursorline
" backspaceキーを押したときの挙動
"  indent : 行頭の空白の削除を許す
"  eol : 改行の削除を許す
"  start : 挿入モードの開始位置での削除を許す
set backspace=indent,eol,start
" Tab文字を画面上の見た目で何文字幅にするかを設定
set tabstop=4
" cindentやautoindent時に挿入されるタブの幅
set shiftwidth=4
" Tabキー使用時にTabではなくホワイトスペースを入れたいときに使用する
set softtabstop=0
" Tab文字を空白に置き換えない
set noexpandtab
" オートインデントを有効にする
set cindent
" テキストをクリップボードに入るようにする
"set clipboard+=autoselect

"---------------------------------------------------------
" ファイル関連
" バックアップファイルを作成しない
set nobackup

