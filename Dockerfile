FROM eclipse-temurin:21-jdk-alpine
VOLUME /tmp
# Maven builddan chiqqan jar faylni konteynerga nusxalaymiz
COPY target/*.jar app.jar
# Dasturni ishga tushirish
ENTRYPOINT ["java","-jar","/app.jar"]