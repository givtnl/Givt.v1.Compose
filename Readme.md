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
* GivtConfiguration__GivtApi
* SQLAZURECONNSTR_GIVT_DB
* APPSETTING_ARANGODB_URL
* APPSETTING_API_URL

N.B. To access other containers from a container you need to address it with service name e.g. "arango".

#### Mac OS/Linux
The easiest way of doing is, is to provide a local file called container.env.local in which you export those variables.  
f.i.

```bash
export ServiceBusConfiguration__ConnectionString="Endpoint=sb://mvgtest.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=/aCAwM3kL5ezhz52wKZNCNlmg4/YV1ui2AVclFNx8co="
export ConnectionStrings__GivtDbConnection="Server=tcp:host.docker.internal,1433;Initial Catalog=localgivt;User ID=dbadmin;Password=DB4dmin0;Encrypt=False;Connection Timeout=30;"
export ArangoDBConfiguration__Url="http://arango:8529/"
export GivtConfiguration__GivtApi="http://api:8080"
export CUSTOMCONNSTR_API_TOKEN="eyJhbGciOiJBMjU2S1ciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwidHlwIjoiSldUIn0.omxtVhFSMCyEkG4E2LdFWPHghcuY_PBrxKBkYcNpq5Qocqup-S9kNazXbPPWd_DRBG2fYVGf6dvAojPDsoYjYCthXhPYMBih.-kWxQAKLfCNEEyh46WlREQ.JnpVyCm24l_8J4e0cxZKfuUXd5wNq5B8ksQHloPGr-wxpCrmn_iLRTQVbC652I_zR5ruUicgg--ADqF1GLyXErF3wy2tLJAO4iqepZAhyyN7MU0yHiPFXshsHRIraYQXK90huWWyUnk33ZDqfPgrvG5foTwOopmSYOzHyZccfAfbJ0qb4ErkEi42WE_-e3bcBAKYD9R6t5nNPtxWgc6pGjBugOUMjr8uaqDHE_LdQdXzZ111a2ipl7yRAXoZ4_7TnImSmbcRQfEBATZWbjXZxsFl12Q3n-cpmYdQ089sG6aAegh6xpEanW1lXTgkFEJmkADCv1XKg7YyfLm6Bz_dLIFyZgRSNuyWIvmO7xFUbrbNGAEzQsrHUbW1gLzukjFWBNsN278K2vlpgagR49FD2rC9zFzdtgOQ_1d4iTNw-tmNasY6x-lihR7XmKWOIraV.xGkJyTnKfKDsJc1WFmuDNeSoKSEl6klyjkBLKbqZepE"

export ConnectionStrings__AzureWebJobsServiceBus="${ServiceBusConfiguration__ConnectionString}"
export ConnectionStrings__GivtDatabaseContext="${ConnectionStrings__GivtDbConnection}"
export SQLAZURECONNSTR_GIVT_DB="${ConnectionStrings__GivtDbConnection}"
export APPSETTING_ARANGODB_URL="${ArangoDBConfiguration__Url}"
export APPSETTING_API_URL="${GivtConfiguration__GivtApi}"
```

If you have this file you need to "source" it before starting the local test environment.  
`source ./container.env.local`

#### Windows 
The easiest way of doing this is to create a batch file (start.docker.compose.bat) that you run. This batch file will set the environment variables and execute docker-compose up  
f.i.  
  
```batch
set ServiceBusConfiguration__ConnectionString="Endpoint=sb://givttest5.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=4jJe/328CNSkthbZiKeVzNK1iy1MtnXdg6D4buy8zE4="
set ConnectionStrings__GivtDbConnection="Data Source=host.docker.internal,1433;Initial Catalog=givtdbg;Integrated Security=true;"
set ArangoDBConfiguration__Url="http://arango:8529/"
set GivtConfiguration__GivtApi="http://api:8080"
set ConnectionStrings__AzureWebJobsServiceBus=%ServiceBusConfiguration__ConnectionString%
set ConnectionStrings__GivtDatabaseContext=%ConnectionStrings__GivtDbConnection%
set SQLAZURECONNSTR_GIVT_DB=%ConnectionStrings__GivtDbConnection%
set APPSETTING_ARANGODB_URL=%ArangoDBConfiguration__Url%
set APPSETTING_API_URL=%GivtConfiguration__GivtApi%
docker-compose up
```

### Some words on the Arango database Server

Arango will start with its data mounted on a local directory called "arango_data".
The root password is an empty string.
After the inital start of arango, you need to create the local database givtdbg and also add a user `operations` with password ``Y`e^MaZ3:a^~}SSE&HeVch6k]{K;'ADT`` which has read/write access to that database.

### Upping the test environment

Starting the environment is as simple as:\
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