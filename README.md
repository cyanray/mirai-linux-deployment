
# mirai linux 部署脚本
目前仅支持 centos / debian / ubuntu 系统

## mirai-linux-gitee

**如果服务器无法访问 GitHub 则使用这个版本**

mirai-linux-gitee.sh 执行的操作: 
1. 安装 openjdk-11-jdk
2. 安装 git
3. 克隆 [gitee](https://gitee.com/cyanray/mirai-linux) 仓库到 tmp 文件夹，内含最新的 mirai-console-wrapper、mirai-console-addition 和 mirai-http-api
4. 复制文件到正确的位置
5. 设置 mirai-console-wrapper 的启动权限
6. 删除 tmp 文件夹
7. 启动 mirai-console-wrapper

依次执行以下指令:

```bash
# mirai-linux-gitee.sh
wget --no-check-certificate -O mirai-linux-gitee.sh https://webplus-cn-hangzhou-s-5e5a2d1c60533f0bea484374.oss-cn-hangzhou.aliyuncs.com/mirai-linux-gitee.sh

chmod +x mirai-linux.sh

sudo ./mirai-linux.sh
```

## mirai-linux

mirai-linux.sh 执行的操作: 
1. 安装 openjdk-11-jdk
2. 从 mirai-console-wrapper、mirai-console-addition 和 mirai-http-api 的 github 仓库中下载发布的二进制文件
3. 复制文件到正确的位置
4. 设置 mirai-console-wrapper 的启动权限
5. 删除临时文件
6. 启动 mirai-console-wrapper

依次执行以下指令:

```bash
# mirai-linux.sh
wget --no-check-certificate -O mirai-linux.sh https://github.com/cyanray/mirai-linux-deployment/raw/master/mirai-linux.sh
chmod +x mirai-linux.sh
sudo ./mirai-linux.sh
```

