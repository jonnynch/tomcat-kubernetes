# tomcat-kubernetes
What is needed to create a Tomcat Docker image to run a cluster of tomcats in Kubernetes. 

Get the latest tomcat snapshot of tomcat:
```
mvn clean install
```
Build the Docker image:
```

docker build -t docker.io/<user>/tomcat-in-the-cloud .
```
or (to add your sample.war webapp to my existing image).
```
docker build -f Dockerfile.webapp -t docker.io/<user>/tomcat-in-the-cloud-war --build-arg war=/sample.war --build-arg registry_id=tomcat-in-the-cloud .
```
Push the image on docker (use tomcat-in-the-cloud-war for the war one)
```
docker login
docker push <user>/tomcat-in-the-cloud
```

For OpenShift
https://manage.openshift.com/account/index use add a New Plan (Starter is enough) creating the plan takes a while...
open the web console and create project
On the left of the console you can get the login command ("Copy Login Command"). Use it on you laptop to connect.
```
oc login https://blabla --token=blabla
```
Use the project you have created (in my case I have created tomcat-in-the-cloud)
```
oc project tomcat-in-the-cloud
```
Add the user to view the pods
```
oc policy add-role-to-user view system:serviceaccount:tomcat-in-the-cloud:default -n tomcat-in-the-cloud
```
Create the first pod
```
oc new-app --name tomcat-in-the-cloud --docker-image="<user>/tomcat-in-the-cloud:latest"
```
Scale it do 2 replicas
```
oc scale --replicas=2 dc/tomcat-in-the-cloud
```
Expose the deployment
```
oc expose dc/tomcat-in-the-cloud --port=8080
oc expose service/tomcat-in-the-cloud
#optional
oc annotate route tomcat-in-the-cloud router.openshift.io/cookie_name="mycookie"
```
To access to the tomcat use the hostname something like
http://tomcat-in-the-cloud-tomcat-in-the-cloud.193b.starter-ca-central-1.openshiftapps.com/



