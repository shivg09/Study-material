FROM mcr.microsoft.com/java/jdk:8-zulu-alpine
ARG APP_FILE=regression2.war
ARG TOMCAT_VERSION=9.0.38
ARG SERVER_XML=server.xml
ARG LOGGING_PROPERTIES=logging.properties
ARG CONTEXT_XML=context.xml
ARG CATALINA_PROPERTIES=catalina.properties
ARG TOMCAT_MAJOR=9

# As provided here, only the access log gets written to this location.
# Mount to a persistent volume to preserve access logs.
# Modify this value to specify a different log directory.
# e.g. /home/logs in Azure App Service
ENV LOG_ROOT=/tomcat_logs

ENV PATH /usr/local/tomcat/bin:$PATH

# Make Java 8 obey container resource limits, improve performance
ENV JAVA_OPTS "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Xmx13g -Xms13g -Xverify:none -Djava.awt.headless=true -Dfile.encoding=UTF-8 -XX:+UseCompressedOops -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSClassUnloadingEnabled -XX:+CMSParallelRemarkEnabled -XX:+CMSCompactWhenClearAllSoftRefs -XX:CMSInitiatingOccupancyFraction=85 -XX:+CMSScavengeBeforeRemark -XX:+CMSConcurrentMTEnabled -XX:ParallelCMSThreads=4 -XX:+DisableExplicitGC -XX:MaxHeapFreeRatio=70 -XX:MinHeapFreeRatio=40 -XX:MaxTenuringThreshold=2 -XX:NewSize=7g -XX:MaxNewSize=7g -XX:SurvivorRatio=4 -XX:TargetSurvivorRatio=85 -XX:InitialCodeCacheSize=512m -XX:ReservedCodeCacheSize=1g -XX:ParallelGCThreads=4 -XX:ConcGCThreads=2 $JAVA_OPTS -javaagent:/usr/local/tomcat/newrelic/newrelic.jar " 



# Cleanup & Install
RUN apk add --update openssh-server bash openrc \
        && rm -rf /var/cache/apk/* \
        # Remove unnecessary services
        && rm -f /etc/init.d/hwdrivers \
                 /etc/init.d/hwclock \
                 /etc/init.d/mtab \
                 /etc/init.d/bootmisc \
                 /etc/init.d/modules \
                 /etc/init.d/modules-load \
                 /etc/init.d/modloop \
        # Install Tomcat
        && wget -O /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz --no-verbose \
        && mkdir /usr/local/tomcat \ 
        && tar xvzf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /usr/local/tomcat --strip-components 1 \
        && rm -f /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
         # Remove the sample webapps provided by Tomcat
        && rm -rf /usr/local/tomcat/webapps/*
 
#newrelic
RUN mkdir -p /usr/local/tomcat/newrelic
ADD extensions /usr/local/tomcat/newrelic/extensions
ADD extension.xsd /usr/local/tomcat/newrelic/extension.xsd
ADD newrelic-api.jar /usr/local/tomcat/newrelic/newrelic-api.jar
ADD newrelic-api-sources.jar /usr/local/tomcat/newrelic/newrelic-api-sources.jar
ADD newrelic-api-javadoc.jar /usr/local/tomcat/newrelic/newrelic-api-javadoc.jar 
ADD newrelic.jar /usr/local/tomcat/newrelic/newrelic.jar
ADD newrelic.yml /usr/local/tomcat/newrelic/newrelic.yml
ADD hikari.yml /usr/local/tomcat/newrelic/hikari.yml
#ENV JAVA_OPTS="$JAVA_OPTS -javaagent:/usr/local/tomcat/newrelic/newrelic.jar"

      
COPY $APP_FILE /usr/local/tomcat/webapps/regression2.war
RUN mkdir -p /usr/local/tomcat/webapps/regression2


RUN  cd /usr/local/tomcat/webapps/regression2 \
    && unzip ../regression2.war \
    && rm -f ../regression2.war



COPY ${SERVER_XML} /usr/local/tomcat/conf/server.xml
COPY ${CONTEXT_XML} /usr/local/tomcat/conf/context.xml
COPY ${LOGGING_PROPERTIES} /usr/local/tomcat/conf/logging.properties
COPY ${CATALINA_PROPERTIES} /usr/local/tomcat/conf/catalina.properties

## ssh

RUN apk add openssh \
&& echo "root:Docker!" | chpasswd
COPY sshd_config /etc/ssh/
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
RUN chmod +x /tmp/ssh_setup.sh \
&& (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)
EXPOSE 80 2222


# Copy the startup script
EXPOSE 8080
COPY startup.sh /startup.sh
RUN chmod a+x /startup.sh

EXPOSE 8080

CMD ["/startup.sh"]
