FROM tomcat-cloud-base
ADD sample.war /apache-tomcat/webapps
RUN chmod 777 /apache-tomcat/webapps
ENTRYPOINT [ "sh", "-c", "bin/startup.sh" ]