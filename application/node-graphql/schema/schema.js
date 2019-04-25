// Default schema fro GraphQL APIs

const User = `
    type User {
        email: String,
        name: String
    }

    type Query {
        express: String
        ping: String
        users: [User]
        user(email: String): User
    }
`

module.exports = User;