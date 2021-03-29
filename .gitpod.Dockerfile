FROM gitpod/workspace-full-vnc

ENV ANDROID_HOME "/home/gitpod/.android"
ENV ANDROID_SDK_ROOT "/home/gitpod/.android" 
ENV SDK_TOOLS "6858069_latest"
ENV PATH=$PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# Install required dependencies
RUN bash -c "mkdir -p ${ANDROID_HOME} && mkdir -p ${ANDROID_HOME}/cmdline-tools"

RUN bash -c "wget -q https://dl.google.com/android/repository/commandlinetools-linux-${SDK_TOOLS}.zip -O /tmp/tools.zip && \    
    unzip -qq /tmp/tools.zip -d ${ANDROID_HOME}/cmdline-tools && \
    rm -v /tmp/tools.zip"

# Install SDK Packages
ENV BUILD_TOOLS "30.0.2"
ENV TARGET_SDK "30"

RUN bash -c ". /home/gitpod/.sdkman/bin/sdkman-init.sh \
             && sdk install java 11.0.10.j9-adpt && \ 
             export JAVA_HOME=`sdk home java 11.0.10.j9-adpt` && \
             touch /home/gitpod/.android/repositories.cfg && \
    yes | ${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/sdkmanager \"--licenses\" && \
    ${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/sdkmanager \"--update\" && \
    ${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/sdkmanager \"platform-tools\" \"extras;android;m2repository\" \"extras;google;m2repository\" \"extras;google;instantapps\" && \
    ${ANDROID_HOME}/cmdline-tools/cmdline-tools/bin/sdkmanager \"build-tools;${BUILD_TOOLS}\" \"platforms;android-${TARGET_SDK}\""

RUN bash -c "wget -q https://download.jetbrains.com/idea/ideaIC-2020.3.3.tar.gz -O /tmp/idea.tar.gz && \
    sudo tar -xzf /tmp/idea.tar.gz -C /opt && \
    rm -v /tmp/idea.tar.gz"
    
RUN sudo bash -c "echo '-Dsun.java2d.xrender=false' >> /opt/idea-IC-203.7717.56/bin/idea.vmoptions && \
    vncserver -depth 24"
# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/

