#!/bin/bash
# 输入设计项目名称
echo "Please input project name: "
read NAME

# 在脚本所在位置的上级目录建立项目文件夹
cd $(dirname $0); # 进入脚本所在文件夹
cd ../
# 若项目已经存在，则停止运行
if test -e "$NAME"; then
    echo "ERROR: The project $NAME exist!"
    exit 0
fi
mkdir $NAME

# 建立设计文件夹 RTL Testbench
cd ./$NAME
DESIGN_DIR=$(pwd) # 设计文件夹的路径
# design files
mkdir RTL
mkdir Testbench

# 建立仿真文件夹 VCS
mkdir VCS
touch ./VCS/asic.f
cp ../init/Makefile ./VCS

# 建立综合文件夹 Syn
mkdir Syn
cd ./Syn
mkdir analyze
mkdir mapped
mkdir report
mkdir script
mkdir unmapped
mkdir work
cp ../../init/.synopsys_dc.setup ./work
cp ../../init/flow.tcl ./script
# 修改 .synopsys_dc.setup 中的内容
sed -i "1 i set         SYN_ROOT_PATH       ${DESIGN_DIR}" ./work/.synopsys_dc.setup
cd ../

# algorithm simulation
mkdir Algorithm
cp ../init/VerilogTools.py ./Algorithm/
