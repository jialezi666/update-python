#!/usr/bin/env bash
#安装依赖
if cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"	
	yum install openssl openssl-devel zlib-devel gcc -y

	elif  cat /etc/issue | grep -Eqi "ubuntu|debian"; then
    release="debian/ubuntu"
	apt-get update
	apt-get install -y zlib1g-dev gcc make libssl-dev libffi-dev OpenSSL
fi
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
mv /usr/bin/python3 /usr/bin/python3.old
ln -s /usr/local/python3.6/bin/python3 /usr/bin/python3
cp -R /usr/local/python3.6/lib/* /usr/lib64/
cp -R /usr/local/python3.6/lib/* /usr/lib/

#安装pip和setuptool
#wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
#python3 get-pip.py

#编译安装
#安装pip前需要前置安装setuptools
wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-19.6.tar.gz#md5=c607dd118eae682c44ed146367a17e26
tar -zxvf setuptools-19.6.tar.gz
cd setuptools-19.6
python3 setup.py build
python3 setup.py install
#安装pip 
wget --no-check-certificate https://pypi.python.org/packages/source/p/pip/pip-8.0.2.tar.gz#md5=3a73c4188f8dbad6a1e6f6d44d117eeb
tar -zxvf pip-8.0.2.tar.gz
cd pip-8.0.2
python3 setup.py build
python3 setup.py install


if [ $? -eq 0 ];then
     echo "pip3升级完成"
else
     echo "pip3安装失败，查看报错信息手动安装"
fi
mv /usr/bin/pip3 /usr/bin/pip3.old
ln -s /usr/local/python3.6/bin/pip3 /usr/bin/pip3

