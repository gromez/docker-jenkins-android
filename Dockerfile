FROM ubuntu:14.10
MAINTAINER gromez "jerome.groven@gmail.com"

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y

RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN echo deb http://pkg.jenkins-ci.org/debian binary/ >> /etc/apt/sources.list
RUN apt-get install -y wget
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN apt-get update
RUN apt-get install -y jenkins

RUN apt-get install -y curl
WORKDIR /opt
RUN curl -O http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz
RUN tar xzf android-sdk_r24.0.2-linux.tgz
RUN rm -f android-sdk_r24.0.2-linux.tgz

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

RUN android update sdk --no-ui

RUN apt-get install -y git-core

EXPOSE 8080
