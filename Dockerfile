# First stage: complete build environment
FROM maven:3.5.0-jdk-8-alpine AS builder

# add pom.xml
ADD ./pom.xml pom.xml
RUN mvn -B -f pom.xml dependency:go-offline

# add source
ADD ./src src/

# package jar
RUN mvn -B install -Dmaven.test.skip=true

From openjdk:8

# copy jar from the first stage
COPY --from=builder target/my-app-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar
EXPOSE 8080
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
