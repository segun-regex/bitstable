# Bitcoin-Backed Stablecoin System

A decentralized stablecoin system implemented in Clarity, backed by Bitcoin as collateral. This system allows users to create vaults, deposit Bitcoin collateral, and mint stablecoins while maintaining stability through carefully managed parameters and liquidation mechanisms.

## Features

- **Collateralized Debt Positions (CDPs)**: Create vaults backed by Bitcoin
- **Stablecoin Minting**: Mint stablecoins against deposited collateral
- **Dynamic Collateral Ratios**: Configurable minimum collateral and liquidation ratios
- **Price Oracle Integration**: Real-time BTC/USD price feeds
- **Liquidation System**: Automated liquidation of under-collateralized vaults
- **Governance Parameters**: Adjustable system parameters
- **Emergency Controls**: Emergency shutdown capability for system protection

## System Parameters

- Minimum Collateral Ratio: 150%
- Liquidation Ratio: 120%
- Annual Stability Fee: 2%
- Maximum Price: 1,000,000,000
- Minimum Price: 1
- Maximum Collateral Ratio: 1000%
- Minimum Collateral Ratio: 101%
- Maximum Stability Fee: 100%

## Getting Started

### Prerequisites

- Stacks blockchain node
- Clarity smart contract development environment
- Access to BTC/USD price feed

### Installation

1. Clone the repository
2. Deploy the contract to the Stacks blockchain
3. Initialize the contract with the current BTC/USD price

```clarity
(contract-call? .stablecoin-system initialize price)
```

### Usage

#### Creating a Vault

```clarity
(contract-call? .stablecoin-system create-vault collateral-amount)
```

#### Minting Stablecoins

```clarity
(contract-call? .stablecoin-system mint-stablecoin amount)
```

#### Repaying Debt

```clarity
(contract-call? .stablecoin-system repay-debt amount)
```

#### Withdrawing Collateral

```clarity
(contract-call? .stablecoin-system withdraw-collateral amount)
```

## Architecture

### Core Components

1. **Vault Management**

   - Vault creation
   - Collateral management
   - Debt tracking
   - Fee calculation

2. **Price Oracle System**

   - Authorized price feeds
   - Price validation
   - Update mechanisms

3. **Liquidation Engine**

   - Automated monitoring
   - Liquidator authorization
   - Collateral distribution

4. **Governance System**
   - Parameter adjustment
   - System upgrades
   - Emergency controls

## Security

This system implements multiple security measures:

- Authorized oracle system
- Strict parameter validation
- Emergency shutdown capability
- Role-based access control
- Collateral ratio enforcement

For more details, see [SECURITY.md](SECURITY.md).

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

## Code of Conduct

Please read our [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details on our code of conduct.
