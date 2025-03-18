class FfmpegAT612 < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-6.1.2.tar.xz"
  sha256 "3b624649725ecdc565c903ca6643d41f33bd49239922e45c9b1442c63dca4e38"
  license "GPL-2.0-or-later"
  revision 5

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "aom"
  depends_on "aribb24"
  depends_on "dav1d"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "frei0r"
  depends_on "glibc"
  depends_on "gnutls"
  depends_on "lame"
  depends_on "libass"
  depends_on "libbluray"
  depends_on "libdrm"
  depends_on "librist"
  depends_on "libsixel"
  depends_on "libsoxr"
  depends_on "libvidstab"
  depends_on "libvmaf"
  depends_on "libvorbis"
  depends_on "libvpx"
  depends_on "opencore-amr"
  depends_on "openjpeg"
  depends_on "opus"
  depends_on "rav1e"
  depends_on "rubberband"
  depends_on "sdl2"
  depends_on "snappy"
  depends_on "speex"
  depends_on "srt"
  depends_on "svt-av1"
  depends_on "tesseract"
  depends_on "theora"
  depends_on "webp"
  depends_on "x264"
  depends_on "x265"
  depends_on "xvid"
  depends_on "xz"
  depends_on "zeromq"
  depends_on "zimg"

  uses_from_macos "bzip2"
  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  on_linux do
    depends_on "alsa-lib"
    depends_on "libxv"
  end

  on_intel do
    depends_on "nasm" => :build
  end

  fails_with gcc: "5"

  patch :p1, :DATA

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
      --enable-pthreads
      --enable-version3
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-ffplay
      --enable-gnutls
      --enable-gpl
      --enable-libaom
      --enable-libaribb24
      --enable-libbluray
      --enable-libdav1d
      --enable-libmp3lame
      --enable-libopus
      --enable-librav1e
      --enable-librist
      --enable-librubberband
      --enable-libsnappy
      --enable-libsrt
      --enable-libsvtav1
      --enable-libtesseract
      --enable-libtheora
      --enable-libvidstab
      --enable-libvmaf
      --enable-libvorbis
      --enable-libvpx
      --enable-libwebp
      --enable-libx264
      --enable-libx265
      --enable-libxml2
      --enable-libxvid
      --enable-lzma
      --enable-libfontconfig
      --enable-libfreetype
      --enable-frei0r
      --enable-libass
      --enable-libopencore-amrnb
      --enable-libopencore-amrwb
      --enable-libopenjpeg
      --enable-libspeex
      --enable-libsoxr
      --enable-libzmq
      --enable-libzimg
      --disable-libjack
      --disable-indev=jack
      --enable-libsixel
    ]

    if OS.mac?
      args << "--enable-videotoolbox"
      args << "--enable-audiotoolbox"
    end
    args << "--enable-neon" if Hardware::CPU.arm?

    system "./configure", *args
    system "make"
    system "make", "install"
    system "make", "alltools"

    bin.install (buildpath/"tools").children.select { |f| f.file? && f.executable? }
    pkgshare.install buildpath/"tools/python"

    append_rpath bin/"ffmpeg", full_name
  end

  def append_rpath(binname, *append_list)
    return if OS.mac?

    rpath = `#{Formula["patchelf"].opt_bin}/patchelf --print-rpath #{binname}`.chomp.split(":")
    append_list.each { |name| rpath.unshift(Formula[name].opt_lib) }

    system Formula["patchelf"].opt_bin/"patchelf", "--set-rpath", rpath.join(":"), binname
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end

__END__
diff --git a/README.md b/README.md
index f8c23f2..36d4181 100644
--- a/README.md
+++ b/README.md
@@ -25,6 +25,8 @@ such as audio, video, subtitles and related metadata.
 
 ## Documentation
 
+* See the INSTALL file.
+
 The offline documentation is available in the **doc/** directory.
 
 The online documentation is available in the main [website](https://ffmpeg.org)
@@ -44,3 +46,45 @@ GPL. Please refer to the LICENSE file for detailed information.
 Patches should be submitted to the ffmpeg-devel mailing list using
 `git format-patch` or `git send-email`. Github pull requests should be
 avoided because they are not part of our review process and will be ignored.
+
+SIXEL Integration
+=============
+
+[![ballmer](https://raw.githubusercontent.com/saitoha/FFmpeg-SIXEL/data/data/ballmer.png)](https://youtu.be/7z6lo4aq6zc)
+
+## Step 0. Edit .Xresources
+
+```
+$ cat $HOME/.Xresources
+XTerm*decTerminalID: vt340
+XTerm*sixelScrolling: true
+XTerm*regisScreenSize: 1920x1080
+XTerm*numColorRegisters: 256
+
+$ xrdb $HOME/.Xresources  # reload
+```
+
+## Step 1. Build xterm with --enable-sixel-graphics option
+
+```
+$ wget ftp://invisible-island.net/xterm/xterm.tar.gz
+$ tar xvzf xterm.tar.gz
+$ cd xterm-*
+$ ./configure --enable-sixel-graphics
+$ make
+$ ./xterm  # launch
+```
+
+## Step 2. Build FFmpeg-SIXEL with libsixel and libquvi (for network streaming)
+
+```
+$ git clone https://github.com/saitoha/libsixel
+$ cd libsixel
+$ ./configure && make install
+$ cd ..
+$ git clone https://github.com/saitoha/FFmpeg-SIXEL
+$ cd FFmpeg-SIXEL
+$ ./configure --enable-libquvi --enable-libsixel
+$ make install
+$ ffmpeg -i 'https://www.youtube.com/watch?v=ixaMZPPmVG0' -f sixel -pix_fmt rgb24 -s 480x270 -
+```
diff --git a/configure b/configure
index 5af693c..2422dda 100755
--- a/configure
+++ b/configure
@@ -264,6 +264,7 @@ External library support:
   --enable-librtmp         enable RTMP[E] support via librtmp [no]
   --enable-libshaderc      enable GLSL->SPIRV compilation via libshaderc [no]
   --enable-libshine        enable fixed-point MP3 encoding via libshine [no]
+  --enable-libsixel        enable SIXEL terminal support using libsixel
   --enable-libsmbclient    enable Samba protocol via libsmbclient [no]
   --enable-libsnappy       enable Snappy compression, needed for hap encoding [no]
   --enable-libsoxr         enable Include libsoxr resampling [no]
@@ -1884,6 +1885,7 @@ EXTERNAL_LIBRARY_LIST="
     librtmp
     libshaderc
     libshine
+    libsixel
     libsmbclient
     libsnappy
     libsoxr
@@ -3603,6 +3605,7 @@ oss_indev_deps_any="sys_soundcard_h"
 oss_outdev_deps_any="sys_soundcard_h"
 pulse_indev_deps="libpulse"
 pulse_outdev_deps="libpulse"
+sixel_outdev_deps="libsixel"
 sdl2_outdev_deps="sdl2"
 sndio_indev_deps="sndio"
 sndio_outdev_deps="sndio"
@@ -6801,6 +6804,7 @@ enabled librtmp           && require_pkg_config librtmp librtmp librtmp/rtmp.h R
 enabled librubberband     && require_pkg_config librubberband "rubberband >= 1.8.1" rubberband/rubberband-c.h rubberband_new -lstdc++ && append librubberband_extralibs "-lstdc++"
 enabled libshaderc        && require_pkg_config spirv_compiler "shaderc >= 2019.1" shaderc/shaderc.h shaderc_compiler_initialize
 enabled libshine          && require_pkg_config libshine shine shine/layer3.h shine_encode_buffer
+enabled libsixel          && require_pkg_config libsixel "libsixel >= 1.10.0" sixel.h sixel_dither_get_num_of_histogram_colors
 enabled libsmbclient      && { check_pkg_config libsmbclient smbclient libsmbclient.h smbc_init ||
                                require libsmbclient libsmbclient.h smbc_init -lsmbclient; }
 enabled libsnappy         && require libsnappy snappy-c.h snappy_compress -lsnappy -lstdc++
diff --git a/doc/general_contents.texi b/doc/general_contents.texi
index c48c812..8fd2423 100644
--- a/doc/general_contents.texi
+++ b/doc/general_contents.texi
@@ -1475,6 +1475,7 @@ performance on systems without hardware floating point support).
 @item OSS               @tab X      @tab X
 @item PulseAudio        @tab X      @tab X
 @item SDL               @tab        @tab X
+@item SIXEL             @tab        @tab X
 @item Video4Linux2      @tab X      @tab X
 @item VfW capture       @tab X      @tab
 @item X11 grabbing      @tab X      @tab
diff --git a/doc/outdevs.texi b/doc/outdevs.texi
index f0484bb..efde39d 100644
--- a/doc/outdevs.texi
+++ b/doc/outdevs.texi
@@ -472,6 +472,75 @@ SDL window, forcing its size to the qcif format:
 ffmpeg -i INPUT -c:v rawvideo -pix_fmt yuv420p -window_size qcif -f sdl "SDL output"
 @end example
 
+@section SIXEL
+
+SIXEL output device.
+
+This output device allows one to show a video stream in SIXEL terminals.
+
+To enable this output device you need to configure FFmpeg with
+@code{--enable-libsixel}.
+libsixel is a codec library that outputs SIXEL control sequences.
+
+For more information about libsixel, check:
+@url{http://saitoha.github.io/libsixel/}
+
+@subsection Options
+
+@table @option
+
+@item left
+Set the left position in cells to display @command{ffmpeg} output.
+
+@item top
+Set the top position in cells to display @command{ffmpeg} output.
+
+@item reqcolors
+Set the limit number of colors.
+
+@item fixedpal
+If set to @option{true}, built-in fixed palette is used to apply color quantization.
+
+@item diffuse
+Select dithering algorithm.
+@option{none}
+@option{fs}
+@option{atkinson}
+@option{jajuni}
+@option{stucki}
+@option{burkes}
+
+@item scene-threshold
+
+@item dropframe
+
+@item ignoredelay
+
+@end table
+
+@subsection Examples
+
+@itemize
+@item
+The following command shows the @command{ffmpeg} output is a
+SIXEL terminal,
+@example
+ffmpeg -i INPUT -vcodec rawvideo -pix_fmt rgb24 -s 640x480 -f sixel -
+@end example
+
+@item
+Show the list of available drivers and exit:
+@example
+ffmpeg -i INPUT -vcodec rawvideo -pix_fmt rgb24 -s 640x480 -reqcolors 16 -f sixel -
+@end example
+
+@item
+Show the list of available dither colors and exit:
+@example
+ffmpeg -i INPUT -pix_fmt rgb24 -f caca -list_dither colors -
+@end example
+@end itemize
+
 @section sndio
 
 sndio audio output device.
diff --git a/libavdevice/Makefile b/libavdevice/Makefile
index c304492..96e4bce 100644
--- a/libavdevice/Makefile
+++ b/libavdevice/Makefile
@@ -43,6 +43,7 @@ OBJS-$(CONFIG_PULSE_INDEV)               += pulse_audio_dec.o \
 OBJS-$(CONFIG_PULSE_OUTDEV)              += pulse_audio_enc.o \
                                             pulse_audio_common.o
 OBJS-$(CONFIG_SDL2_OUTDEV)               += sdl2.o
+OBJS-$(CONFIG_SIXEL_OUTDEV)              += sixel.o
 OBJS-$(CONFIG_SNDIO_INDEV)               += sndio_dec.o sndio.o
 OBJS-$(CONFIG_SNDIO_OUTDEV)              += sndio_enc.o sndio.o
 OBJS-$(CONFIG_V4L2_INDEV)                += v4l2.o v4l2-common.o timefilter.o
diff --git a/libavdevice/alldevices.c b/libavdevice/alldevices.c
index 8a90fcb..26cad18 100644
--- a/libavdevice/alldevices.c
+++ b/libavdevice/alldevices.c
@@ -47,6 +47,7 @@ extern const FFOutputFormat ff_oss_muxer;
 extern const AVInputFormat  ff_pulse_demuxer;
 extern const FFOutputFormat ff_pulse_muxer;
 extern const FFOutputFormat ff_sdl2_muxer;
+extern const FFOutputFormat ff_sixel_muxer;
 extern const AVInputFormat  ff_sndio_demuxer;
 extern const FFOutputFormat ff_sndio_muxer;
 extern const AVInputFormat  ff_v4l2_demuxer;
diff --git a/libavdevice/sixel.c b/libavdevice/sixel.c
new file mode 100644
index 0000000..82db4a4
--- /dev/null
+++ b/libavdevice/sixel.c
@@ -0,0 +1,477 @@
+/*
+ * Copyright (c) 2014 Hayaki Saito
+ *
+ * This file is part of FFmpeg.
+ *
+ * FFmpeg is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * FFmpeg is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with FFmpeg; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/signal.h>
+#include <termios.h>
+#include <sys/ioctl.h>
+#include <sys/select.h>
+#include <time.h>
+#include <sixel.h>
+#include "libavutil/opt.h"
+#include "libavutil/pixdesc.h"
+#include "avdevice.h"
+#include "libavutil/time.h"
+#include "libavformat/mux.h"
+#include "libavcodec/avcodec.h"
+
+#if !defined(SIXELAPI)
+#  define LIBSIXEL_LEGACY_API
+#  define SIXEL_OK    (0)
+#  define SIXEL_FALSE (-1)
+#  define SIXEL_SUCCEEDED(status) (((status) & 0x1000) == 0)
+#  define SIXEL_FAILED(status)    (((status) & 0x1000) != 0)
+typedef int SIXELSTATUS;
+#endif
+
+typedef struct SIXELContext {
+    AVClass *class;
+    AVRational time_base;   /* time base */
+    int64_t    time_frame;  /* current time */
+    AVRational framerate;
+    int top;
+    int left;
+    int reqcolors;
+    sixel_output_t *output;
+    sixel_dither_t *dither;
+    sixel_dither_t *testdither;
+    int fixedpal;
+    enum methodForDiffuse diffuse;
+    int threshold;
+    int dropframe;
+    int ignoredelay;
+} SIXELContext;
+
+static FILE *sixel_output_file = NULL;
+
+static int detect_scene_change(SIXELContext *const c)
+{
+    int score;
+    int i;
+    unsigned int r = 0;
+    unsigned int g = 0;
+    unsigned int b = 0;
+    static unsigned int average_r = 0;
+    static unsigned int average_g = 0;
+    static unsigned int average_b = 0;
+    static int previous_histgram_colors = 0;
+    int histgram_colors = 0;
+    int palette_colors = 0;
+    unsigned char const* palette;
+
+    histgram_colors = sixel_dither_get_num_of_histogram_colors(c->testdither);
+
+    if (c->dither == NULL)
+        goto detected;
+
+    /* detect scene change if number of colors increses 20% */
+    if (previous_histgram_colors * 6 < histgram_colors * 5)
+        goto detected;
+
+    /* detect scene change if number of colors decreses 20% */
+    if (previous_histgram_colors * 4 > histgram_colors * 5)
+        goto detected;
+
+    palette_colors = sixel_dither_get_num_of_palette_colors(c->testdither);
+    palette = sixel_dither_get_palette(c->testdither);
+
+    /* compare color difference between current
+     * palette and previous one */
+    for (i = 0; i < palette_colors; i++) {
+        r += palette[i * 3 + 0];
+        g += palette[i * 3 + 1];
+        b += palette[i * 3 + 2];
+    }
+    score = (r - average_r) * (r - average_r)
+          + (g - average_g) * (g - average_g)
+          + (b - average_b) * (b - average_b);
+    if (score > c->threshold * palette_colors
+                             * palette_colors)
+        goto detected;
+
+    return 0;
+
+detected:
+    previous_histgram_colors = histgram_colors;
+    average_r = r;
+    average_g = g;
+    average_b = b;
+    return 1;
+}
+
+static SIXELSTATUS prepare_static_palette(SIXELContext *const c,
+                                          AVCodecContext *const codec)
+{
+    if (c->dither) {
+        sixel_dither_set_body_only(c->dither, 1);
+    } else {
+        c->dither = sixel_dither_get(BUILTIN_XTERM256);
+        if (c->dither == NULL)
+            return SIXEL_FALSE;
+        sixel_dither_set_diffusion_type(c->dither, c->diffuse);
+    }
+    return SIXEL_OK;
+}
+
+
+static void scroll_on_demand(int pixelheight,
+                             int specified_top,
+                             int specified_left)
+{
+    struct winsize size = {0, 0, 0, 0};
+    struct termios old_termios;
+    struct termios new_termios;
+    int top = 0;
+    int left = 0;
+    int cellheight;
+    int scroll;
+    fd_set rfds;
+    struct timeval tv;
+    int ret = 0;
+
+    ioctl(STDOUT_FILENO, TIOCGWINSZ, &size);
+    if (size.ws_ypixel <= 0) {
+        fprintf(sixel_output_file, "\033[H\0337");
+        return;
+    }
+    /* set the terminal to cbreak mode */
+    tcgetattr(STDIN_FILENO, &old_termios);
+    memcpy(&new_termios, &old_termios, sizeof(old_termios));
+    new_termios.c_lflag &= ~(ECHO | ICANON);
+    new_termios.c_cc[VMIN] = 1;
+    new_termios.c_cc[VTIME] = 0;
+    tcsetattr(STDIN_FILENO, TCSAFLUSH, &new_termios);
+
+    /* request cursor position report */
+    fprintf(sixel_output_file, "\033[6n");
+    /* wait 1 sec */
+    tv.tv_sec = 1;
+    tv.tv_usec = 0;
+    FD_ZERO(&rfds);
+    FD_SET(STDIN_FILENO, &rfds);
+    ret = select(STDIN_FILENO + 1, &rfds, NULL, NULL, &tv);
+    if (ret != (-1)) {
+        if (scanf("\033[%d;%dR", &top, &left) == 2) {
+            if (specified_top > 0)
+                top = specified_top;
+            if (specified_left > 0)
+                left = specified_left;
+            fprintf(sixel_output_file, "\033[%d;%dH", top, left);
+            cellheight = pixelheight * size.ws_row / size.ws_ypixel + 1;
+            scroll = cellheight + top - size.ws_row + 1;
+            if (scroll > 0) {
+                fprintf(sixel_output_file, "\033[%dS\033[%dA", scroll, scroll);
+            }
+            fprintf(sixel_output_file, "\0337");
+        } else {
+            if (specified_top > 0)
+                top = specified_top;
+            if (specified_left > 0)
+                left = specified_left;
+            if (top < 1)
+                top = 1;
+            if (left < 1)
+                left = 1;
+            fprintf(sixel_output_file, "\033[%d;%dH\0337", top, left);
+        }
+    }
+
+    tcsetattr(STDIN_FILENO, TCSAFLUSH, &old_termios);
+}
+
+
+static SIXELSTATUS prepare_dynamic_palette(SIXELContext *const c,
+                                           AVCodecContext *const codec,
+                                           AVPacket *const pkt)
+{
+    SIXELSTATUS status = SIXEL_FALSE;
+
+    /* create histgram and construct color palette
+     * with median cut algorithm. */
+    status = sixel_dither_initialize(c->testdither, pkt->data,
+                                     codec->width, codec->height, 3,
+                                     LARGE_NORM, REP_CENTER_BOX,
+                                     QUALITY_LOW);
+    if (SIXEL_FAILED(status))
+        return status;
+
+    /* check whether the scence is changed. use old palette
+     * if scene is not changed. */
+    if (detect_scene_change(c)) {
+        if (c->dither)
+            sixel_dither_unref(c->dither);
+        c->dither = c->testdither;
+#if defined(LIBSIXEL_LEGACY_API)
+        c->testdither = sixel_dither_create(c->reqcolors);
+        if (c->testdither == NULL)
+            return SIXEL_FALSE;
+#else
+        status = sixel_dither_new(&c->testdither, c->reqcolors, NULL);
+        if (SIXEL_FAILED(status))
+            return status;
+#endif
+        sixel_dither_set_diffusion_type(c->dither, c->diffuse);
+    } else {
+        sixel_dither_set_body_only(c->dither, 1);
+    }
+
+    return status;
+}
+
+static int sixel_write(char *data, int size, void *priv)
+{
+    return fwrite(data, 1, size, (FILE *)priv);
+}
+
+static AVCodecContext *codecpar2codec(const AVCodecParameters *codecpar)
+{
+    AVCodecContext *result = NULL;
+    AVCodec *codec = NULL;
+    
+    if ((codec = avcodec_find_decoder(codecpar->codec_id)) == NULL) {
+        fprintf(stderr, "Failed to get avcodec_find_decoder();");
+        return NULL;
+	}
+    if ((result = avcodec_alloc_context3(codec)) == NULL) {
+        fprintf(stderr, "Failed to get avcodec_alloc_context3();");
+        return NULL;
+    }
+    if (avcodec_parameters_to_context(result, codecpar) < 0) {
+        fprintf(stderr, "Failed to get avcodec_parameters_to_context();");
+        return NULL;
+    }
+    return result;
+}
+
+static int sixel_write_header(AVFormatContext *s)
+{
+    SIXELContext *c = s->priv_data;
+    AVCodecContext *codec = codecpar2codec(s->streams[0]->codecpar);
+    
+    SIXELSTATUS status = SIXEL_FALSE;
+
+    if (s->nb_streams > 1
+        || codec->codec_type != AVMEDIA_TYPE_VIDEO
+        || codec->codec_id   != AV_CODEC_ID_RAWVIDEO) {
+        av_log(s, AV_LOG_ERROR, "Only supports one rawvideo stream\n");
+        return AVERROR(EINVAL);
+    }
+
+    if (codec->pix_fmt != AV_PIX_FMT_RGB24) {
+        av_log(s, AV_LOG_ERROR,
+               "Unsupported pixel format '%s', choose rgb24\n",
+               av_get_pix_fmt_name(codec->pix_fmt));
+        return AVERROR(EINVAL);
+    }
+
+    if (!s->url || strcmp(s->url, "pipe:") == 0) {
+        sixel_output_file = stdout;
+#if defined(LIBSIXEL_LEGACY_API)
+        c->output = sixel_output_create(sixel_write, stdout);
+        status = c->output == NULL ? SIXEL_FALSE: SIXEL_OK;
+#else
+        status = sixel_output_new(&c->output, sixel_write, stdout, NULL);
+#endif
+    } else {
+        sixel_output_file = fopen(s->url, "w");
+#if defined(LIBSIXEL_LEGACY_API)
+        c->output = sixel_output_create(sixel_write, sixel_output_file);
+        status = c->output == NULL ? SIXEL_FALSE: SIXEL_OK;
+#else
+        status = sixel_output_new(&c->output, sixel_write, sixel_output_file, NULL);
+#endif
+    }
+
+    if (SIXEL_FAILED(status)) {
+#if !defined(LIBSIXEL_LEGACY_API)
+        av_log(s, AV_LOG_ERROR, "%s\n", sixel_helper_format_error(status));
+#endif
+        return AVERROR_EXTERNAL;
+    }
+
+    if (isatty(fileno(sixel_output_file))) {
+        fprintf(sixel_output_file, "\033[?25l");      /* hide cursor */
+    } else {
+        c->ignoredelay = 1;
+    }
+
+    /* don't use private color registers for each frame. */
+    fprintf(sixel_output_file, "\033[?1070l");
+
+    c->dither = NULL;
+#if defined(LIBSIXEL_LEGACY_API)
+    c->testdither = sixel_dither_create(c->reqcolors);
+    status = c->testdither == NULL ? SIXEL_FALSE: SIXEL_OK;
+#else
+    status = sixel_dither_new(&c->testdither, c->reqcolors, NULL);
+#endif
+
+    if (SIXEL_FAILED(status)) {
+#if !defined(LIBSIXEL_LEGACY_API)
+        av_log(s, AV_LOG_ERROR, "%s\n", sixel_helper_format_error(status));
+#endif
+        return AVERROR_EXTERNAL;
+    }
+
+    c->time_base = codecpar2codec(s->streams[0]->codecpar)->time_base;
+    c->time_frame = av_gettime() / av_q2d(c->time_base);
+
+    return 0;
+}
+
+static int sixel_write_packet(AVFormatContext *s, AVPacket *pkt)
+{
+    SIXELContext * const c = s->priv_data;
+    AVCodecContext * const codec = codecpar2codec(s->streams[0]->codecpar);
+    int64_t curtime, delay;
+    struct timespec ts;
+    int late_threshold;
+    static int dirty = 0;
+    SIXELSTATUS status = SIXEL_FALSE;
+
+    if (!c->ignoredelay) {
+        /* calculate the time of the next frame */
+        c->time_frame += INT64_C(1000000);
+        curtime = av_gettime();
+        delay = c->time_frame * av_q2d(c->time_base) - curtime;
+        if (delay <= 0) {
+            if (c->dropframe) {
+                /* late threshold of dropping this frame */
+                late_threshold = INT64_C(-1000000) * av_q2d(c->time_base);
+                if (delay < late_threshold)
+                    return 0;
+            }
+        } else {
+            ts.tv_sec = delay / 1000000;
+            ts.tv_nsec = (delay % 1000000) * 1000;
+            nanosleep(&ts, NULL);
+        }
+    }
+
+    if (dirty == 0) {
+        scroll_on_demand(codec->height, c->top, c->left);
+        dirty = 1;
+    }
+    fprintf(sixel_output_file, "\0338");
+
+    if (c->fixedpal) {
+        status = prepare_static_palette(c, codec);
+    } else {
+        status = prepare_dynamic_palette(c, codec, pkt);
+    }
+    if (SIXEL_FAILED(status)) {
+#if !defined(LIBSIXEL_LEGACY_API)
+        av_log(s, AV_LOG_ERROR, "%s\n", sixel_helper_format_error(status));
+#endif
+        return AVERROR_EXTERNAL;
+    }
+    status = sixel_encode(pkt->data, codec->width, codec->height,
+                          PIXELFORMAT_RGB888,
+                          c->dither, c->output);
+    if (SIXEL_FAILED(status)) {
+#if !defined(LIBSIXEL_LEGACY_API)
+        av_log(s, AV_LOG_ERROR, "%s\n", sixel_helper_format_error(status));
+#endif
+        return AVERROR_EXTERNAL;
+    }
+    fflush(sixel_output_file);
+    return 0;
+}
+
+static int sixel_write_trailer(AVFormatContext *s)
+{
+    SIXELContext * const c = s->priv_data;
+
+    if (isatty(fileno(sixel_output_file))) {
+        fprintf(sixel_output_file,
+                "\033\\"      /* terminate DCS sequence */
+                "\033[?25h"); /* show cursor */
+    }
+
+    fflush(sixel_output_file);
+    if (sixel_output_file && sixel_output_file != stdout) {
+        fclose(sixel_output_file);
+        sixel_output_file = NULL;
+    }
+    if (c->output) {
+        sixel_output_unref(c->output);
+        c->output = NULL;
+    }
+    if (c->testdither) {
+        sixel_dither_unref(c->testdither);
+        c->testdither = NULL;
+    }
+    if (c->dither) {
+        sixel_dither_unref(c->dither);
+        c->dither = NULL;
+    }
+
+    return 0;
+}
+
+#define OFFSET(x) offsetof(SIXELContext, x)
+#define ENC AV_OPT_FLAG_ENCODING_PARAM
+static const AVOption options[] = {
+    { "left",            "left position",          OFFSET(left),        AV_OPT_TYPE_INT,    {.i64 = 0},                0, 256,  ENC },
+    { "top",             "top position",           OFFSET(top),         AV_OPT_TYPE_INT,    {.i64 = 0},                0, 256,  ENC },
+    { "reqcolors",       "number of colors",       OFFSET(reqcolors),   AV_OPT_TYPE_INT,    {.i64 = 16},               2, 256,  ENC },
+    { "fixedpal",        "use fixed palette",      OFFSET(fixedpal),    AV_OPT_TYPE_INT,    {.i64 = 0},                0, 1,    ENC, "fixedpal" },
+    { "true",            NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = 1},                0, 0,    ENC, "fixedpal" },
+    { "false",           NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = 0},                0, 0,    ENC, "fixedpal" },
+    { "diffuse",         "dithering method",       OFFSET(diffuse),     AV_OPT_TYPE_INT,    {.i64 = DIFFUSE_ATKINSON}, 1, 6,    ENC, "diffuse" },
+    { "none",            NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = DIFFUSE_NONE},     0, 0,    ENC, "diffuse" },
+    { "fs",              NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = DIFFUSE_FS},       0, 0,    ENC, "diffuse" },
+    { "atkinson",        NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = DIFFUSE_ATKINSON}, 0, 0,    ENC, "diffuse" },
+    { "jajuni",          NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = DIFFUSE_JAJUNI},   0, 0,    ENC, "diffuse" },
+    { "stucki",          NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = DIFFUSE_STUCKI},   0, 0,    ENC, "diffuse" },
+    { "burkes",          NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = DIFFUSE_BURKES},   0, 0,    ENC, "diffuse" },
+#if 0  /* for debugging */
+    { "scene-threshold", "scene change threshold", OFFSET(threshold),   AV_OPT_TYPE_INT,    {.i64 = 500},              0, 10000,ENC },
+    { "dropframe",       "drop late frames",       OFFSET(dropframe),   AV_OPT_TYPE_INT,    {.i64 = 1},                0, 1,    ENC, "dropframe" },
+    { "true",            NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = 1},                0, 0,    ENC, "dropframe" },
+    { "false",           NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = 0},                0, 0,    ENC, "dropframe" },
+    { "ignoredelay",     "ignore frame timestamp", OFFSET(ignoredelay), AV_OPT_TYPE_INT,    {.i64 = 0},                0, 1,    ENC, "ignoredelay" },
+    { "true",            NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = 1},                0, 0,    ENC, "ignoredelay" },
+    { "false",           NULL,                     0,                   AV_OPT_TYPE_CONST,  {.i64 = 0},                0, 0,    ENC, "ignoredelay" },
+#endif
+    { NULL },
+};
+
+static const AVClass sixel_class = {
+    .class_name = "sixel_outdev",
+    .item_name  = av_default_item_name,
+    .option     = options,
+    .version    = LIBAVUTIL_VERSION_INT,
+    .category   = AV_CLASS_CATEGORY_DEVICE_VIDEO_OUTPUT,
+};
+
+const FFOutputFormat ff_sixel_muxer = {
+    .p.name           = "sixel",
+    .p.long_name      = NULL_IF_CONFIG_SMALL("SIXEL terminal device"),
+    .priv_data_size   = sizeof(SIXELContext),
+    .p.audio_codec    = AV_CODEC_ID_NONE,
+    .p.video_codec    = AV_CODEC_ID_RAWVIDEO,
+    .write_header     = sixel_write_header,
+    .write_packet     = sixel_write_packet,
+    .write_trailer    = sixel_write_trailer,
+    .p.flags          = AVFMT_NOFILE, /* | AVFMT_VARIABLE_FPS, */
+    .p.priv_class     = &sixel_class,
+};
