require 'formula'

class Icu4c521 < Formula
  homepage 'http://site.icu-project.org/'
  url 'http://download.icu-project.org/files/icu4c/53.1/icu4c-53_1-src.tgz'
  version '53.1'
  sha256 "6fa74fb5aac070c23eaba1711a7178fe582c59867484c5ec07c49002787a9a28"
  head 'http://source.icu-project.org/repos/icu/icu/trunk/', :using => :svn

  keg_only "Conflicts; see: https://github.com/Homebrew/homebrew/issues/issue/167"

  conflicts_with "icu4c", :because => "Differing versions of same formula"

  option :universal
  option :cxx11

  def install
    ENV.universal_binary if build.universal?
    ENV.cxx11 if build.cxx11?

    args = ["--prefix=#{prefix}", "--disable-samples", "--disable-tests", "--enable-static"]
    args << "--with-library-bits=64" if MacOS.prefer_64_bit?
    cd "source" do
      system "./configure", *args
      system "make", "VERBOSE=1"
      system "make", "VERBOSE=1", "install"
    end
  end
end
