class W3mCurrent < Formula
  desc "Pager/text based browser"
  homepage "https://w3m.sourceforge.net/"
  license "w3m"
  head "https://github.com/tats/w3m.git", branch: "master"
  revision 7

  stable do
    url "https://deb.debian.org/debian/pool/main/w/w3m/w3m_0.5.3+git20230121.orig.tar.xz"
    sha256 "974d1095a47f1976150a792fe9c5a44cc821c02b6bdd714a37a098386250e03a"
    version "0.5.3-git20230121"

    # Fix for CVE-2023-4255
    patch do
      url "https://sources.debian.org/data/main/w/w3m/0.5.3%2Bgit20230121-2.1/debian/patches/0002-CVE-2023-4255.patch"
      sha256 "7a84744bae63f3e470b877038da5a221ed8289395d300a904ac5a8626b0a9cea"
    end
  end

  livecheck do
    url "https://deb.debian.org/debian/pool/main/w/w3m/"
    regex(/href=.*?w3m[._-]v?(\d+(?:\.\d+)+(?:\+git\d+)?)\.orig\.t/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match.first.tr("+", "-") }
    end
  end

  keg_only "conflict with 'homebrew/core/w3m'"

  depends_on "pkgconf" => :build
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
    ENV.append "CFLAGS", "-std=gnu17"
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
