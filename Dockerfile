FROM openjdk:8-jdk


ENV ANDROID_COMPILE_SDK "25"
ENV ANDROID_BUILD_TOOLS "24.0.0"
ENV ANDROID_SDK_TOOLS "24.4.1"
ENV ANDROID_SDK_LICENSE "d56f5187479451eabf01fb78af6dfcb131a6481e"
ENV ANDROID_SDK_PREVIEW_LICENSE "84831b9409646a918e30573bab4c9c91346d8abd"
ENV ANDROID_HOME "/android-sdk-linux"

RUN apt-get --quiet update --yes \
&& apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
&& wget --quiet --output-document=android-sdk.tgz https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz \
&& tar --extract --gzip --file=android-sdk.tgz \
&& mkdir -p android-sdk-linux/licenses \
&& echo ${ANDROID_SDK_LICENSE} >> android-sdk-linux/licenses/android-sdk-license \
&& echo ${ANDROID_SDK_PREVIEW_LICENSE} >> android-sdk-linux/licenses/android-sdk-preview-license \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_COMPILE_SDK} \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS} \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services \
&& echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository \
&& export PATH=$PATH:${ANDROID_HOME}/android-sdk-linux/platform-tools/
