FROM java:8
ENV PORT 8080
EXPOSE 8080
RUN mkdir /app
ADD ./target/techmahindra-1.0.war /app/techmahindra.war
WORKDIR /app
RUN chmod +x /app/techmahindra.war
ENTRYPOINT ["java","-jar","/app/techmahindra.war"]
