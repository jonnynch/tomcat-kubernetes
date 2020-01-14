FROM openjdk:8-jre-alpine
LABEL Description="Tomcat image to test tomcat-in-the-cloud. standalone tomcat version"
VOLUME /tmp
USER root
ENV OPENSHIFT_KUBE_PING_NAMESPACE="tomcat-in-the-cloud" \
    JAVA_OPTS=""
ADD target/dependency/tomcat.zip apache-tomcat.zip
RUN unzip apache-tomcat.zip \
&& rm apache-tomcat.zip \
&& mv apache-tomcat* apache-tomcat
ADD openjson-1.0.10.jar catalina.sh /apache-tomcat/bin/
ADD sample.war /apache-tomcat/webapps
RUN chmod 777 /apache-tomcat/logs \
&& chmod 777 /apache-tomcat/webapps \
&& chmod 777 /apache-tomcat/work \
&& chmod 777 /apache-tomcat/temp \
&& chmod a+x /apache-tomcat/bin/*.sh
ADD server.xml logging.properties /apache-tomcat/conf/
WORKDIR /apache-tomcat
ENTRYPOINT [ "sh", "-c", "bin/startup.sh" ]
