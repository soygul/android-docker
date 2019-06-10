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

## Testing

It's best to use a device farm to test your app on real devices, i.e. [Firebase Test Lab](https://firebase.google.com/docs/test-lab)
However if you want to test your app in an emulator inside a container, check the following resources:

* Ready to use Docker image for Android emulator: https://github.com/budtmo/docker-android
* Native support for Android emulator inside containers is emerging (experimental): https://androidstudio.googleblog.com/2019/05/emulator-ci-docker-scripts-for-linux.html
