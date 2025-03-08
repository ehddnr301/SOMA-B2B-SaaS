docker run -d \
  --name clickhouse \
  --ulimit nofile=262144:262144 \
  -p 8123:8123 \
  -p 9000:9000 \
  -p 9009:9009 \
  -e CLICKHOUSE_USER=clickhouse \
  -e CLICKHOUSE_PASSWORD=clickhouse \
  -e CLICKHOUSE_DB=clickhouse \
  -e CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=1 \
  clickhouse/clickhouse-server
