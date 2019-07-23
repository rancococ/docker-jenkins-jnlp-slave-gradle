# from registry.cn-hangzhou.aliyuncs.com/rancococ/jenkins-jnlp-slave:3.29.3-alpine
FROM registry.cn-hangzhou.aliyuncs.com/rancococ/jenkins-jnlp-slave:3.29.3-alpine

# maintainer
MAINTAINER "rancococ" <rancococ@qq.com>

# set arg info
ARG GRADLE_VERSION=3.5.1
ARG GRADLE_HOME=/usr/local/gradle
ARG GRADLE_URL=https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip

# set environment
ENV GRADLE_HOME=${GRADLE_HOME}

# set current user
USER root

# install gradle
RUN curl --create-dirs -fsSLo /tmp/gradle/gradle.zip ${GRADLE_URL} && \
    mkdir -p ${GRADLE_HOME} && \
    unzip -qo /tmp/gradle/gradle.zip -d /tmp/gradle/ && \
    \cp -rf /tmp/gradle/gradle-${GRADLE_VERSION}/. ${GRADLE_HOME} && \
    chown -R jenkins:jenkins ${GRADLE_HOME} && \
    ln -s ${GRADLE_HOME}/bin/gradle /usr/local/bin/gradle && \
    \rm -rf /tmp/gradle

# set current user
USER jenkins
