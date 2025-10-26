# z80oolong/sixel -- SIXEL 対応アプリケーションをインストールするための Formula 群

## 概要

[Homebrew for Linux][BREW] は、Linux ディストリビューション向けのソースコードベースのパッケージ管理システムであり、ソフトウェアのビルドおよびインストールを簡素化します。

[SIXEL][SIXL] は、縦6ドットを単位とするグラフィックス描画機能で、[SIXEL][SIXL] 対応の端末エミュレータにおいて、Sixel 文字列を出力することで画像や動画を表示できます。

この [Homebrew for Linux][BREW] 向け Tap リポジトリ ```z80oolong/sixel``` は、[SIXEL][SIXL] を用いて画像や動画を表示可能なアプリケーションをインストールするための Formula 群を提供します。

対応するアプリケーションおよび Formula の詳細は、本リポジトリに同梱の ```FormulaList.md``` を参照してください。

## 使用方法

[Homebrew for Linux][BREW] を以下の参考資料に基づいてインストールします：

- [thermes 氏][THER] の Qiita 投稿 "[Linuxbrew のススメ][THBR]"
- [Homebrew for Linux 公式ページ][BREW]

本リポジトリの Formula を以下のようにインストールします：

```
  brew tap z80oolong/sixel
  brew install <formula>
```

または、一時的な方法として、以下のように URL を直接指定してインストール可能です：

```
  brew install https://raw.githubusercontent.com/z80oolong/homebrew-sixel/master/Formula/<formula>.rb
```

利用可能な Formula の一覧および詳細は、本リポジトリに同梱の ```FormulaList.md``` を参照してください。

## 詳細情報

本リポジトリおよび [Homebrew for Linux][BREW] の使用方法の詳細は、以下のコマンドやリソースを参照してください：

- ```brew help``` コマンド
- ```man brew``` コマンド
- [Homebrew for Linux 公式ページ][BREW]

## 謝辞

本リポジトリの作成にあたり、以下の資料を参照しました：

- [Araki Ken 氏][ARAK] の Qiita 投稿 "[Sixel Graphicsを活用したアプリケーションの御紹介][ASIX]"
- [saitoha/FFmpeg-SIXEL の GitHub ページ][FFMS]

[Araki Ken 氏][ARAK]、[libsixel][LIBS] 開発者コミュニティ、[SIXEL][SIXL] 対応アプリケーション開発者コミュニティ、および [SIXEL][SIXL] に関わるすべての皆様に心より感謝いたします。

## 使用条件

本リポジトリは、[Homebrew for Linux][BREW] の Tap リポジトリとして、[Homebrew for Linux 開発コミュニティ][BREW] および [Z.OOL.][ZOOL] が著作権を有します。本リポジトリは、[BSD 2-Clause License][BSD2] に基づいて配布されます。詳細は本リポジトリに同梱の ```LICENSE``` を参照してください。

<!-- 外部リンク一覧 -->

[BREW]: https://linuxbrew.sh/
[SIXL]: https://saitoha.github.io/libsixel/
[THER]: https://qiita.com/thermes
[THBR]: https://qiita.com/thermes/items/926b478ff6e3758ecfea
[ARAK]: https://github.com/arakiken
[ASIX]: https://qiita.com/arakiken/items/3e4bc9a6e43af0198e46
[FFMS]: https://github.com/saitoha/FFmpeg-SIXEL/tree/sixel
[LIBS]: https://github.com/saitoha/libsixel
[BSD2]: https://opensource.org/licenses/BSD-2-Clause
[ZOOL]: http://zool.jpn.org/
