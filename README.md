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