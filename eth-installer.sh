#!/bin/bash

#First we need to perform some housekeeping & install dependencies
apt-get -y update
apt-get -y upgrade
dpkg-reconfigure locales
apt-get -y install raspi-copies-and-fills build-essential git scons cmake nodejs npm ntp cloud-utils golang libboost-all-dev automake unzip libgmp-dev libgmp3-dev libtool libleveldb-dev yasm libminiupnpc-dev libreadline-dev libncurses5-dev libcurl4-openssl-dev wget libjsoncpp-dev libargtable2-dev clang-3.5 lldb-3.5 libmicrohttpd-dev clang-3.5-doc clang-3.5-examples clang-format-3.5 clang-modernize-3.5 cpp11-migrate-3.5 libclang-3.5-dev libclang-common-3.5-dev libclang1-3.5 libclang1-3.5-dbg liblldb-3.5 liblldb-3.5-dev libllvm-3.5-ocaml-dev libllvm3.5 libllvm3.5-dbg lldb-3.5-dev llvm-3.5 llvm-3.5-dev llvm-3.5-doc llvm-3.5-examples llvm-3.5-runtime llvm-3.5-tools python-clang-3.5 python-lldb-3.5

#We must compile cryptopp & json-rpc-cpp from source "the old way" for armhf

#Cryptopp
git clone https://github.com/mmoss/cryptopp.git
cd cryptopp
scons --shared --prefix=/usr
cd ..

#Json-rpc-cpp	
git clone git://github.com/cinemast/libjson-rpc-cpp.git
mkdir -p libjson-rpc-cpp/build
cd libjson-rpc-cpp/build
cmake .. 
make
make install
ldconfig	
cd ../..

#Now lets install Ethereum 
#If this is your first time playing around with Ethereum, I would suggest starting with `geth`
git clone https://github.com/ethereum/cpp-ethereum
cd cpp-ethereum
git checkout develop
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUNDLE=minimal
make -j2
cd ../..

#Finally we can run `geth` by going to the proper directory and executign the `./geth` command:
cd ~/cpp-ethereum/build/eth/
./eth
