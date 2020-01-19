docker build -t tomcat-cloud-base -f Dockerfile.base .
docker build -t docker.io/jonnynch/tomcat-in-the-cloud .
docker push jonnynch/tomcat-in-the-cloud
