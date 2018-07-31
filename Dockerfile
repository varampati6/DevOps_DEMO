# Centos based container with Java and Tomcat
FROM centos:centos7
FROM java:8
MAINTAINER ravi

# Install prepare infrastructure
#RUN yum -y update && \
# yum -y install wget && \
# yum -y install tar

# Prepare environment
#ENV JAVA_HOME /usr/bin/java
#ENV JAVA_HOME /opt/java
ENV CATALINA_HOME /opt/tomcat
ENV CATALINA_BASE /opt/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

# Install Oracle Java8
#ENV JAVA_VERSION 8u181
#ENV JAVA_BUILD 8u181-b13
#ENV JAVA_DL_HASH 96a7b8442fe848ef90c96a2fad6ed6d1
# http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz
#RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
# http://download.oracle.com/otn-pub/java/jdk/${JAVA_BUILD}/${JAVA_DL_HASH}/jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
# tar -xvf jdk-${JAVA_VERSION}-linux-x64.tar.gz && \
# rm jdk*.tar.gz && \
# mv jdk* ${JAVA_HOME}


# Install Tomcat
#ENV TOMCAT_MAJOR 9
#ENV TOMCAT_VERSION 9.0.10

#RUN wget http://mirror.linux-ia64.org/apache/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
# tar -xzvf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
# rm apache*.tar.gz && \
# mv apache* ${CATALINA_HOME}

#ADD java /opt/java
ADD tomcat /opt/tomcat
ADD ./target/*.war $CATALINA_HOME/webapps/ROOT.war


RUN chmod -R +x ${CATALINA_HOME}
RUN chmod -R +x ${JAVA_HOME}
RUN chmod +x ${CATALINA_HOME}/bin/*sh

# Create Tomcat admin user
ADD create_admin_user.sh $CATALINA_HOME/scripts/create_admin_user.sh
ADD tomcat.sh $CATALINA_HOME/scripts/tomcat.sh
#ADD context.xml $CATALINA_HOME/webapps/host-manager/META-INF/context.xml 
#ADD context.xml $CATALINA_HOME/webapps/manager/META-INF/context.xml
RUN chmod +x $CATALINA_HOME/scripts/*.sh

# Create tomcat user
RUN groupadd -r tomcat && \
 useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
 chown -R tomcat:tomcat ${CATALINA_HOME}

WORKDIR /opt/tomcat

EXPOSE 9090
#EXPOSE 8009

USER tomcat
CMD ["tomcat.sh"]
