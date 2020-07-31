class Samba < Formula

  desc "The standard Windows interoperability suite of programs for Linux and Unix."
  homepage "https://www.samba.org/"
  url "https://download.samba.org/pub/samba/stable/samba-4.12.5.tar.gz"
  sha256 "54b41cc6378acae20dd155ba55d78ff171875c2eaa3f05f87b485d3d6891b815"
  license "GPL-3.0"
  revision 1

  keg_only :shadowed_by_macos, "macOS provides a different version of Samba"

  depends_on "pkg-config" => :build

  depends_on "python3"
  depends_on "readline"
  depends_on "libarchive"
  depends_on "gnutls"
  depends_on "perl"
  depends_on "jansson"

  resource "Parse::Yapp" do
    url "https://cpan.metacpan.org/authors/id/W/WB/WBRASWELL/Parse-Yapp-1.21.tar.gz"
    sha256 "3810e998308fba2e0f4f26043035032b027ce51ce5c8a52a8b8e340ca65f13e5"
  end

  patch do
    url "https://gist.githubusercontent.com/ReverentEngineer/4d521076e799ad379e0e0e439a5e6cdf/raw/0fbc69e7bb1de03109e8dbcd96cef241e988d4ff/samba-osx.patch"
    sha256 "d4a599e8a981ac9b13fc1f1c492d5ae0f254d996fa2a09a5cb0da92276ad0e0d"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", libexec/"lib"
    ENV.prepend_path "PATH",libexec/"bin"

    resources.each do |res|
      res.stage do
        if File.exist? "Makefile.PL"
          system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
          system "make", "PERL5LIB=#{ENV["PERL5LIB"]}"
          system "make", "install"
        else
          system "perl", "Build.PL", "--install_base", libexec
          system "./Build", "PERL5LIB=#{ENV["PERL5LIB"]}"
          system "./Build", "install"
        end
      end
    end


    args = %W[
      --without-acl-support
      --prefix=#{prefix}
    ]

    system "./buildtools/bin/waf", "configure",*args
    system "./buildtools/bin/waf", "build"
    system "./buildtools/bin/waf", "install"
  end

  test do
    system bin/"samba-tool", "--version"
  end
end
