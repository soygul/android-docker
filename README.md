# Android Docker

Dockerfile for building Android projects inside a container.
Contains Android SDK and NDK.
Based on Ubuntu LTS for maximum compatiblity.

## Building

Following commands assume that your project source code is at the root of this repo.

```
# build Docker image first
docker build -t android-docker .

# now build the Android project using Gradle wrapper
docker run -it --rm -v $PWD:/home/build android-docker ./gradlew build
```

After a successful build, all build artficats will be in their respective locations as if you built the project natively on your computer.
