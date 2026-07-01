# =========================================================
# 1-BOSQICH: JDK yordamida loyihani yig'ish (Build stage)
# =========================================================
FROM maven:3.8.5-openjdk-17 AS build-stage

# Ishchi papkani yaratamiz
WORKDIR /build

# Loyihaning sozlamalar fayllarini nusxalaymiz
COPY pom.xml .
COPY src ./src

# Kodni komplyatsiya qilib, .jar fayl yaratamiz (testlarni tashlab ketamiz tezroq bo'lishi uchun)
RUN mvn clean package -DskipTests

# =========================================================
# 2-BOSQICH: Faqat JRE yordamida ilovani ishga tushirish (Run stage)
# =========================================================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# 1-bosqichda (build-stage) tayyor bo'lgan .jar faylni o'zimizga nusxalab olamiz
COPY --from=build-stage /build/target/*.jar app.jar

# Portni ochamiz
EXPOSE 8080

# Ilovani ishga tushiramiz
ENTRYPOINT ["java", "-jar", "app.jar"]