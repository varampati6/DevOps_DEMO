#FROM centos:centos7
FROM varampati/tomcat:2.0
MAINTAINER ravi
RUN echo "Building Image, Bro!"
ENV PORT 8080
EXPOSE 8080
#ENV JAVA_HOME /usr/bin/java
#ENV JAVA_HOME /opt/java
#ENV CATALINA_HOME /opt/tomcat
#ENV CATALINA_BASE /opt/tomcat
#ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

ADD ./target/*.war $CATALINA_HOME/webapps/ROOT.war
#WORKDIR /opt/tomcat
RUN groupadd -r tomcat && \
 useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
 chown -R tomcat:tomcat ${CATALINA_HOME}
EXPOSE 8080
#EXPOSE 8009

USER tomcat
CMD ["tomcat.sh"]
#CMD ["$CATALINA_HOME/bin/catalina.sh", "run"]

#RUN chmod +x /app/techmahindra.war
#ENTRYPOINT ["java","-jar","/app/techmahindra.war"]
