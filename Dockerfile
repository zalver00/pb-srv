# 🐳 Dockerfile لتشغيل PocketBase على Render
FROM alpine:3.18

# تثبيت curl و unzip
RUN apk add --no-cache curl unzip

# تحميل أحدث نسخة من PocketBase
RUN PB_URL=$(curl -s https://api.github.com/repos/pocketbase/pocketbase/releases/latest | grep browser_download_url | grep linux_amd64.zip | cut -d '"' -f 4) \
    && curl -L -o /tmp/pb.zip $PB_URL \
    && unzip /tmp/pb.zip -d /pb \
    && rm /tmp/pb.zip

# تعيين مجلد العمل
WORKDIR /pb

# فتح المنفذ الافتراضي
EXPOSE 8090

# أمر التشغيل الأساسي
CMD ["./pocketbase", "serve", "--http", "0.0.0.0:8090"]
