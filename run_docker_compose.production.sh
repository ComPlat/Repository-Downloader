ssh_key=$(cat <<-END
-----BEGIN OPENSSH PRIVATE KEY-----

-----END OPENSSH PRIVATE KEY-----
END
)

BAG_IT_STREAM_THREADS=5\
  DOWNLOADER_ATTACHMENTS_PATH=/Users/tbsvttr/Code/KIT/file_test\
  DOWNLOADER_DB_USERNAME=postgres\
  DOWNLOADER_DB_PASSWORD=postgres\
  DOWNLOADER_DB_HOST=host.docker.internal\
  DOWNLOADER_DB_PORT=5432\
  DOWNLOADER_DB_NAME=downloader_db_prod\
  SSH_KEY=$ssh_key\
  DOWNLOADER_SECRET_KEY_BASE=secret_key_base\
  docker compose -f docker-compose.production.yml up -d --remove-orphans --force-recreate --build
# For debugging append to first line: --force-recreate --build
