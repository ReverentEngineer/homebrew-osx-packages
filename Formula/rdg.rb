class RDG < Formula

  desc "A tool for generating data based on regular expressions"
  homepage "http://reverentengineer.com/rdg"
  url "https://github.com/ReverentEngineer/rdg/archive/v1.0.0.tar.gz"  
  sha256 "52306326a4107147841da55797ac9c9e3ac391959f1ff78ee6abcdbbd0ba6f25"
  license "MIT"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "flex"
  depends_on "bison"
  
  def install
    mkdir_p "build"
    chdir "build"
    system "cmake","-DCMAKE_INSTALL_PREFIX=#{prefix}",".."
    system "make"
    system "make","test"
    system "make","install" 
  end

  test do
  
    system bin/"rdg", "--version"

    system bin/"rdg", "test[123]", "."

    open("1") do |f|
      permutation = f.read(5)
      assert_equal pemutation, "test1"
    end

    open("2") do |f|
      permutation = f.read(5)
      assert_equal pemutation, "test2"
    end

    open("3") do |f|
      permutation = f.read(5)
      assert_equal pemutation, "test3"
    end
  end
end
