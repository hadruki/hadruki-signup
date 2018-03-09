# Mock api

## Installation
```
cd mock-api
npm install json-server --save-dev
```

## Usage

```
node signup.js
```

```
curl -X POST -H "Content-Type: application/json" -d '{"username": "dvekeman", "email": "dieter.vekeman@gmail.com", "password": "test123"}' "http://localhost:3000/signup"
```