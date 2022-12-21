seroadmin@prod-LIVE:/opt/serosoft/tomcat-live/bin$ cat setenv.sh
export JAVA_OPTS="$JAVA_OPTS  -Xmx25g -Xms25g -Xverify:none -Djava.awt.headless=true -Dfile.encoding=UTF-8 -XX:+UseCompressedOops -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSClassUnloadingEnabled -XX:+CMSParallelRemarkEnabled -XX:+CMSCompactWhenClearAllSoftRefs -XX:CMSInitiatingOccupancyFraction=85 -XX:+CMSScavengeBeforeRemark -XX:+CMSConcurrentMTEnabled -XX:ParallelCMSThreads=8 -XX:+DisableExplicitGC -XX:MaxHeapFreeRatio=70 -XX:MinHeapFreeRatio=40 -XX:MaxTenuringThreshold=2 -XX:NewSize=8g -XX:MaxNewSize=8g -XX:SurvivorRatio=4 -XX:TargetSurvivorRatio=85 -XX:InitialCodeCacheSize=256m -XX:ReservedCodeCacheSize=512m -XX:ParallelGCThreads=8 -XX:ConcGCThreads=3"
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64/jre'
JAVA_OPTS="$JAVA_OPTS -javaagent:/opt/newrelic/newrelic.jar"



 <!-- Define an AJP 1.3 Connector on port 8009 -->
    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" maxThreads="800" />
