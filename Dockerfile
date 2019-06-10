# https://hub.docker.com/_/ubuntu
FROM ubuntu:18.04

# java jdk: android sdk tools require it
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk

# install android sdk
ENV ANDROID_HOME=/root
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools
RUN curl -L https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o sdktools.zip && \
    unzip sdktools.zip -d /root && \
    rm sdktools.zip
RUN mkdir ~/.android && touch ~/.android/repositories.cfg && \
    yes | sdkmanager "platform-tools" "build-tools;28.0.3" "platforms;android-28"

# install android ndk
# 'ndk-bundle' is the default directory name when NDK is installed through Android Studio so reusing that naming convention
RUN curl -L https://dl.google.com/android/repository/android-ndk-r20-linux-x86_64.zip -o androidndk.zip && \
    unzip androidndk.zip -d /root && \
    rm androidndk.zip && \
    mv /root/android-ndk* /root/ndk-bundle

# setup env vars and paths
ENV CONTAINER=true \
    ANDROID_SDK_PATH=/root \
    ANDROID_SDK_ROOT=/root \
    ANDROID_NDK_PATH=/root/ndk-bundle \
    ANDROID_NDK_ROOT=/root/ndk-bundle

WORKDIR /home/build
