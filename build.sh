cd healpix_cxx
autoreconf -i
./configure --prefix=${PREFIX} --with-libcfitsio=${SYS_PREFIX} 
make
make install
