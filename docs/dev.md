### Build

```sh
$ bun install
```

Build the contracts:

```sh
$ forge build
```

### Clean

Delete the build artifacts and cache directories:

```sh
$ forge clean
```

### Compile

Compile the contracts:

```sh
$ forge build
```

### Coverage

Get a test coverage report:

```sh
$ forge coverage --report summary --ir-minimum
```

### Deploy

forge script script/Deploy.s.sol:Deploy --rpc-url sepolia --broadcast --verify --legacy --ffi

forge script script/Deploy.s.sol:Deploy --rpc-url base_sepolia --broadcast --verify --legacy --ffi

forge script script/Deploy.s.sol:Deploy --rpc-url optimism_sepolia --broadcast --verify --legacy --ffi

forge script script/DeployWoCred.s.sol:Deploy --rpc-url cyber_testnet --broadcast --verify --verifier blockscout
--verifier-url https://api.socialscan.io/cyber-testnet/v1/explorer/command_api/contract --chain-id 111557560

forge script script/DeployBase.s.sol:Deploy --rpc-url optimism_sepolia --broadcast --verify --legacy --ffi

forge script script/DeployWoCred.s.sol:Deploy --rpc-url arbitrum_sepolia --broadcast --verify --legacy --ffi

forge script script/DeployBase.s.sol:Deploy --rpc-url sepolia --broadcast --verify --legacy --ffi

forge script script/DeployBase.s.sol:Deploy --rpc-url base_sepolia --broadcast --verify --legacy --ffi

forge script script/DeployDistributor.s.sol:Deploy --rpc-url base_sepolia --broadcast --verify --legacy --ffi

forge script script/DeploySender.s.sol:Deploy --rpc-url optimism --broadcast --verify --legacy --ffi

forge script script/DeployDistributor.s.sol:Deploy --rpc-url base --broadcast --verify --legacy --ffi

forge script script/Deploy.s.sol:Deploy --rpc-url bera_testnet --broadcast

forge script script/DeployWoCred.s.sol:Deploy --rpc-url bera_testnet --broadcast --verify --verifier blockscout
--verifier-url https://api.socialscan.io/cyber-testnet/v1/explorer/command_api/contract --chain-id 80084

forge script script/DeployWoCred.s.sol:Deploy --rpc-url zora_sepolia --broadcast --verify --verifier blockscout
--verifier-url https://testnet.explorer.zora.energy/api\? --chain-id 999999999

forge script script/Deploy.s.sol:Deploy --broadcast --rpc-url bera_testnet --verifier-url
'https://api.routescan.io/v2/network/testnet/evm/80084/etherscan' --etherscan-api-key "verifyContract"

### Format

Format the contracts:

```sh
$ forge fmt
```

### Gas Usage

Get a gas report:

```sh
$ forge test --gas-report
```

### Lint

Lint the contracts:

```sh
$ bun run lint
```

### Test

Run the tests:

```sh
$ forge test
```

Generate test coverage and output result to the terminal:

```sh
$ bun run test:coverage
```

Generate test coverage with lcov report (you'll have to open the `./coverage/index.html` file in your browser, to do so
simply copy paste the path):

```sh
$ bun run test:coverage:report
```

## License

This project is licensed under MIT.

##

```
cloc ./src --by-file
      24 text files.
      24 unique files.
       1 file ignored.

github.com/AlDanial/cloc v 2.00  T=0.05 s (527.7 files/s, 85660.4 lines/s)
--------------------------------------------------------------------------------------------------
File                                                           blank        comment           code
--------------------------------------------------------------------------------------------------
./src/Cred.sol                                                   103            144            548
./src/PhiFactory.sol                                              87            131            540
./src/art/PhiNFT1155.sol                                          43             78            234
./src/interfaces/IPhiFactory.sol                                  17             16            157
./src/lib/ContributeRewards.sol                                   24             22            122
./src/reward/PhiRewards.sol                                       20             39            109
./src/abstract/RewardControl.sol                                  32             33            102
./src/interfaces/ICred.sol                                        31            117             94
./src/reward/CuratorRewardsDistributor.sol                        24             29             90
./src/curve/BondingCurve.sol                                      20             41             75
./src/interfaces/IContributeRewards.sol                            9             13             66
./src/abstract/Claimable.sol                                      10             12             63
./src/lib/FixedPriceBondingCurve.sol                              10              3             51
./src/abstract/CreatorRoyaltiesControl.sol                        10             18             45
./src/interfaces/IPhiNFT1155.sol                                   7             13             43
./src/interfaces/IPhiRewards.sol                                   6             29             41
./src/interfaces/IRewards.sol                                     17             54             27
./src/interfaces/ICuratorRewardsDistributor.sol                    3             15             21
./src/interfaces/IBondingCurve.sol                                 8             28             19
./src/lib/MerkleProof.sol                                          5             21             18
./src/interfaces/IOwnable.sol                                      3              9             13
./src/interfaces/ICreatorRoyaltiesControl.sol                      5             20             12
./src/interfaces/IPhiNFT1155Ownable.sol                            2              2              4
./src/lib/Logo.sol                                                 3             13              3
--------------------------------------------------------------------------------------------------
SUM:                                                             499            900           2497
--------------------------------------------------------------------------------------------------
```

## TODO

- 4. AA abstraction erc1271
- 7. Gas Optimize
- 11. natspec
- 13. daily claim quest
- 14. Fiat payment

slither . --exclude-informational --exclude-low
