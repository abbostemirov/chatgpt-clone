#!/bin/bash

# Hozir qaysi biri aktivligini nginx config'dan o'qiymiz
if grep -q "app-blue" nginx/active.conf; then
    TARGET="app-green"
    TARGET_CONTAINER="spring_app_green"
    ACTIVE="app-blue"
else
    TARGET="app-blue"
    TARGET_CONTAINER="spring_app_blue"
    ACTIVE="app-green"
fi

echo "Hozirgi aktiv: $ACTIVE. Yangi versiya $TARGET ga o'rnatilmoqda..."

# Yangi versiyani tortamiz va fonga ishga tushiramiz
docker compose pull $TARGET
docker compose up -d $TARGET

# Spring Boot to'liq yonguncha (Healthy bo'lguncha) kutamiz
echo "$TARGET tayyor bo'lishini kutyapmiz..."
ATTEMPTS=0
while [ "$(docker inspect -f '{{.State.Health.Status}}' $TARGET_CONTAINER)" != "healthy" ]; do
    sleep 3
    ATTEMPTS=$((ATTEMPTS+1))
    if [ $ATTEMPTS -eq 20 ]; then
        echo "XATOLIK: Yangi konteyner ishga tushmadi! (Downtime oldi olindi)"
        docker compose stop $TARGET
        exit 1
    fi
done

echo "$TARGET to'liq ishga tushdi! Trafikni unga buramiz..."

# Nginx config'ni yangilaymiz
echo "set \$active_app $TARGET;" > nginx/active.conf

# Nginx'ni RESTART qilmasdan, faqat sozlamalarni qayta o'qitamiz (Graceful reload)
docker exec nginx_proxy nginx -s reload

echo "Trafik $TARGET ga burildi! Eski $ACTIVE o'chirilmoqda..."
docker compose stop $ACTIVE

echo "Zero-Downtime Deployment muvaffaqiyatli yakunlandi! 🚀"