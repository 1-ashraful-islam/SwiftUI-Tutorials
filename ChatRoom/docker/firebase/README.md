# Local Firebase emulator inside Docker

This is a local installation of firebase-tools inside docker. Installing this and getting it work is quite tedious. It should have everything working at the moment.

## Build and run

`docker compose up -d --build`

## Important

Since this is being commited to public repo: following files are not included but required:

```json
# .firebaserc
{
  "projects": {
    "default": "YOUR_APP_ID"
  }
}
```

```sh
# .env
PROJECT_ID=YOUR_APP_ID
FIREBASE_TOKEN=YOUR_TOKEN # use `firebase login:ci` to generate token
```

Also make sure to create the directories that are being mounted on the docker image as volumes:

```sh
docker
|
|--firebase
    |
    |-- .cache
    |-- .config
    |-- .firebase
    |-- emulator-state
```
