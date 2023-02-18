#!/usr/bin/env bash

JAVA=`cat java`

# Crontab list
# 0 */6 * * * /mnt/d/etec/cdmd+1.19/backup.sh
# 0 */1 * * * /mnt/d/etec/cdmd+1.19/incbak.sh

# crontab -l | sed "/^[^#].*\/mnt\/d\/etec\/cdmd+1.19\/incbak.sh/s/^/#/" | crontab -
# crontab -l | sed "/^[^#].*\/mnt\/d\/etec\/cdmd+1.19\/backup.sh/s/^/#/" | crontab -
#if $JAVA equals "java" execute java -version
if [ "$JAVA" = "java" ]; then
  JAVA=`which java`
  if [ "$?" != "0" ]; then
    echo "Unable to find java executable. Please set JAVA environment variable."
    exit 1
  else
    $JAVA \
      -XX:+UseG1GC \
      -XX:+UnlockExperimentalVMOptions \
      -XX:InitiatingHeapOccupancyPercent=24 \
      -XX:ConcGCThreads=4 \
      -XX:G1HeapRegionSize=128M \
      -XX:G1HeapWastePercent=1 \
      -XX:G1MixedGCLiveThresholdPercent=65 \
      -XX:G1RSetUpdatingPauseTimePercent=4 \
      -XX:G1ConcRefinementThreads=4 \
      -XX:+AlwaysPreTouch \
      -Xmx14G \
      -jar fabric-server-launch.jar nogui
  fi
else
  $JAVA \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+UnlockDiagnosticVMOptions \
    -Dterminal.jline=false \
    -Dterminal.ansi=true \
    -Djline.terminal=jline.UnsupportedTerminal \
    -Dlog4j2.formatMsgNoLookups=true \
    -XX:+AlwaysActAsServerClassMachine \
    -XX:+AlwaysPreTouch \
    -XX:+DisableExplicitGC \
    -XX:+UseNUMA \
    -XX:AllocatePrefetchStyle=3 \
    -XX:NmethodSweepActivity=1 \
    -XX:ReservedCodeCacheSize=400M \
    -XX:NonNMethodCodeHeapSize=12M \
    -XX:ProfiledCodeHeapSize=194M \
    -XX:NonProfiledCodeHeapSize=194M \
    -XX:+PerfDisableSharedMem \
    -XX:+UseFastUnorderedTimeStamps \
    -XX:+UseCriticalJavaThreadPriority \
    -XX:+EagerJVMCI \
    -XX:+UseG1GC \
    -XX:+ParallelRefProcEnabled \
    -XX:MaxGCPauseMillis=200 \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+UnlockDiagnosticVMOptions \
    -XX:+DisableExplicitGC \
    -XX:+AlwaysPreTouch \
    -XX:G1NewSizePercent=30 \
    -XX:G1MaxNewSizePercent=40 \
    -XX:G1HeapRegionSize=8M \
    -XX:G1ReservePercent=20 \
    -XX:G1HeapWastePercent=5 \
    -XX:G1MixedGCCountTarget=4 \
    -XX:InitiatingHeapOccupancyPercent=15 \
    -XX:G1MixedGCLiveThresholdPercent=90 \
    -XX:G1RSetUpdatingPauseTimePercent=5 \
    -XX:SurvivorRatio=32 \
    -XX:+PerfDisableSharedMem \
    -XX:MaxTenuringThreshold=1 \
    -XX:-UseBiasedLocking \
    -XX:+UseStringDeduplication \
    -XX:+UseFastUnorderedTimeStamps \
    -XX:+UseAES \
    -XX:+UseAESIntrinsics \
    -XX:+UseFMA \
    -XX:+UseLoopPredicate \
    -XX:+RangeCheckElimination \
    -XX:+EliminateLocks \
    -XX:+DoEscapeAnalysis \
    -XX:+UseCodeCacheFlushing \
    -XX:+SegmentedCodeCache \
    -XX:+UseFastJNIAccessors \
    -XX:+OptimizeStringConcat \
    -XX:+UseCompressedOops \
    -XX:+UseThreadPriorities \
    -XX:+OmitStackTraceInFastThrow \
    -XX:+TrustFinalNonStaticFields \
    -XX:ThreadPriorityPolicy=1 \
    -XX:+UseInlineCaches \
    -XX:+RewriteBytecodes \
    -XX:+RewriteFrequentPairs \
    -XX:+UseNUMA \
    -XX:-DontCompileHugeMethods \
    -XX:+UseFPUForSpilling \
    -XX:+UseVectorCmov \
    -XX:+UseXMMForArrayCopy \
    -XX:+UseTransparentHugePages \
    -XX:+UseLargePages \
    -Dfile.encoding=UTF-8 \
    -Xlog:async \
    -Xmx8G \
    -Djava.security.egd=file:/dev/urandom \
    --add-modules jdk.incubator.vector \
    -jar fabric-server-launch.jar nogui
fi

# crontab -l | sed "/^#.*\/mnt\/d\/etec\/cdmd+1.19\/incbak.sh/s/^#//" | crontab -
# crontab -l | sed "/^#.*\/mnt\/d\/etec\/cdmd+1.19\/backup.sh/s/^#//" | crontab -

KEY="x-key: $(cat forwarding.secret)"
PROXYIP=`cat proxyip`

curl --header "$KEY" "${PROXYIP}:25500"