# An ExpressJS - SFDC Micro-Service for PANW

This micro-service is a simple application developed over the ExpressJS framework of NodeJS. It uses `jsforce` plugin of `Salesforce` to connect ot salesforce and get dna update data.

### Following is the high level directory structure
    .
    ├── config                  # Holds all configurations JSON
    ├── helpers                 # Helper functions
    ├── routes                  # All the routes and sub-
    │   └── v1                  # Routes to all v1 API
    ├── services                # All Services and 3rd party connectors (SFDC)
    ├── package.json
    └── README.md

### Following will give you a high level idea of the api endpoints the application will provide.

GET     `/ping`                 # A simple test endpoint. Can be used for health-check

GET     `/api/v1/sfdc`          # Get all ID and Name from the Account database



### Setting up
To setup the application please follow the following steps

```bash
git clone <gir_repository_url>
cd node-express
npm install
```

### Testing

To run all the unit test cases simply run the following command

```bash
npm run test
```

To run all the test cases with code coverage, run the following command

```bash
npm run test-sfdc
```

### Starting the application locally

Run the following command to start the application locally

```bash
npm run start
```