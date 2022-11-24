# Using docker compose for a local test environment

## Scope

This document describes the basic prerequisites for upping a local test environment with Docker Compose.

## Starting a local test environment with Docker Compose

### Upping the test environment

Starting the environment is as simple as:  
`docker-compose up`

### After startup

| Service | Url |
|---------|-----|
| Givt dashboard (1.0) | http://localhost:1000/ |
| Givt dashboard (2.0) | http://localhost:2000/ |
| Givt flash control | http://localhost:3000/ |
| Givt flash crowd | http://localhost:4000/ |
| Arango DB | http://arango:8529/ |
| SQL DB | tcp://localhost:1433/ |
| Givt API | http://localhost:5000/ |
| Workers.ValidateTransactions | http://localhost:5500/ |
| Workers.Hmrc | http://localhost:5501/ |
| Workers.OnboardingReminders | http://localhost:5502/ |
| Workers.ServiceBus | http://localhost:5503/ |
| Workers.DebitUsers | http://localhost:5504/ |

## A word of explenation
A few more manual steps are required for a completely local setup.

- Create a database in the SQL server.
- Run the database migration plan without Trendwatcher user
- Create a ServiceBus Namespace in Azure ***OPTIONAL***

## Database
#### 1. Connect to the local SQL server
![DBeaver Connect SQL](https://cdn.givtapp.net/database-connect.png)

#### 2. Create a database called "GivtDbDebug"

## Migrations
#### 1. Clone the [givt.api.application](https://bitbucket.org/nfcollect/givt.api.application) repository and update the submodules

#### 2. Comment everything in the following migrations
![Migrations](https://cdn.givtapp.net/migrations.png)

#### 3. Navigate to the Givt.DatabaseAccess directory in your terminal and execute the command  below
```
dotnet ef database update --startup-project ../../../src/Givt.API
```

## ServiceBus (Optional)
#### 1. Create a ServiceBus Namespace in Azure
![ServiceBus Namespace](https://cdn.givtapp.net/servicebus-namespace.png)

#### 2. Add all of the below queues
![ServiceBus Queues](https://cdn.givtapp.net/servicebus-queues.png)

#### 3. Get the ConnectionString to your namespace and replace it in the environment for every worker
