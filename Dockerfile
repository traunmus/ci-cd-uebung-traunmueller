# ===== STAGE 1: Build =====
# ===== STAGE 1: Build =====
FROM --platform=linux/amd64 maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

# Package the app and copy dependencies to target/dependency
RUN mvn -B -DskipTests=false package \
    && mkdir -p target/dependency \
    && mvn dependency:copy-dependencies -DoutputDirectory=target/dependency \
    && ls -la target/dependency


# ===== STAGE 2: Runtime =====
FROM --platform=linux/amd64 eclipse-temurin:17-jre-focal
WORKDIR /app

# Copy application JAR
COPY --from=build /app/target/*.jar /app/app.jar

# Copy dependencies
COPY --from=build /app/target/dependency /app/lib

# Update entrypoint to include dependencies in classpath
ENTRYPOINT ["java","-cp","/app/app.jar:/app/lib/*","com.example.cicd.App"]
