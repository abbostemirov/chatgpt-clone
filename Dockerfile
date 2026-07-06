# 1-BOSQICH (Build Stage): Loyihani kompilatsiya qilamiz
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app
# Loyiha fayllarini konteyner ichiga tashlaymiz
COPY . .
# Maven orqali .jar faylni konteyner ichida build qilamiz
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# 2-BOSQICH (Run Stage): Faqat kerakli faylni olib ishga tushiramiz
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# 1-bosqichda yasalgan .jar faylni 2-bosqichga nusxalaymiz (qolgan axlat fayllar tushib qoladi)
COPY --from=builder /app/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]