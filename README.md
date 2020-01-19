# tomcat-kubernetes
What is needed to create a Tomcat Docker image to run a cluster of tomcats in Kubernetes. 

Get the latest tomcat snapshot of tomcat:
```
mvn clean install
```
Build the Docker image:
```

# update Dockerfile for the project(namespace) to be
docker build -t tomcat-in-the-cloud .
```
Tag the image on docker
```
docker login
docker tag tomcat-in-the-cloud:latest <public registry exposed url>/<project>/tomcat-in-the-cloud
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
oc new-project <project>
```
Push the image to registry
```
docker push <public registry exposed url>/<project>/tomcat-in-the-cloud
```
Add the user to view the pods
```
oc policy add-role-to-user view system:serviceaccount:<project>:default -n <project>
```
Create the first pod
```
oc new-app --name tomcat-in-the-cloud --docker-image image-registry.openshift-image-registry.svc:5000/<project>/tomcat-in-the-cloud --insecure-registry
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



