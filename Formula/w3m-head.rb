class W3mHead < Formula
  desc "Pager/text based browser"
  homepage "https://w3m.sourceforge.io/"
  revision 7
  head "https://github.com/tats/w3m.git", branch: "master"

  stable do
    current_commit = "ee66aabc3987000c2851bce6ade4dcbb0b037d81"
    url "https://github.com/tats/w3m.git",
      branch:   "master",
      revision: current_commit
    version "git-#{current_commit[0..7]}"
  end

  livecheck do
    url "https://deb.debian.org/debian/pool/main/w/w3m/"
    regex(/href=.*?w3m[._-]v?(\d+(?:\.\d+)+)\.orig\.t/i)
  end

  keg_only "conflict with 'homebrew/core/w3m'"

  depends_on "pkg-config" => :build
  depends_on "bdw-gc"
  depends_on "gdk-pixbuf"
  depends_on "libsixel"
  depends_on "openssl@3"

  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  on_linux do
    depends_on "gettext"
    depends_on "libbsd"
  end

  def install
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    system "./configure", "--prefix=#{prefix}",
                          "--enable-image",
                          "--with-imagelib=gdk-pixbuf",
                          "--enable-keymap=lynx",
                          "--with-ssl=#{Formula["openssl@3"].opt_prefix}"
    system "make", "install"
  end

  test do
    assert_match "DuckDuckGo", shell_output("#{bin}/w3m -dump https://duckduckgo.com")
  end
end
