import { BigNumber } from "bignumber.js";
import { ether, gWei } from "../utils/units";

export const DEFAULT_GAS = 10000000;
export const DEFAULT_MOCK_TOKEN_DECIMALS = 18;
export const INVALID_OPCODE = "invalid opcode";
export const NULL_ADDRESS = "0x0000000000000000000000000000000000000000";
export const REVERT_ERROR = "revert";
export const DEPLOYED_TOKEN_QUANTITY: BigNumber = ether(100000000000);
export const STANDARD_QUANTITY_ISSUED: BigNumber = ether(10);
export const STANDARD_NATURAL_UNIT = ether(1);
export const STANDARD_COMPONENT_UNIT = ether(1);
export const UNLIMITED_ALLOWANCE_IN_BASE_UNITS = new BigNumber(2).pow(256).minus(1);

export const ZERO: BigNumber = new BigNumber(0);
export const ONE: BigNumber = new BigNumber(1);
