DevOps安装笔记

1. centos系统

2. 修改IP地址
   vi /etc/sysconf ig/network-scripts/ifcfg-ens33

BOOTPROTO=static #dhcp改为static（修改）
ONBOOT=yes #开机启用本配置，一般在最后一行（修改） 
IPADDR=192.168.171.131  # IP地址（重要）。
NETMARSK=255.255.255.0  # 子网掩码（重要）。
GATEWAY=192.168.171.2  # 网关（重要）。
DNS1=114.114.114.114
DNS2=1.2.4.8

重启网卡
service network restart

3. docker、docker-compose的安装
   docker
     安装需要的软件包：
     yum install -y yum-utils device-mapper-persistent-data lvm2
     设置下载源为阿里云：
     yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
     安装docker
    yum -y install docker-ce
     启动docker，开启自启：

    # 启动Docker服务

    systemctl start docker

    # 设置开机自动启动

    systemctl enable docker
     测试docker
    docker version

docker-compose
docker compose 安装
  下载
  https://github.com/docker/compose/tags
  给运行权限：
  chmod a+x docker-compose-Linux-x86_64
  移动位置：
  mv docker-compose-Linux-x86_64 /usr/bin/docker-compose 
  测试是否可以运行：
  docker-compose version

4. 拉取gitlab镜像：
   docker search gitlab/gitlab
     docker pull gitlab/gitlab-ce 
     准备docker-compose.yml文件，放入/usr/local/docker/docker-gitlab

------------------------

version: '3.1'
services:
  gitlab:
    image: 'gitlab/gitlab-ce:latest'
    container_name: gitlab
    restart: always
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://192.168.171.201:8929'
        gitlab_rails['gitlab_shell_ssh_port'] = 2224
    ports:
      - '8929:8929'
      - '2224:2224'
    volumes:
      - './config:/etc/gitlab'
      - './logs:/var/log/gitlab'
      - './data:/var/opt/gitlab'
------------------------

  启动：docker-compose up -d
  日志查看： docker-compose logs -f
  访问：http://192.168.171.201:8929/
  获取账号密码：docker exec -it gitlab bash；docker exec -it gitlab cat /etc/gitlab/initial_root_password
  aR3S7qJ1UGZ/kEXafy9EN3H8rx4Lj8OMsogVSCol7pM=
15

5. 拉取 Jenkins
   docker pull jenkins/jenkins:2.387.2
   0b9fe7fd48f24aec9fc864ba029bbc4d

-------------------------

version: "3.1"
services:
  jenkins:
    image: jenkins/jenkins:2.387.2
    container_name: jenkins
    ports:
      - 8080:8080
      - 50000:50000
    volumes:
      - ./data/:/var/jenkins_home/
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
      - /etc/docker/daemon.json:/ect/docker/daemon.json
-------------------------

权限不足处理：chmod -R a+w data/

修改下载源：
------------

# 修改数据卷中的hudson.model.UpdateCenter.xml文件

<?xml version='1.1' encoding='UTF-8'?>
<sites>
  <site>
    <id>default</id>
    <url>https://updates.jenkins.io/update-center.json</url>
  </site>
</sites>

# 将下载地址替换为http://mirror.esuni.jp/jenkins/updates/update-center.json

<?xml version='1.1' encoding='UTF-8'?>
<sites>
  <site>
    <id>default</id>
    <url>http://mirror.esuni.jp/jenkins/updates/update-center.json</url>
  </site>
</sites>

# 清华大学的插件源也可以

https://mirrors.tuna.tsinghua.edu.cn/jenkins/updates/update-center.json
-----------------

密码：日志中： 04b169e002094a1d9f9b5fc9e43c8678，或者进入容器查看
如果启动还是未能正常访问可以看防火墙：# systemctl stop firewalld
10
配置Git
下载插件 over ssh、git pa...、SonarQube Scanner
构建代码
增加maven jdk到jenkins环境中
tar -zxvf apache-maven-3.6.3-bin.tar.gz -C /usr/local/docker/jenkins/data/
编译项目：
clean package -DskipTests
发送jar包到对应文件
target/*.jar

构建dockerFile
-------------

FROM daocloud.io/library/java:8u40-jdk
COPY mytest.jar /usr/local/
WORKDIR /usr/local

CMD java -jar mytest.jar
-------------

构建docker-compose
-------------

version: "3.1"
services:
  mytest:
    build:
      context: ./
      dockerfile: Dockerfile
    image: mytest:v1.0.0
    container_name: mytest
    ports:
      - 8080:8080
-------------

ssh 远程命令
cd /usr/local/test/docker
mv ../target/*jar ./
docker-compose down
docker-compose up -d --build
docker image prune -f

备注：最好勾选 Verbose output in console、Exec timeout (ms)设置为0


6. 拉取 sonarqube
   docker pull sonarqube:9.9.4-community

------

version: '3.1'
services:
  db:
    image: postgres
    container_name: db
    ports:
      - 5432:5432
    networks:
      - sonarnet
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
  sonarqube:
    image: sonarqube:9.9.4-community
    container_name: sonarqube
    depends_on:
      - db
    ports:
      - 9000:9000
    networks:
      - sonarnet
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://db:5432/sonar
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonar
networks:
  sonarnet:
    driver: bridge
------

异常处理：bootstrap check failure [1] of [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
修改sysctl.conf
vi /ect/sysctl.conf
vm.max_map_count=262144
重启配置：sysctl -p
http://192.168.171.202:9000/
admin admin
扫描插件：sonar-scanner 放入 jenkins下的data 目录进行解压
修改扫描配置文件：conf/sonar-scanner.properties
参数操作
sonar.projectName=${JOB_NAME}
sonar.projectKey=${JOB_NAME}
sonar.sources=./
sonar.java.binaries=target

7. harbor

https://goharbor.io/
  Harbor12345
  解压压缩包：
  tar -zxvf harbor-offline-installer-v2.3.4.tgz -C /usr/local/
  修改配置文件：
  cp harbor.yml.tmpl harbor.yml
  注释https\hostname修改
  启动：./install.sh
  访问：http://192.168.171.202/account/sign-in?redirect_url=%2Fharbor%2Fprojects
  admin Harbor12345
服务器配置
  docker 推送 harbor地址/harbor项目名称/镜像名称:版本
  vi /etc/docker/daemon.json
  {
  "insecure-registries" : ["192.168.171.202:80"]
  }
  重启docker systemctl restart docker

  docker tag 9b5c4890d94b 192.168.171.202:80/repo/mytest:v1.0.0
  docker login -u admin -p Harbor12345 192.168.171.202:80
  docker push 192.168.171.202:80/repo/mytest:v1.0.0 
  docker pull 192.168.171.202:80/repo/mytest:v1.0.0

  mv target/*.jar docker/
  docker build -t mytest:$tag docker/
  docker login -u admin -p Harbor12345 192.168.171.202:80
  docker tag mytest:$tag 192.168.171.202:80/repo/mytest:$tag
  docker push 192.168.171.202:80/repo/mytest:$tag
----无tag版本
  mv target/*.jar docker/
  docker build -t mytest:latest docker/
  docker login -u admin -p Harbor12345 192.168.171.202:80
  docker tag mytest:latest 192.168.171.202:80/repo/mytest:latest
  docker push 192.168.171.202:80/repo/mytest:latest
  docker image prune -f
-------

集成jenkins
使用宿主机docker，通过映射功能
cd /var/run
映射 docker.sock
设置权限
chown root:root docker.sock

chmod o+rw docker.sock
-----

修改数据卷映射
version: "3.1"
services:
  jenkins:
    image: jenkins/jenkins:2.387.2
    container_name: jenkins
    ports:
      - 8080:8080
      - 50000:50000
    volumes:
      - ./data/:/var/jenkins_home/
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker

      - /etc/docker/daemon.json:/ect/docker/daemon.json
-------

编写远程服务器脚本
1.告知目标服务器拉取哪个镜像
2.判断当前服务器是否正在运行容器，需要删除
3.如果目标服务器已经存在当前镜像，需要删除
4.目标服务器拉取harbor上的镜像
5.将拉取下来的镜像运行成容器

harbor_url=$1
harbor_project_name=$2
project_name=$3
tag=$4
port=$5
containerPort=$6

imageName=$harbor_url/$harbor_project_name/$project_name:$tag
echo $imageName
containerId=`docker ps -a | grep ${project_name} | awk '{print $1}'`
if [ "$containerId" != "" ] ; then
  docker stop $containerId
  docker rm $containerId
  echo "Delete Container Success"
fi
imageId=`docker images | grep ${project_name} | awk '{print $3}'`
if [ "$imageId" != "" ] ; then
  docker rmi -f $imageId
  echo "Delete Image Success"
fi
docker login -u admin -p Harbor12345 $harbor_addr
docker pull $imageName
docker run -d -p $port:$containerPort --name $project_name $imageName
echo "Start Container Success"
echo $project_name

deploy.sh $harborAddress $harvorRepo $JOB_NAME $tag $container_port $host_port

deploy.sh 192.168.171.129:80 repo pipeline v3.0.0 8080 8081
-----------------

构建流水线
优势更快发现问题
使用自带语法生成器进行生成

脚本
------

//所有的脚本放入pipeline
//所有的脚本放入pipeline
pipeline {
    //任务节点
    agent any

    environment {
        harborUser = 'admin'
        harborPasswd = 'Harbor12345'
        harborAddress = '192.168.171.202:80'
        harvorRepo = 'repo'
    }
    
    stages {
        stage('拉取代码') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '8bb55916-b89a-4ef2-a277-583db53ffc2c', url: 'http://192.168.171.201:8929/root/mytest.git']])
                echo '拉取代码'
            }
        }
        stage('maven构建') {
            steps {
                sh '/var/jenkins_home/apache-maven-3.6.3/bin/mvn clean package -DskipTests'
                echo 'maven构建'
            }
        }
        stage('sonarqube 检查') {
            steps {
                sh '/var/jenkins_home/sonar-scanner/bin/sonar-scanner -Dsonar.source=./ -Dsonar.projectname=${JOB_NAME} -Dsonar.projectKey=${JOB_NAME} -Dsonar.java.binaries=./target -Dsonar.login=sqa_a9542674d0eab2e21c8b7b93ee966432c52e0e6f'
                echo 'sonarqube 检查'
            }
        }
         stage('制作镜像') {
            steps {
                sh '''mv target/*.jar ./docker/
                docker build -t ${JOB_NAME}:latest ./docker/'''
                echo '制作镜像'
            }
        }
        stage('推送harbor') {
            steps {
                sh '''docker login -u ${harborUser} -p ${harborPasswd} ${harborAddress}
                docker tag ${JOB_NAME}:latest ${harborAddress}/${harvorRepo}/${JOB_NAME}:latest
                docker push ${harborAddress}/${harvorRepo}/${JOB_NAME}:latest
                docker image prune -f'''
                echo '推送harbor'
            }
        }
        stage('通知目标服务器'){
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'test', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: "deploy.sh ${harborAddress} ${harvorRepo} ${JOB_NAME} latest 8010 8080", execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }

//         stage('yml推送k8s') {
//             steps {
//                 sshPublisher(publishers: [sshPublisherDesc(configName: 'k8s', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'pipeline.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
//                 echo '通知目标服务器'
//             }
//         }
//         stage('k8s 部署') {
//             steps {
//                sh 'ssh root@192.168.171.130 kubectl apply -f /usr/local/k8s/pipeline.yaml'
//                 echo 'k8s 部署'
//             }
//         }
    }
}

-----

-----------------

8. k8s相关教程
   https://kuboard.cn/learning/k8s-basics/k8s-core-concepts.html#%E4%BB%80%E4%B9%88%E6%98%AFkubernetes
   安装教程：
   https://kuboard.cn/
   k8s
   hostnamectl set-hostname k8sMaster

# 只在 master 节点执行

# 替换 x.x.x.x 为 master 节点实际 IP（请使用内网 IP）

# export 命令只在当前 shell 会话中有效，开启新的 shell 窗口后，如果要继续安装过程，请重新执行此处的 export 命令

export MASTER_IP=192.168.171.130

# 替换 apiserver.demo 为 您想要的 dnsName

export APISERVER_NAME=pwdtest.demo

# Kubernetes 容器组所在的网段，该网段安装完成后，由 kubernetes 创建，事先并不存在于您的物理网络中

export POD_SUBNET=10.100.0.1/16
echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts
curl -sSL https://kuboard.cn/install-script/v1.19.x/init_master.sh | sh -s 1.19.5

# 只在 master 节点执行

# 替换 x.x.x.x 为 master 节点实际 IP（请使用内网 IP）

# export 命令只在当前 shell 会话中有效，开启新的 shell 窗口后，如果要继续安装过程，请重新执行此处的 export 命令

export MASTER_IP=192.168.171.130

# 替换 apiserver.demo 为 您想要的 dnsName

export APISERVER_NAME=pwdtest.demo
echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts
kubeadm join pwdtest.demo:6443 --token 5bjir9.faiaae706wj8ofys     --discovery-token-ca-cert-hash sha256:315201d771bbc2ddee52ad0cbca97226dcb76a7e0fa3eabfe2030fe68ed7d112 

curl -ik https://pwdtest.demo:6443

jenkins 无密码 ssh登录k8s的master
docker exec -it eae09ca7de7e bash
ssh-keygen -t rsa
ssh-copy-id root@192.168.171.130

配置k8s上docker库的位置 配置-》密文->增加docker账号
配置所在服务器docker的仓库数据

