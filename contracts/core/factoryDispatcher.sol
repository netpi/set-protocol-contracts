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

import { Ownable } from "zeppelin-solidity/contracts/ownership/Ownable.sol";


/**
 * @title {Set}
 * @author Felix Feng
 *
 * @dev Factory Dispatcher is responsible for dispatching Set Token creation to the
 * correct Set Token Factory.
 *
 */

 contract FactoryDispatcher is
    Ownable
 {

    /* ============ Constants ============ */
    string constant INVALID_FACTORY = "Factory is disabled or does not exist.";

    /* ============ State Variables ============ */

    // Mapping of tracked SetToken factories
    mapping(address => bool) public validFactories;

    /* ============ Events ============ */

    event NewFactoryAdded(
        address indexed _newFactoryAddress,
        address _addedBy
    );

    event FactoryRemoved(
        address indexed _factoryAddress,
        address _addedBy
    );

    /* ============ State Variables ============ */

    //Verify factory is known to Core
    modifier isValidFactory(address _factoryAddress) {
        require(
            validFactories[_factoryAddress],
            INVALID_FACTORY
        );
        _;
    }

    /* ============ No Constructor ============ */

    /* ============ Setter Functions ============ */

    function addNewFactory(
        address _newFactoryAddress
    )
        external
        onlyOwner
    {
        //Check that new Factory address is not 0
        require(_newFactoryAddress == address(0));

        //Set new factory address to index
        validFactories[_newFactoryAddress] = true;

        //Emit NewFactoryAdded event
        emit NewFactoryAdded(
            _newFactoryAddress,
            msg.sender
        );
    }

    function removeFactory(
        address _factoryAddress
    )
        external
        onlyOwner
        isValidFactory(_factoryAddress)
    {
        //Set factory address to false
        validFactories[_factoryAddress] = false;

        //Emit FactoryRemoved event
        emit FactoryRemoved(
            _factoryAddress,
            msg.sender
        );
    }
}
