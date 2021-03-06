class GccArmNoneEabi < Formula

  desc "gcc for cross-compiling to ARM"
  homepage "https://www.gnu.org/software/gcc"
  url "https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.gz"  
  sha256 "27e879dccc639cd7b0cc08ed575c1669492579529b53c9ff27b0b96265fa867d"
  license all_of: ["GPL-2.0-or-later", "GPL-3.0-or-later", "LGPL-2.0-or-later", "LGPL-3.0-only"]
  revision 1


  depends_on "binutils-arm-none-eabi"

  def install

	args = %W[
      --prefix=#{prefix}
      --target=arm-none-eabi
      --enable-internetwork
      --enable-mulitlib
      --disable-nls
      --disable-werror
      --enable-languages=c,c++
      --without-headers
      --with-newlib
      --disable-libssp
    ]    

    envvars = %W[
      AR_FOR_TARGET=arm-none-eabi-ar \
	  AS_FOR_TARGET=arm-none-eabi-as \
	  LD_FOR_TARGET=arm-none-eabi-ld \
	  NM_FOR_TARGET=arm-none-eabi-nm \
  	  OBJDUMP_FOR_TARGET=arm-none-eabi-objdump \
	  RANLIB_FOR_TARGET=arm-none-eabi-ranlib \
	  READELF_FOR_TARGET=arm-none-eabi-readelf \
	  STRIP_FOR_TARGET=arm-none-eabi-strip
    ]

    system "./contrib/download_prerequisites"
    mkdir_p "build"
    chdir "build"
    system "../configure",*args
    system "make"
    system "make","install" 
  end

end
