FROM centos:7.4.1708
MAINTAINER xjd <xing.jiudong@trans-cosmos.com.cn>

ENV MAJOR_VERSION=8u181 \
    MINOR_VERSION=b13 \
    RANDOM_NUM=96a7b8442fe848ef90c96a2fad6ed6d1
ENV JDK_VERSION=${MAJOR_VERSION}-${MINOR_VERSION}
ENV JDK_DOWNLOAD_URL=http://download.oracle.com/otn-pub/java/jdk/${JDK_VERSION}/${RANDOM_NUM}/jdk-${MAJOR_VERSION}-linux-x64.tar.gz

RUN set -x && \
    yum update y && \
    yum install -y curl ca-certificates wget unzip && \
    yum clean all

# Install Oracle JDK 
RUN mkdir /opt/java && \
    curl -L -o /opt/java/jdk-${MAJOR_VERSION}-linux-x64.tar.gz -H "Cookie: oraclelicense=accept-securebackup-cookie" -k ${JDK_DOWNLOAD_URL} && \
    tar xf /opt/java/jdk-${MAJOR_VERSION}-linux-x64.tar.gz -C /opt/java && \
    rm -f /opt/java/jdk-${MAJOR_VERSION}-linux-x64.tar.gz && \
    ln -s /opt/java/jdk* /opt/java/default && \
    ln -s /opt/java/jdk /opt/java/jvm

# Define commonly used JAVA_HOME variable
# Add /opt/java and jdk on PATH variable
ENV JAVA_HOME=/opt/java/default \
    PATH=${PATH}:/opt/java/default/bin:/opt/java

# Define default command.
CMD [ "/bin/bash", "-l"]
