# 🐳 Dockerfile لتشغيل PocketBase على Render
FROM alpine:3.18

# تثبيت curl و unzip
RUN apk add --no-cache curl unzip

# تحميل أحدث نسخة من PocketBase
RUN curl -L -o /tmp/pb.zip https://github.com/pocketbase/pocketbase/releases/latest/download/pocketbase_0.22.15_linux_amd64.zip \
    && unzip /tmp/pb.zip -d /pb \
    && rm /tmp/pb.zip

# تعيين مجلد العمل
WORKDIR /pb

# فتح المنفذ الافتراضي
EXPOSE 8090

# أمر التشغيل الأساسي
CMD ["./pocketbase", "serve", "--http", "0.0.0.0:8090"]
