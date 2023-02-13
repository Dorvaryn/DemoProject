FROM gitpod/workspace-full

ENV ANDROID_HOME "/home/gitpod/.android"
ENV ANDROID_SDK_ROOT "/home/gitpod/.android"
ENV SDK_TOOLS "9477386_latest"
ENV PATH=$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# Install required dependencies
RUN bash -c "mkdir -p ${ANDROID_HOME} && mkdir -p ${ANDROID_HOME}/cmdline-tools"

RUN bash -c "wget -q https://dl.google.com/android/repository/commandlinetools-linux-${SDK_TOOLS}.zip -O /tmp/tools.zip && \    
    unzip -qq /tmp/tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
    rm -v /tmp/tools.zip"

# Install SDK Packages
ENV BUILD_TOOLS "32.1.0-rc1"
ENV TARGET_SDK "32"

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh \
             && sdk install java 11.0.10.j9-adpt && \ 
             export JAVA_HOME=`sdk home java 11.0.10.j9-adpt` && \
             touch /home/gitpod/.android/repositories.cfg && \
    yes | ${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/sdkmanager \"--licenses\" && \
    ${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/sdkmanager \"--update\" && \
    ${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/sdkmanager \"platform-tools\" \"extras;android;m2repository\" \"extras;google;m2repository\" \"extras;google;instantapps\" && \
    ${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/sdkmanager \"build-tools;${BUILD_TOOLS}\" \"platforms;android-${TARGET_SDK}\""

# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/

