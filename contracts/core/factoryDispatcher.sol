/*
    Copyright 2018 Set Labs Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

pragma solidity 0.4.24;


import { DetailedERC20 } from "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import { ERC20 } from "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import { StandardToken } from "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import { SafeMath } from "zeppelin-solidity/contracts/math/SafeMath.sol";
import { ISetFactory } from "./interfaces/ISetFactory.sol";
import "../lib/AddressArrayUtils.sol";


/**
 * @title {Set}
 * @author Felix Feng
 *
 * @dev Factory Dispatcher is responsible for dispatching Set Token creation to the
 * correct Set Token Factory.
 *
 */

 contract FactoryDispatcher {

    /* ============ State Variables ============ */

    //Mapping of Factory IDs to the factory contract
    mapping (uint => address) public setTokenFactories;

    /* ============ Events ============ */

    event FactoryUpdated(
        uint indexed _factoryId,
        address indexed _newFactoryAddress,
        address indexed _oldFactoryAddress,
        address _addedBy
    );

    /* ============ No Constructor ============ */

    /* ============ Setter Functions ============ */

    function updateTokenFactory(
        uint _factoryId,
        address _newFactoryAddress,
        address _oldFactoryAddress
    )
        external
    {
        //Check that new Factory address is not 0
        require(_newFactoryAddress == address(0));

        // To prevent unintentional overwrite make sure that oldAddress passed is
        // equal to current address. If no current address, then _oldFactoryAddress
        // should be zero.
        address currentFactoryAddress = setTokenFactories[_factoryId];
        require(currentFactoryAddress == _oldFactoryAddress);

        //Set new factory address to index
        setTokenFactories[_factoryId] = _newFactoryAddress;

        //Emit FactoryUpdated event
        emit FactoryUpdated(
            _factoryId,
            _newFactoryAddress,
            _oldFactoryAddress,
            msg.sender
        );
    }
}
