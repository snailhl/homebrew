require "formula"

class I2util < Formula
  homepage "http://software.internet2.edu/"
  url "http://software.internet2.edu/sources/I2util/I2util-1.2.tar.gz"
  sha1 "56218a6e0f1306a70b641246fa6f63dd686e6766"

  bottle do
    cellar :any
    sha1 "14336de85e35136a369e889d1072adf866998f09" => :yosemite
    sha1 "c88dd13937831bab2efd3ad928d54635a48ef129" => :mavericks
    sha1 "eced6a87c580fe024730ca09fa61c6a5e3cc4d63" => :mountain_lion
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <I2util/util.h>
      #include <string.h>
      int main() {
        uint8_t buf[2];
        if (!I2HexDecode("beef", buf, sizeof(buf))) return 1;
        if (buf[0] != 190 || buf[1] != 239) return 1;
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-lI2util", "-o", "test"
    system "./test"
  end
end
