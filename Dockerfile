FROM shaozp/centos7-ssh
MAINTAINER shaozp "shaozp@asiainfo.com"

#RUN yum install -y update
RUN yum install -y install curl

RUN cd /tmp &&  curl -L 'http://download.oracle.com/otn-pub/java/jdk/7u65-b17/jdk-7u65-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie; gpw_e24=Dockerfile' | tar -xz
RUN mkdir -p /data/java
RUN mv /tmp/jdk1.7.0_65/ /data/java/jdk1.7.0_65/
RUN update-alternatives --install /usr/bin/java java /data/java/jdk1.7.0_65/bin/java 300
RUN update-alternatives --install /usr/bin/javac javac /data/java/jdk1.7.0_65/bin/javac 300

ENV JAVA_HOME /data/java/jdk1.7.0_65/

ADD apache-maven-3.3.9-bin.tar.gz /tmp/apache-maven-3.3.9-bin.tar.gz
RUN cd /tmp && tar -xz apache-maven-3.3.9-bin.tar.gz
RUN mkdir -p /data/maven
RUN mv /tmp/apache-maven-3.3.9/ /data/tomcat/apache-maven-3.3.9/
ENV MAVEN_HOME /data/maven/apache-maven-3.3.9

RUN cd /tmp && curl -L 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.8/bin/apache-tomcat-7.0.8.tar.gz' | tar -xz
RUN mkdir -p /data/tomcat
RUN mv /tmp/apache-tomcat-7.0.8/ /data/tomcat/apache-tomcat-7.0.8/

ENV CATALINA_HOME /data/tomcat/apache-tomcat-7.0.8
ENV CLASSPATH .:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$CATALINA_HOME/bin:$JAVA_HOME/bin:$MAVEN_HOME/bin

ADD tomcat7.sh /etc/init.d/tomcat7
RUN chmod 755 /etc/init.d/tomcat7

EXPOSE 8080

ENTRYPOINT service tomcat7 start && /usr/sbin/sshd -D && tail -f /data/tomcat/apache-tomcat-7.0.8/logs/catalina.out

