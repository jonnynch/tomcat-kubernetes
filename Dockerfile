FROM adoptopenjdk:8-jre-hotspot 
LABEL Description="Tomcat image to test tomcat-in-the-cloud. standalone tomcat version" 
VOLUME /tmp 
ENV OPENSHIFT_KUBE_PING_NAMESPACE="jon" \ 
    JAVA_OPTS="" 
ADD target/dependency/tomcat.tar.gz /
RUN mv apache-tomcat* apache-tomcat 
ADD openjson-1.0.10.jar catalina.sh /apache-tomcat/bin/ 
ADD server.xml logging.properties /apache-tomcat/conf/ 
RUN chgrp -R 0 /apache-tomcat \ 
 && chmod -R g=u /apache-tomcat \ 
 && chmod a+x /apache-tomcat/bin/*.sh 
ADD sample.war /apache-tomcat/webapps
RUN chgrp -R 0 /apache-tomcat/webapps \
 && chmod -R g=u /apache-tomcat/webapps 
USER 1001
WORKDIR /apache-tomcat 
ENTRYPOINT [ "sh", "-c", "./bin/startup.sh" ] 
