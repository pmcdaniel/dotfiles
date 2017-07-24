# Since paths are loaded before others I'm going to go ahead and export
# these environment variables so I don't have to redefine them

export ANDROID_HOME=$HOME/Toolchains/Android
export ANDROID_NDK_HOME=$HOME/Toolchains/Android-NDK

export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK_HOME
