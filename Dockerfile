FROM alpine:3.18

RUN apk add --no-cache curl unzip

RUN PB_URL=$(curl -s https://api.github.com/repos/pocketbase/pocketbase/releases/latest | grep browser_download_url | grep linux_amd64.zip | cut -d '"' -f 4) \
    && curl -L -o /tmp/pb.zip $PB_URL \
    && unzip /tmp/pb.zip -d /pb \
    && rm /tmp/pb.zip

WORKDIR /pb

# نسخ البيانات والمهاجرات فقط
COPY pb_data ./pb_data
COPY pb_migrations ./pb_migrations

# فتح المنفذ
EXPOSE 8090

# التشغيل
CMD ["./pocketbase", "serve", "--http", "0.0.0.0:8090"]
