# An ExpressJS - GraphQL Micro-Service for PANW

This micro-service is a simple application developed over the ExpressJS framework of NodeJS. It uses `GraphQL` as a API querying language.

### Following is the high level directory structure
    .
    ├── config                  # Holds all configurations JSON
    ├── controller              # Holds the logic for all the Queries and Mutations of GraphQL
    ├── helpers                 # Contains helper functions to facilitate easy development
    ├── schema                  # All Graphql related schema is present here
    ├── package.json
    └── README.md

### Following will give you a high level idea of the api endpoints the application will provide.

POST     `/graphql`                 # A simple test endpoint. Can be used for health-check

Query:   

``` 
{
    express,
    ping,
    users {
        email,
        name
    },
    user(email: "johndoe@google.com"){
        name,
        email
    }
}
```



### Setting up
To setup the application please follow the following steps

```bash
git clone <gir_repository_url>
cd node-graphql
npm install
```

### Testing

To run all the unit test cases simply run the following command

```bash
npm run test
```

To run all the test cases with code coverage, run the following command

```bash
npm run test-coverage
```

### Starting the application locally

Run the following command to start the application locally

```bash
npm run start
```