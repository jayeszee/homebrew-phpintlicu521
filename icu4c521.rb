require 'formula'

class Icu4c521 < Formula
  homepage 'http://site.icu-project.org/'
  url 'http://download.icu-project.org/files/icu4c/61.1/icu4c-61_1-src.tgz'
  version '61.1'
  sha256 "d007f89ae8a2543a53525c74359b65b36412fa84b3349f1400be6dcf409fafef"
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
