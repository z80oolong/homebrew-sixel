# z80oolong/sixel -- SIXEL 対応のアプリケーションを導入するための Formula 群

## 概要

[Homebrew for Linux][BREW] とは、Linux の各ディストリビューションにおけるソースコードの取得及びビルドに基づいたパッケージ管理システムです。 [Homebrew for Linux][BREW] の使用により、ソースコードからのビルドに基づいたソフトウェアの導入を単純かつ容易に行うことが出来ます。

また、 [SIXEL][SIXL] は、縦６ドットを単位としてグラフィックスを描画する機能であり、 [SIXEL][SIXL] に対応した端末エミュレータ等で Sixel 文字列を出力することで画像や動画等を描画することが出来ます。

この [Homebrew for Linux][BREW] 向け Tap リポジトリは、 [SIXEL][SIXL] によって画像もしくは動画等を描画することが可能なアプリケーションを導入するための Formula 群を含む Tap リポジトリです。

なお本リポジトリにおいて、[SIXEL][SIXL] によって画像もしくは動画等を描画することが可能なアプリケーションに関しては、本リポジトリに同梱する  ```FormulaList.md``` を参照してください。

## 使用法

まず最初に、以下に示す Qiita の投稿及び Web ページの記述に基づいて、手元の端末に [Homebrew for Linux][BREW] を構築します。

- [thermes 氏][THER]による "[Linuxbrew のススメ][THBR]" の投稿
- [Homebrew for Linux の公式ページ][BREW]

そして、本リポジトリに含まれる Formula を以下のようにインストールします。

```
 $ brew tap z80oolong/sixel
 $ brew install <formula>
```

なお、一時的な手法ですが、以下のようにして URL を直接指定してインストールすることも出来ます。

```
 $ brew install https://raw.githubusercontent.com/z80oolong/homebrew-sixel/master/Formula/<formula>.rb
```

なお、本リポジトリにて修正を行うアプリケーション及び本リポジトリに含まれる Formula の一覧とその詳細については、本リポジトリに同梱する ```FormulaList.md``` を参照して下さい。

## その他詳細について

その他、本リポジトリ及び [Homebrew for Linux][BREW] の使用についての詳細は ```brew help``` コマンド及び  ```man brew``` コマンドの内容、若しくは [Homebrew for Linux の公式ページ][BREW]を御覧下さい。

## 謝辞

本リポジトリの作成にあたっては、以下のページを参照しました。下記投稿者及び開発者各位に心より感謝いたします。

- [arakiken][ARAK] 氏による ["Sixel Graphicsを活用したアプリケーションの御紹介" の投稿][ASIX]
- [saitoha/FFmpeg-SIXEL の github ページ][FFMS]

また、 [libsixel][LIBS] 開発者コミュニティ及び [SIXEL][SIXL] 対応のアプリケーション開発者コミュニティ各位及び [SIXEL][SIXL] に関わる全ての皆様に心より感謝致します。

## 使用条件

本リポジトリは、 [Homebrew for Linux][BREW] の Tap リポジトリの一つとして、 [Homebrew for Linux の開発コミュニティ][BREW]及び [Z.OOL. (mailto:zool@zool.jpn.org)][ZOOL] が著作権を有し、[Homebrew for Linux][BREW] のライセンスと同様である [BSD 2-Clause License][BSD2] に基づいて配布されるものとします。詳細については、本リポジトリに同梱する ```LICENSE``` を参照して下さい。

<!-- 外部リンク一覧 -->
[BREW]:https://linuxbrew.sh/
[SIXL]:https://saitoha.github.io/libsixel/
[THER]:https://qiita.com/thermes
[THBR]:https://qiita.com/thermes/items/926b478ff6e3758ecfea
[ARAK]:https://qiita.com/arakiken
[ASIX]:https://qiita.com/arakiken/items/3e4bc9a6e43af0198e46
[FFMS]:https://github.com/saitoha/FFmpeg-SIXEL/tree/sixel
[LIBS]:https://github.com/saitoha/libsixel
[BSD2]:https://opensource.org/licenses/BSD-2-Clause
[ZOOL]:http://zool.jpn.org/
