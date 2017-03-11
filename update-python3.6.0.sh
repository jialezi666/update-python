#!/usr/bin/env bash
#安装依赖
yum install openssl openssl-devel zlib-devel gcc -y
# apt-get install libssl-dev 
# apt-get install openssl openssl-devel
# 下载源码
wget --no-check-certificate https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tgz
tar -zxvf Python-3.6.0.tgz
cd Python-3.6.0
mkdir /usr/local/python3.6.0
sed '467s/^#//g' Module/Setup
./configure --prefix=/usr/local/python3.6 --enable-shared
make
make install
if [ $? -eq 0 ];then
     echo "Python3.6.0升级完成"
else
     echo "Python3.6.0升级失败，查看报错信息手动安装"
fi

ln -s /usr/local/python3.6/bin/python3 /usr/bin/python3
cp -R /usr/local/python3.6/lib/* /usr/lib64/
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
if [ $? -eq 0 ];then
     echo "pip升级完成"
else
     echo "pip安装失败，查看报错信息手动安装"
fi

ln -s /usr/local/python3.6/bin/pip3 /usr/bin/pip3

