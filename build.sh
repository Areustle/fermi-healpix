cd src/cxx
autoconf
./configure --prefix=${PREFIX} --with-libcfitsio=${PREFIX} 
make
make install
