# z80oolong/sixel に含まれる Formula 一覧

## 概要

本文書では、[Homebrew for Linux][BREW] 向け Tap リポジトリ ```z80oolong/sixel``` に含まれる Formula 一覧を示します。

この Tap リポジトリは、[SIXEL][SIXL] を用いた端末エミュレータでの画像描画に対応した修正を施したアプリケーションを提供します。各 Formula の詳細については、```brew info <formula>``` コマンドをご覧ください。

## Formula 一覧

### z80oolong/sixel/ffmpeg

[SIXEL][SIXL] による画像描画に対応した [FFmpeg 及びその HEAD 版][FMPG] をインストールするための Formula である ```z80oolong/sixel/ffmpeg-current``` への alias です。

### z80oolong/sixel/ffmpeg-current

この Formula は、動画と音声を記録・変換・再生するための多機能アプリケーションである [FFmpeg][FMPG] の最新安定版および最新の [GitHub 上の HEAD 版][MPGG] について、[SIXEL][SIXL] を用いた端末エミュレータへの画像描画に対応した修正を施したものをインストールする Formula です。

なお、この Formula で適用される [FFmpeg][FMPG] の差分は、[saitoha 氏][SAIT] によって作成された "[FFmpeg の SIXEL 対応差分][SITF]" を大幅に修正し、[FFmpeg][FMPG] に適用したものです。

[GitHub 上の最新の HEAD 版の FFmpeg][MPGG] をインストールする場合は、```--HEAD``` オプションを指定してください。

- **注意**:
  - **この Formula は ```homebrew/core/ffmpeg``` と競合するため、keg-only でインストールされます。**
  - **この Formula によってインストールされた [FFmpeg][FMPG] を使用するには ```brew link --force z80oolong/sixel/ffmpeg-current``` を実行してください。**

### z80oolong/sixel/ffmpeg@{version}

(注: ```{version}``` には [FFmpeg][FMPG] の各バージョン番号が入ります。)

この Formula は、動画と音声を記録・変換・再生するための多機能アプリケーションである [FFmpeg][FMPG] の安定版 [FFmpeg {version}][FMPG] について、[SIXEL][SIXL] を用いた端末エミュレータへの画像描画に対応した修正を施したものをインストールする Formula です。

なお、この Formula で適用される [FFmpeg][FMPG] の差分は、[saitoha 氏][SAIT] によって作成された "[FFmpeg の SIXEL 対応差分][SITF]" を大幅に修正し、[FFmpeg][FMPG] に適用したものです。

使用法については、```z80oolong/sixel/ffmpeg-current``` の記述をご覧ください。

- **注意**:
  - **この Formula は versioned formula のため、keg-only でインストールされます。**
  - **この Formula によってインストールされた [FFmpeg][FMPG] を使用するには ```brew link --force z80oolong/sixel/ffmpeg@{version}``` を実行してください。**

### z80oolong/sixel/ffmpeg@9999-dev

この Formula は、```z80oolong/sixel/ffmpeg@9999-dev``` に組み込まれた差分ファイルの適用により、[SIXEL][SIXL] を用いた端末エミュレータへの画像描画に対応した修正を施した [FFmpeg][FMPG] の特定の HEAD 版をインストールする Formula です。

たとえば、```z80oolong/sixel/ffmpeg@9999-dev``` に組み込まれている差分ファイルが [FFmpeg][FMPG] の HEAD 版のコミット xxxxxxxxx 向けに対応している場合は、この Formula は [FFmpeg][FMPG] の HEAD 版のコミット xxxxxxxxx をインストールします。

具体的なコミットについては、```brew info z80oolong/sixel/ffmpeg@9999-dev``` で確認できます。使用法は ```z80oolong/sixel/ffmpeg-current``` の記述をご覧ください。

- **注意**:
  - **この Formula は versioned formula のため、keg-only でインストールされます。**
  - **この Formula によってインストールされた [FFmpeg][FMPG] を使用するには ```brew link --force z80oolong/sixel/ffmpeg@9999-dev``` を実行してください。**
  - **この Formula は、```z80oolong/sixel/ffmpeg-current``` の HEAD 版で差分ファイル適用に不具合が発生する場合に暫定的に使用するものです。** 通常は ```z80oolong/sixel/ffmpeg-current``` をご使用ください。

### z80oolong/sixel/w3m

[SIXEL][SIXL] による画像描画に対応した "w3m 及びその HEAD 版"[W3MB] をインストールするための Formula である ```z80oolong/sixel/w3m-current``` への alias です。

### z80oolong/sixel/w3m-current

この Formula は、ページャ兼テキストベースのウェブブラウザである [w3m][W3MB] の最新安定版および最新の [GitHub 上の HEAD 版][W3MG] について、[SIXEL][SIXL] を用いた端末エミュレータへの画像描画に対応した修正を施したものをインストールする Formula です。

[GitHub 上の最新の HEAD 版の w3m][W3MG] をインストールする場合は、```--HEAD``` オプションを指定してください。

- **注意**:
  - **この Formula は ```homebrew/core/w3m``` と競合するため、keg-only でインストールされます。**
  - **この Formula によってインストールされた [w3m][W3MB] を使用するには ```brew link --force z80oolong/sixel/w3m-current``` を実行してください。**

### z80oolong/sixel/w3m@{version}

(注: ```{version}``` には [w3m][W3MB] の各バージョン番号が入ります。)

この Formula は、ページャ兼テキストベースのウェブブラウザである [w3m][W3MB] の安定版 [w3m {version}][W3MB] について、[SIXEL][SIXL] を用いた端末エミュレータへの画像描画に対応した修正を施したものをインストールする Formula です。

使用法については、```z80oolong/sixel/w3m-current``` の記述をご覧ください。

- **注意**:
  - **この Formula は versioned formula のため、keg-only でインストールされます。**
  - **この Formula によってインストールされた [w3m][W3MB] を使用するには ```brew link --force z80oolong/sixel/w3m@{version}``` を実行してください。**

<!-- 外部リンク一覧 -->

[BREW]: https://linuxbrew.sh/  
[SIXL]: https://saitoha.github.io/libsixel/  
[FMPG]: https://www.ffmpeg.org/  
[SAIT]: https://github.com/saitoha/  
[SITF]: https://github.com/saitoha/FFmpeg-SIXEL/tree/sixel  
[MPGG]: https://github.com/FFmpeg/FFmpeg  
[W3MB]: https://w3m.sourceforge.net/  
[W3MG]: https://github.com/tats/w3m
