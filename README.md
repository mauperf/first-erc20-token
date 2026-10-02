# FirstERC20

A minimal ERC-20 token built with [Foundry](https://book.getfoundry.sh/) and [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/5.x/) v5.

The contract extends `ERC20` and `Ownable`, uses **6 decimals** instead of the default 18, and exposes an owner-only `mint`.

## Requirements

- [Foundry](https://book.getfoundry.sh/getting-started/installation) (`forge`, `cast`, `anvil`)

## Installation

```shell
git clone <repo-url>
cd first-erc20-token
forge install
```

`forge install` fetches the submodules in `lib/` (`forge-std` and `openzeppelin-contracts`). If you cloned without them:

```shell
git submodule update --init --recursive
```

## The contract

[`src/FirstERC20.sol`](src/FirstERC20.sol)

| Member | Description |
|---|---|
| `constructor(string _name, string _symbol)` | Deploys the token and sets the deployer as owner. |
| `decimals()` | Returns `6` (overrides the OpenZeppelin default of 18). |
| `mint(address _to, uint256 _amount)` | Mints tokens. Owner only; reverts if `_amount == 0`. |

The rest of the ERC-20 interface (`transfer`, `approve`, `balanceOf`, etc.) comes from OpenZeppelin.

## Usage

### Build

```shell
forge build
```

### Test

```shell
forge test
forge test -vvv          # with traces
```

The tests live in [`test/FirstERC20.t.sol`](test/FirstERC20.t.sol) and cover `mint` access control, the zero-amount revert, and the balance increase on the happy path.

### Format

```shell
forge fmt
```

### Gas snapshot

```shell
forge snapshot
```

## Deploy

1. Copy the example file and fill in your private key:

```shell
cp .env.example .env
```

```
PRIVATE_KEY=0x...
```

> `.env` is in `.gitignore`. Never commit a real private key.

2. Start a local network (optional, for testing):

```shell
anvil
```

3. Run the script:

```shell
source .env
forge script script/DeployFirstERC20.s.sol:DeployFirstERC20 \
  --rpc-url <your_rpc_url> \
  --broadcast
```

The script prints the deployed token address. For a dry run (no transactions sent), omit `--broadcast`.

## Interacting with the token

```shell
# Read the symbol
cast call <token_address> "symbol()(string)" --rpc-url <your_rpc_url>

# Mint 10 tokens (remember: 6 decimals)
cast send <token_address> "mint(address,uint256)" <recipient> 10000000 \
  --rpc-url <your_rpc_url> --private-key $PRIVATE_KEY

# Check the balance
cast call <token_address> "balanceOf(address)(uint256)" <recipient> --rpc-url <your_rpc_url>
```

## Project structure

```
src/FirstERC20.sol              # The token contract
test/FirstERC20.t.sol           # Tests
script/DeployFirstERC20.s.sol   # Deploy script
remappings.txt                  # @openzeppelin/contracts/ -> lib/openzeppelin-contracts/contracts/
foundry.toml                    # Foundry configuration
```

## Notes

- This is a learning project. The contract has no max supply: the owner can mint without limit.
- Solidity `0.8.36`, OpenZeppelin Contracts `v5.7.0`.
