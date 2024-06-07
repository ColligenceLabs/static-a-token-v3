// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {EthereumScript, SepoliaScript, PolygonScript, AvalancheScript, ArbitrumScript, OptimismScript, MetisScript, BaseScript, BNBScript, ScrollScript, BaseScript, GnosisScript} from 'aave-helpers/ScriptUtils.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscSepolia} from 'aave-address-book/MiscSepolia.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {AaveV3Ethereum, IPool} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Sepolia} from 'aave-address-book/AaveV3Sepolia.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {ITransparentProxyFactory} from 'solidity-utils/contracts/transparent-proxy/interfaces/ITransparentProxyFactory.sol';
import {StaticATokenFactory} from '../src/StaticATokenFactory.sol';
import {StaticATokenLM} from '../src/StaticATokenLM.sol';
import {UpgradePayload} from '../src/UpgradePayload.sol';
import {IRewardsController} from 'aave-v3-periphery/contracts/rewards/interfaces/IRewardsController.sol';
import {Upgrades, UnsafeUpgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import { Options, DefenderOptions } from "openzeppelin-foundry-upgrades/Options.sol";

library DeployUpgrade {
    function _deploy(
        address factoryImpl
    ) internal returns (address) {
        console.logBytes(abi.encodeCall(StaticATokenFactory.initialize, ()));
        address proxy = UnsafeUpgrades.deployTransparentProxy(
            address(factoryImpl),
            address(0x1716C4d49E9D81c17608CD9a45b1023ac9DF6c73),
            abi.encodeCall(StaticATokenFactory.initialize, ())
        );
        console.logAddress(proxy);
        return proxy;
    }

    function deployProxy() internal returns (address) {
        return
            _deploy(address(0x5dac99bc3fa10c49c7580870DCc095f5675d8CcD));
    }
}

// make deploy-ledger contract=scripts/DeployUpgrade.s.sol:DeploySepolia chain=sepolia
contract DeploySepolia is SepoliaScript {
    function run() external broadcast {
        DeployUpgrade.deployProxy();
    }
}
