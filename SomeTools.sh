#!/bin/bash

function yum_install()
{
  tool=$1
  package=$(rpm -qa | grep $tool | wc -l)
  if [ $package -eq 0 ];then
    yum install -y $tool
  else
    echo "$tool is already installed !"
  fi
}

function pip_install()
{ 
  result=$(pip freeze | grep $1)
  if [ ! $result ];then
    pip install $1
  else
    echo "$1 is already installed !"
  fi
}

function tig_install()
{
  if command -v tig >/dev/null 2>&1 ;then
    echo "tig is already installed !"
  else
    git clone https://github.com/jonas/tig
    cd tig
    make && make install
    cd ../
    rm -rf tig
  fi
}

function fzf_install()
{
  if command -v fzf >/dev/null 2>&1 ;then
    echo "fzf is already installed !"
  else
    git clone https://github.com/junegunn/fzf /root/fzf
    cd fzf
    ./install
    cd ../
  fi
}

function ranger_install()
{
  if command -v ranger >/dev/null 2>&1 ;then
    echo "ranger is already installed !"
  else
    git clone http://git.sv.gnu.org/r/ranger
    cd ranger
    python setup.py install
    cd ../
    rm -rf ranger
  fi
}

function ripgrep_install()
{
  if [ ! -f "/etc/yum.repo.d/carlwgeorge-ripgrep-epel-7.repo" ];then
    wget -P /etc/yum.repo.d/ https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    yum clean all
    yum makecache
  fi
}

#epel
yum_install epel-release

#1.ncdu
yum_install ncdu

#2.ag
yum_install the_silver_searcher

#3.tig
yum_install ncurses-devel
tig_install

#4.multitail
yum_install multitail

#5.shellcheck
yum_install ShellCheck

#6.fzf
fzf_install

#7.htop
yum_install htop

#8.axel
yum_install axel

#9.cloc
yum_install cloc

#10.tmux

#11.icdiff
pip_install icdiff

#12.glances
#pip_install glances[action,browser,cloud,cpuinfo,chart,docker,export,folders,gpu,ip,raid,snmp,web,wifi]

#13.cheat
pip_install cheat

#14.ranger
ranger_install

#15.ripgrep
ripgrep_install
yum_install ripgrep

#16.
