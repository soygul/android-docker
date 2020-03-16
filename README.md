# Android Docker
Dockerfile for building Android projects inside a container.
Contains Android SDK and NDK.
Based on Ubuntu LTS for maximum compatiblity.

# Repos
* GitHub Repo: https://github.com/soygul/android-docker
* Docker Hub Repo: https://hub.docker.com/r/soygul/android-docker

## Video Tutorial
I did some of the development work of this project live for a YouTube tutorial.
It also demonstrates how to use this project to build a sample Android app from source.
If you want to see it, you can watch it here: [https://www.youtube.com/watch?v=wRAIY-RLSvo](https://www.youtube.com/watch?v=wRAIY-RLSvo)

## Building
Following commands assume that your project source code is at `/build` directory of this repo, and your project's Gradle wrapper executable is located at `/build/gradlew`.
Alternatively, you can adjust `$(pwd)/build` in the second command to point to your Android project source.

Build the Docker image first. Skip this step if you want to use the Docker Hub image:

```
docker build -f docker/Dockerfile -t soygul/android-docker .
```

Now build the Android project using Gradle wrapper:

```
docker run -it --rm -v $(pwd)/build:/root/build soygul/android-docker ./gradlew build
```

After a successful build, all build artficats will be in their respective locations as if you built the project natively on your computer.

## Android SDK/NDK and Build Tools Versions
By default, this image uses the latest version of Android SDK/NDK and Android Build Tools.
If you need a different versions, change them accordingly in the [Dockerfile](docker/Dockerfile) and rebuild the image using the commands given above.

## Testing
It's best to use a device farm to test your app on real devices, i.e. [Firebase Test Lab](https://firebase.google.com/docs/test-lab)
However if you want to test your app in an emulator inside a container, check the following resources:

* Ready to use Docker image for Android emulator: https://github.com/budtmo/docker-android
* Native support for Android emulator inside containers is emerging (experimental): https://androidstudio.googleblog.com/2019/05/emulator-ci-docker-scripts-for-linux.html

## Security Note
While building the image, Dockerfile scripts only have access to files residing in the `/docker` directory for security reasons.
If you need any file from `/build` directory during image build, you should copy them to `/docker` directory.
Note that this is only true during image building process.
Running container will have full access to `/build` directory.
