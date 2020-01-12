# Android Docker

Dockerfile for building Android projects inside a container.
Contains Android SDK and NDK.
Based on Ubuntu LTS for maximum compatiblity.

## Building

Following commands assume that your project source code is at `/src` of this repo, and your project's Gradle wrapper executable is located at `/src/gradlew`.

```
# build Docker image first
docker build -f build/Dockerfile -t android-docker .

# now build the Android project using Gradle wrapper
docker run -it --rm -v $(pwd)/src:/root/build android-docker ./gradlew build
```

After a successful build, all build artficats will be in their respective locations as if you built the project natively on your computer.

## Testing

It's best to use a device farm to test your app on real devices, i.e. [Firebase Test Lab](https://firebase.google.com/docs/test-lab)
However if you want to test your app in an emulator inside a container, check the following resources:

* Ready to use Docker image for Android emulator: https://github.com/budtmo/docker-android
* Native support for Android emulator inside containers is emerging (experimental): https://androidstudio.googleblog.com/2019/05/emulator-ci-docker-scripts-for-linux.html

## Security Note

While building the image, Dockerfile scripts only have access to files residing in the `/build` directory for security reasons.
If you need any file from `/src` directory during image build, you should copy them to `/build` directory.
Note that this is only true during image building process.
Running container will have full access to `/src` directory.
