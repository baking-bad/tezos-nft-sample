# Granary starter kit

Starter kit for [Granary](https://stove-labs.github.io/granary/) - the All-in toolkit for Tezos development.

## Getting started

> Before cloning the starter kit, make sure to go through Granary's [installation instructions](https://stove-labs.github.io/granary/docs/getting-started-install)

```zsh
# Clone the repository & pick an appropriate name
git clone https://github.com/stove-labs/granary-starter-kit.git my-granary-project
cd my-granary-project

# Install dependencies
npm i

# Initialize granary
npm run init

# Start the node
npm run start

# Activate the alpha protocol
npm run activate-alpha
```

## Deploying the example Ligo / Michelson contract

```zsh
# Deploys the counter contract
npm run originate

# Outputs 0
npm run get-storage

# Calls the contract with (Right 5); which means Increment(5) based on our Ligo contract
npm run invoke

# Outputs 5
npm run get-storage
```

## Available NPM scripts

All the available scripts can be found at `package.json`
