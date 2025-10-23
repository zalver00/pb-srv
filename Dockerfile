# 🐳 Dockerfile لتشغيل PocketBase على Render
FROM alpine:3.18

# تثبيت curl و unzip
RUN apk add --no-cache curl unzip

# تحميل أحدث نسخة من PocketBase
RUN PB_URL=$(curl -s https://api.github.com/repos/pocketbase/pocketbase/releases/latest | grep browser_download_url | grep linux_amd64.zip | cut -d '"' -f 4) \
    && curl -L -o /tmp/pb.zip $PB_URL \
    && unzip /tmp/pb.zip -d /pb \
    && rm /tmp/pb.zip

# نسخ بيانات التطبيق المحلية إلى السيرفر
WORKDIR /pb
COPY pb_data ./pb_data
COPY pb_migrations ./pb_migrations
COPY pb_hooks ./pb_hooks
COPY pb_public ./pb_public

# ضمان صلاحيات الكتابة
RUN chmod -R 777 /pb/pb_data

# فتح المنفذ الافتراضي
EXPOSE 8090

# تشغيل PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
