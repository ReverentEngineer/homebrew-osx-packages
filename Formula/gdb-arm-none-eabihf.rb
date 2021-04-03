class GccArmNoneEabihf < Formula

  desc "gdb for debugging ARM binaries"
  homepage "https://www.gnu.org/software/gdb"
  url "https://ftp.gnu.org/gnu/gdb/gdb-10.1.tar.gz" 
  sha256 "f12f388b99e1408c01308c3f753313fafa45517740c81ab7ed0d511b13e2cf55"
  license all_of: ["GPL-2.0-or-later", "GPL-3.0-or-later", "LGPL-2.0-or-later", "LGPL-3.0-only"]
  revision 1

  depends_on "binutils-arm-none-eabihf"
  depends_on "gcc-arm-none-eabihf"

  def install

	args = %W[
      --prefix=#{prefix}
      --target=arm-none-eabihf
    ]    

    mkdir_p "build"
    chdir "build"
    system "../configure",*args
    system "make"
    system "make","install" 
  end

end
