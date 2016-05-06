Usage

Bulid a new image:

$ git clone https://github.com/agileshell/dockerfile-jdk-tomcat.git
$ cd dockerfile-jdk-tomcat
$ sudo docker build -t dockerfile-jdk-tomcat .
# OR
$ sudo docker build -t dockerfile-jdk-tomcat https://github.com/agileshell/dockerfile-jdk-tomcat.git
We can now fire a new container based on this image:

$ sudo docker run -d -p 8090:8080 dockerfile-jdk-tomcat
After few seconds, open http://<host>:8090 to see the welcome page.
