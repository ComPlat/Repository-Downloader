BAG_IT_STREAM_THREADS=5\
  DOWNLOADER_DATA_PATH=/Users/philippherda/Pictures/\
  DOWNLOADER_DB_USERNAME=postgres\
  DOWNLOADER_DB_PASSWORD=postgres\
  DOWNLOADER_DB_HOST=host.docker.internal\
  DOWNLOADER_DB_PORT=5432\
  DOWNLOADER_DB_NAME=downloader_db_prod\
  docker compose -f docker-compose.production.yml up --remove-orphans --force-recreate --build
# For debugging append to first line: --force-recreate --build
