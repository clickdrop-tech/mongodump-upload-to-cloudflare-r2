# Mongo Dump Uploading To Cloudflare R2 Storage

A tool(script) for dumping replica set mongo database, zip dumped database and upload compressed database data to cloudflare R2 storage for backup purposes

## Installation

- Download or copy content of `mongodump_upload_r2.sh` to your server environment(linux)

- install `rclone`

```bash
[r2]
type = s3
provider = Cloudflare
access_key_id = ACCESS_KEY
secret_access_key = SECRET_ACCESS_KEY
region = auto
endpoint = https://ACCOUNT_ID.r2.cloudflarestorage.com
acl = private
```

- create bucket and API token on cloudflare R2 dashboard

- Fill in the needed values for the variables in the file

  `MONGODUMP_PATH`

  `MONGODUMP_USERNAME`

  `MONGODUMP_PASSWORD`

  `MONGO_URI`

  `R2_BUCKET_NAME`

- Make the file executable

```bash
  sudo chmod +x mongodump_upload_r2.sh
```

- Add the script in the crontab

```bash
  sudo nano /etc/crontab
```

- config cron setting and point to script

  ` * * * * *   linux_user  /path_to_file/mongodump_upload_r2.sh`

- check cron logs to verify(depending on distro)

  `var/log/cron` or `/var/log/syslog`

## Reference

[mongodump](https://www.mongodb.com/docs/database-tools/mongodump/)

[rclone installation](https://rclone.org/install/#linux)

[rclone config](https://rclone.org/s3/#cloudflare-r2)

[cron](https://en.wikipedia.org/wiki/Cron)
