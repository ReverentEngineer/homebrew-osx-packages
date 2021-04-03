class GccArmNoneEabihf < Formula

  desc "gcc for cross-compiling to ARM"
  homepage "https://www.gnu.org/software/gcc"
  url "https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz"  
  sha256 "27e879dccc639cd7b0cc08ed575c1669492579529b53c9ff27b0b96265fa867d"
  license all_of: ["GPL-2.0-or-later", "GPL-3.0-or-later", "LGPL-2.0-or-later", "LGPL-3.0-only"]
  revision 1


  depends_on "binutils-arm-none-eabihf"

  def install

	args = %W[
      --prefix=#{prefix}
      --target=arm-none-eabihf
      --enable-internetwork
      --enable-mulitlib
      --disable-nls
      --disable-werror
      --enable-languages=c,c++
      --without-headers
      --with-newlib
      --disable-libssp
      --disable-libstdc++-v3
    ]    

    envvars = %W[
      AR_FOR_TARGET=arm-none-eabihf-ar \
	  AS_FOR_TARGET=arm-none-eabihf-as \
	  LD_FOR_TARGET=arm-none-eabihf-ld \
	  NM_FOR_TARGET=arm-none-eabihf-nm \
  	  OBJDUMP_FOR_TARGET=arm-none-eabihf-objdump \
	  RANLIB_FOR_TARGET=arm-none-eabihf-ranlib \
	  READELF_FOR_TARGET=arm-none-eabihf-readelf \
	  STRIP_FOR_TARGET=arm-none-eabihf-strip
    ]

    system "./contrib/download_prerequisites"
    mkdir_p "build"
    chdir "build"
    system "../configure",*args
    system "make"
    system "make","install" 
  end

end
