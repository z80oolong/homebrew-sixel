class FfmpegCurrent < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  license "GPL-2.0-or-later"
  revision 7

  stable do
    url "https://ffmpeg.org/releases/ffmpeg-8.0.1.tar.xz"
    sha256 "05ee0b03119b45c0bdb4df654b96802e909e0a752f72e4fe3794f487229e5a41"

    patch :p1, Formula["z80oolong/sixel/ffmpeg@8.0.1"].diff_data

    patch do
      url "https://code.ffmpeg.org/FFmpeg/FFmpeg/pulls/21567.patch"
      sha256 "96ea7f9458b851288ae4cc78e30741beb2d88350f7411da2576faac5f74126b6"
    end
  end

  head do
    url "https://github.com/FFmpeg/FFmpeg.git", branch: "master"

    patch :p1, Formula["z80oolong/sixel/ffmpeg@9999-dev"].diff_data
  end

  keg_only "it conflicts with 'homebrew/core/ffmpeg'"

  depends_on "pkgconf" => :build
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

  def install
    ENV.append_rpath full_name

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
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end

module EnvExtend
  def ENV.append_rpath(*append_list)
    apaths = (append_list.map do |f_name|
      Formula[f_name].opt_lib
    end).join(":")

    if (rpaths = fetch("HOMEBREW_RPATH_PATHS", false))
      self["HOMEBREW_RPATH_PATHS"] = "#{apaths}:#{rpaths}"
    end
  end
end

ENV.extend(EnvExtend)
