// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { IOwnable } from "./IOwnable.sol";
import { IPhiNFT1155 } from "./IPhiNFT1155.sol";

// solhint-disable-next-line no-empty-blocks
interface IPhiNFT1155Ownable is IPhiNFT1155, IOwnable { }
