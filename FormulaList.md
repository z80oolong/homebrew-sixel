# z80oolong/sixel に含まれる Formula 一覧

## 概要

本文書では、 [Homebrew for Linux][BREW] 向け Tap リポジトリ z80oolong/sixel に含まれる Formula 一覧を示します。各 Formula の詳細等については ```brew info <formula>``` コマンドも参照して下さい。

## Formula 一覧

### z80oolong/sixel/ffmpeg

[SIXEL][SIXL] による画像描画に対応した [HEAD 版の FFmpeg][FMPG] を導入するための Formula である ```z80oolong/sixel/ffmpeg-head``` への alias です。

### z80oolong/sixel/ffmpeg-head

この Formula は、動画と音声を記録・変換・再生するための多機能アプリケーションである [FFmpeg][FMPG] の [github 上の HEAD 版][MPGG] について、[SIXEL][SIXL] を用いた端末エミュレータへの画像の描画に対応した修正を施したものを導入するための Formula です。

なお、本 Formula にて適用される [FFmpeg][FMPG] の差分は、 [saitoha 氏][SAIT] によって作成された [FFmpeg の SIXEL 対応差分][SITF] を大幅に修正し、 [最新の FFmpeg][FMPG] に適用したものです。

通常は、 [SIXEL][SIXL] に対応した [FFmpeg][FMPG] において、 [SIXEL 対応の修正を行った直近の HEAD 版の commit][MPGG] の [FFmpeg][FMPG] が導入されます。

[github 上の HEAD 版の最新の commit の FFmpeg][MPGG] を導入する場合は、オプション ```--HEAD``` を指定して下さい。

**この Formula は、 ```homebrew/core/ffmpeg``` と競合するため、この Formula によって導入される [FFmpeg][FMPG] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [FFmpeg][FMPG] を使用するには、 ```brew link --force z80oolong/sixel/ffmpeg-head``` コマンドを実行する必要があります。

### z80oolong/sixel/w3m-head

この Formula は、ページャ兼テキストベースのウェブブラウザである [w3m][W3MB] の [github 上の HEAD 版][W3MG] について、[SIXEL][SIXL] を用いた端末エミュレータへの画像の描画に対応した修正を施したものを導入するための Formula です。

通常は、 [SIXEL][SIXL] に対応した [w3m][W3MB] において、 [SIXEL 対応の修正を行った直近の HEAD 版の commit][W3MG] の [w3m][W3MB] が導入されます。

[github 上の HEAD 版の最新の commit の w3m][W3MB] を導入する場合は、オプション ```--HEAD``` を指定して下さい。

**この Formula は、 ```homebrew/core/w3m``` と競合するため、この Formula によって導入される [w3m][W3MB] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [w3m][W3MB] を使用するには、 ```brew link --force z80oolong/sixel/w3m-head``` コマンドを実行する必要があります。

### z80oolong/sixel/ffmpeg@{version}

(注：上記 ```{version}``` には、 [FFmpeg][FMPG] の各バージョン番号が入ります。以下同様。)

この Formula は、動画と音声を記録・変換・再生するための多機能アプリケーションである [FFmpeg][FMPG] の安定版 [FFmpeg {version}][FMPG] について、[SIXEL][SIXL] を用いた端末エミュレータへの画像の描画に対応した修正を施したものを導入するための Formula です。

なお、本 Formula にて適用される [FFmpeg][FMPG] の差分は、 [saitoha 氏][SAIT] によって作成された [FFmpeg の SIXEL 対応差分][SITF] を大幅に修正し、 [最新の FFmpeg][FMPG] に適用したものです。

なお、この Formula で導入した [FFmpeg][FMPG] の使用法については、前述の ```z80oolong/sixel/ffmpeg-head``` の Formula についての記述を参照して下さい。

**この Formula は、 versioned formula であるため、この Formula によって導入される [FFmpeg][FMPG] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [FFmpeg][FMPG] を使用するには、 ```brew link --force z80oolong/sixel/ffmpeg@{version}``` コマンドを実行する必要があります。

### z80oolong/sixel/w3m@{version}

(注：上記 ```{version}``` には、 [w3m][W3MB] の各バージョン番号が入ります。以下同様。)

この Formula は、ページャ兼テキストベースのウェブブラウザである [w3m][W3MB] の安定版 [w3m {version}][W3MB] について、[SIXEL][SIXL] を用いた端末エミュレータへの画像の描画に対応した修正を施したものを導入するための Formula です。

**この Formula は、 versioned formula であるため、この Formula によって導入される [w3m][W3MB] は、 keg only で導入されることに留意して下さい。**

この Formula によって導入される [w3m][W3MB] を使用するには、 ```brew link --force z80oolong/sixel/w3m@{version}``` コマンドを実行する必要があります。

<!-- 外部リンク一覧 -->

[BREW]:https://linuxbrew.sh/
[SIXL]:https://saitoha.github.io/libsixel/
[FMPG]:https://www.ffmpeg.org/
[SAIT]:https://github.com/saitoha/
[SITF]:https://github.com/saitoha/FFmpeg-SIXEL/tree/sixel
[MPGG]:https://github.com/FFmpeg/FFmpeg
[W3MB]:https://w3m.sourceforge.net/
[W3MG]:https://github.com/tats/w3m
