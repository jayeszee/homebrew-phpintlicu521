require 'formula'

class Icu4c521 < Formula
  homepage 'http://site.icu-project.org/'
  url 'http://download.icu-project.org/files/icu4c/52.1/icu4c-52_1-src.tgz'
  version '52.1'
  sha256 "2f4d5e68d4698e87759dbdc1a586d053d96935787f79961d192c477b029d8092"
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
