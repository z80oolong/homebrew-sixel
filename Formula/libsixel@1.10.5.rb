class LibsixelAT1105 < Formula
  desc "SIXEL encoder/decoder implementation (fork 1.10.5 + security patches)"
  homepage "https://github.com/libsixel/libsixel"
  url "https://github.com/libsixel/libsixel/archive/refs/tags/v1.10.5.tar.gz"
  sha256 "b6654928bd423f92e6da39eb1f40f10000ae2cc6247247fc1882dcff6acbdfc8"
  license "MIT"
  revision 1

  # CVE-2025-9300
  patch :p1 do
    file "Patches/libsixel@1.10.5/fix-cve-2025-9300-fix.diff"
    type :unofficial
  end

  # CVE-2025-61146
  patch :p1 do
    file "Patches/libsixel@1.10.5/fix-cve-2025-61146-fix.diff"
    type :unofficial
  end

  # CVE-2026-110601
  patch :p1 do
    file "Patches/libsixel@1.10.5/fix-cve-2026-110601-fix.diff"
    type :unofficial
  end

  keg_only "this is an alternate version of another formula"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "jpeg-turbo"
  depends_on "libpng"

  def install
    system "meson", "setup", "build",
           "-Dtests=disabled",
           "-Dgdk-pixbuf2=disabled",
           "-Dlibcurl=disabled",
           *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    fixture = test_fixtures("test.png")
    system bin/"img2sixel", fixture
  end
end
