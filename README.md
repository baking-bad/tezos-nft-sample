

# Bucket, shovel, rake, and molds

This is an attempt to bring together four tools for local development and debugging of smart contracts for Tezos:
* [Granary](https://stove-labs.github.io/granary/) — all-in-one toolkit for smart contract development;
* [LIGO](https://ligolang.org/) — high-level smart-contract language that compiles down to Michelson;
* [PyTezos](https://baking-bad.github.io/pytezos/) — Python SDK for Tezos;
* [Better Call Dev](https://better-call.dev/) — Michelson contract explorer.

![Me and the boys](https://memepedia.ru/wp-content/uploads/2019/06/ya-s-patsanami-mem.jpg)

### Requirements

Granary contains Tezos node (with client), and LIGO compiler, and also a set of scripts that control the containers and ease the interaction. It's shipped as npm package, and you need to have `docker` and `node.js v11.4+` previously installed. See [granary documentation](https://stove-labs.github.io/granary/docs/getting-started-install) for additional information.

PyTezos requires ` python 3.6+` installed and several system libraries: `libsodium` `libsecp256k1` and `libgmp` . Check [pytezos documentation](https://baking-bad.github.io/pytezos/#requirements) for OS-specific instructions.

### Setting up sandbox

Clone the repository and install dependencies:

```sh
git clone https://github.com/baking-bad/tezos-nft-sample
cd tezos-nft-sample
npm i
```

We need to initialize Granary settings before the first launch:

```sh
npm run init
```

Now can start the Tezos node:

```sh
npm run start
```

Awesome! Next step is adding several accounts and activating protocol:

```sh
npm run activate-alpha
```

That's it! There are few more commands you can use to control the node:

```sh
# Stop the node
npm run stop

# Remove all granary settings brought by init
npm run clean

# stop + clean + init + start + activate-alpha
npm run reset
```

### Compiling sources and testing

In this sample project we have LIGO sources in `src` directory and unit tests in `tests`

LIGO compiler is executed in a docker container, and it compiles all .ligo files in src folder down to Michelson.

```sh
npm run compile
```

Atm compilation errors are not visible in the terminal, so you have to open the file to read them, but this will be [resolved soon](https://gitlab.com/ligolang/ligo/merge_requests/66).

After we received Michelson sources we can use PyTezos high-level interface to write unit tests. If you are familiar with the `unittest` module in Python that will be super easy, if not - also easy :)

```sh
npm run test
```

### Deploying and calling a contract

The following commands are project specific and utilize pytezos-based client module. You can use standard `tezos-client` instead.

PyTezos client has several useful features, first automatic generation of the initial storage, and secondly implied interface annotations. This means that even if your code is not annotated, if it implements a well-known interface, the necessary annotations will be added to it (optional of course).

```sh
python -m client originate
npm run bake
```

There will be link in the terminal output containing originated contract id. It will be used in the following calls. The link leads to a page in the Michelson contract explorer (BCD), where you can inspect all the operations, script, and state.

```sh
python -m client mint --contract-id={contract_id} --token-id=42
npm run bake
```

```sh
python -m client burn --contract-id={contract_id} --token-id=42
npm run bake
```

This is how it's displayed at https://better-call.dev/sandbox/{contract_id}

![Better Call Dev](https://miro.medium.com/max/1361/1*FnOOownDvewBJ3fy0KKU_A.png)

### Further reading

Ask any question about PyTezos, Better Call Dev in Baking Bad telegram chat: [https://t.me/baking_bad_chat](https://t.me/baking_bad_chat)

#### Granary

[Documentation](https://stove-labs.github.io/granary/)

#### LIGO

[Language basics](https://ligolang.org/docs/language-basics/cheat-sheet/)

[Tutorial](https://ligolang.org/docs/next/tutorials/get-started/tezos-taco-shop-smart-contract/)

[Examples](https://gitlab.com/ligolang/ligo/tree/master/src/contracts)

#### PyTezos

[Introduction](https://medium.com/coinmonks/high-level-interface-for-michelson-contracts-and-not-only-7264db76d7ae)

[Quick start guide](https://baking-bad.github.io/pytezos/)

[Tutorial](https://medium.com/coinmonks/atomic-tips-berlin-workshop-materials-c5c8ee3f46aa)

#### Better Call Dev

[Overview](https://medium.com/coinmonks/michelson-rocks-but-you-better-call-dev-e23cd32a299a)

[Pick random contract](https://better-call.dev/)