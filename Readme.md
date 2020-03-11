# Using docker compose for a local test environment

## Scope

This document describes the basic prerequisites for upping a local test environment with Docker Compose.

## Starting a local test environment with Docker Compose

### Preparing the environment

Your environment needs to define a few mandatory variables. These are:

* ServiceBusConfiguration__ConnectionString
* ConnectionStrings__GivtDbConnection
* ArangoDBConfiguration__Url
* ConnectionStrings__AzureWebJobsServiceBus
* ConnectionStrings__GivtDatabaseContext
* SQLAZURECONNSTR_GIVT_DB
* APPSETTING_ARANGODB_URL

The easiest way of doing is, is to provide a local file called container.env.local in which you export those variables.
f.i.

```bash
export ServiceBusConfiguration__ConnectionString="Endpoint=sb://mvgtest.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=/aCAwM3kL5ezhz52wKZNCNlmg4/YV1ui2AVclFNx8co="
export ConnectionStrings__GivtDbConnection="Server=tcp:givtdbdebug.database.windows.net,1433;Initial Catalog=GivtDbDebug;Persist Security Info=False;User ID=dbadmin;Password=DB4dmin0;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
export ArangoDBConfiguration__Url="http://arango:8529/"

export ConnectionStrings__AzureWebJobsServiceBus="${ServiceBusConfiguration__ConnectionString}"
export ConnectionStrings__GivtDatabaseContext="${ConnectionStrings__GivtDbConnection}"
export SQLAZURECONNSTR_GIVT_DB="${ConnectionStrings__GivtDbConnection}"
export APPSETTING_ARANGODB_URL="${ArangoDBConfiguration__Url}"
```

If you have this file you need to "source" it before starting the local test environment.
`source ./container.env.local`

### Some words on the Arango database Server

Arango will start with its data mounted on a local directory called "arango_data".
The root password is an empty string.
After the inital start of arango, you need to create the local database givtdbg and also add a user `operations` with password ``Y`e^MaZ3:a^~}SSE&HeVch6k]{K;'ADT`` which has read/write access to that database.

### Upping the test environment

Starting the environment is as simple as:
`source ./container.env.local && docker-compose up`

### After startup

| Service | Url |
|---------|-----|
| Givt dashboard (1.0) | http://localhost:1000/ |
| Givt dashboard (2.0) | http://localhost:2000/ |
| Givt internal dashboard | http://localhost:3000/ |
| Arango DB | http://arango:8529/ |
| Givt API | http://localhost:5000/ |
| Workers.ValidateTransactions | http://localhost:5500/ |
| Workers.Hmrc | http://localhost:5501/ |
| Workers.OnboardingReminders | http://localhost:5502/ |
| Workers.ServiceBus | http://localhost:5503/ |
| Workers.DebitUsers | http://localhost:5504/ |