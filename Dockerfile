# 1-bosqich: Loyihani yig'ish (Konteyner ichida Maven ishlaydi)
FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# 2-bosqich: Faqat tayyor loyihani ishga tushirish (Minimal hajm)
FROM eclipse-temurin:21-jdk-alpine
VOLUME /tmp
# Tayyor .jar faylni 1-bosqichdan nusxalab olamiz
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]