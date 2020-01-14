FROM openjdk:8-jre-alpine
LABEL Description="Tomcat image to test tomcat-in-the-cloud. standalone tomcat version"
VOLUME /tmp

USER root

WORKDIR /apache-tomcat

ARG registry_id
ENV OPENSHIFT_KUBE_PING_NAMESPACE $registry_id
ENV JAVA_OPTS=""

ADD target/dependency/tomcat.zip apache-tomcat.zip
RUN unzip apache-tomcat.zip \
&& rm apache-tomcat.zip \
&& mv apache-tomcat* apache-tomcat
ADD openjson-1.0.10.jar catalina.sh /apache-tomcat/bin

RUN chmod 777 /apache-tomcat/logs \
&& chmod 777 /apache-tomcat/webapps \
&& chmod 777 /apache-tomcat/work \
&& chmod 777 /apache-tomcat/temp \
&& sh -c 'chmod a+x bin/*.sh'

ADD server.xml logging.properties /apache-tomcat/conf

ENTRYPOINT [ "sh", "-c", "bin/startup.sh" ]
