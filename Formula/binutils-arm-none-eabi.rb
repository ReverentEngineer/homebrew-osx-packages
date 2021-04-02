class BinutilsArmNoneEabihf < Formula

  desc "binutils for cross-compiling to ARM"
  homepage "https://www.gnu.org/software/binutils"
  url "https://ftp.gnu.org/gnu/binutils/binutils-2.36.1.tar.gz"  
  sha256 "e68edeaaeb6ca9687b6dcbaedd1b376506baad2d48de26a885fc5ab6acb839da"
  license all_of: ["GPL-2.0-or-later", "GPL-3.0-or-later", "LGPL-2.0-or-later", "LGPL-3.0-only"]
  revision 1

  def install

	args = %W[
      --prefix=#{prefix}
      --target=arm-none-eabi
      --enable-internetwork
      --enable-mulitlib
      --disable-nls
      --disable-werror
    ]    

    mkdir_p "build"
    chdir "build"
    system "../configure",*args
    system "make"
    system "make","install" 
  end

end
