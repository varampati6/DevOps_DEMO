FROM centos:centos7
FROM varampati/tomcat:1.0
ENV PORT 8080
EXPOSE 8080
ENV JAVA_HOME /usr/bin/java
ENV JAVA_HOME /opt/java
ENV CATALINA_HOME /opt/tomcat
ENV CATALINA_BASE /opt/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

ADD ./target/techmahindra-1.0.war /tomcat/webapps/ROOT.war
WORKDIR /opt/tomcat

EXPOSE 8080
#EXPOSE 8009

USER tomcat
CMD ["tomcat.sh"]

#RUN chmod +x /app/techmahindra.war
#ENTRYPOINT ["java","-jar","/app/techmahindra.war"]
