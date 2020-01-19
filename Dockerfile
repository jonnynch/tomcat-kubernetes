FROM jonnynch/tomcat-cloud-base
ADD sample.war /apache-tomcat/webapps
RUN chgrp -R 0 /apache-tomcat/webapps \
 && chmod -R g=u /apache-tomcat/webapps 
USER 1001
ENTRYPOINT [ "sh", "-c", "bin/startup.sh" ]
