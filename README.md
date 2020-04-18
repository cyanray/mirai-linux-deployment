
# mirai linux 部署脚本
目前仅支持 centos / debian / ubuntu 系统

执行的操作: 
1. 安装 openjdk-11-jdk
2. 下载 mirai-console-wrapper-v0.3.0.jar
3. 下载并安装 mirai-http-api 插件
4. 下载并安装 mirai-console-addition 插件

依次执行以下指令:

```bash
wget --no-check-certificate -O mirai-linux.sh https://raw.githubusercontent.com/cyanray/mirai-linux-deployment/master/mirai-linux.sh
chmod +x mirai-linux.sh
sudo ./mirai-linux.sh
```