APP_HOST=$1

while [ $(curl -s -o /dev/null -w '%{http_code}' "$APP_HOST") -ne 200 ]; do
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Waiting for app service to start..."
    sleep 1
done

nginx -g 'daemon off;'