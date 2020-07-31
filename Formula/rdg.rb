class Rdg < Formula

  desc "A tool for generating data based on regular expressions"
  homepage "http://reverentengineer.com/rdg"
  url "https://github.com/ReverentEngineer/rdg/archive/v1.0.0.tar.gz"  
  sha256 "577871d44584f78a335a10cbdf741eb48d6b64ac6a4b435bd53caae3a5240748"
  license "MIT"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "flex"
  depends_on "bison"
  depends_on "python3"
  
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
