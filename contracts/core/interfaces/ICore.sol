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

/**
 * @title IVault
 * @author Set Protocol
 *
 * The IVault interface provides a light-weight, structured way to interact with the Vault
 * contract from another contract.
 */

 interface ICore {

    /**
     * Set vaultAddress. Can only be set by owner of Core.
     *
     * @param  _vaultAddress   The address of the Vault
     */
    function setVaultAddress(
        address _vaultAddress
    )
        external;

    /**
     * Set transferProxyAddress. Can only be set by owner of Core.
     *
     * @param  _transferProxyAddress   The address of the TransferProxy
     */
    function setTransferProxyAddress(
        address _transferProxyAddress
    )
        external;

    /**
     * Add a factory to the mapping of tracked factories.
     *
     * @param  _factoryAddress   The address of the SetTokenFactory to enable
     */
    function enableFactory(
        address _factoryAddress
    )
        external;

    /**
     * Disable a factory in the mapping of tracked factories.
     *
     * @param  _factoryAddress   The address of the SetTokenFactory to disable
     */
    function disableFactory(
        address _factoryAddress
    )
        external;

    /**
     * Disable a set token in the mapping of tracked set tokens.
     *
     * @param  _setAddress   The address of the SetToken to remove
     */
    function disableSet(
        address _setAddress
    )
        external;

    /**
     * Issue
     *
     * @param  _setAddress   Address of set to issue
     * @param  _quantity     Quantity of set to issue
     */
    function issue(
        address _setAddress,
        uint _quantity
    )
        public;

    /**
     * Function to convert Set Tokens into underlying components
     *
     * @param _setAddress   The address of the Set token
     * @param _quantity     The number of tokens to redeem
     */
    function redeem(
        address _setAddress,
        uint _quantity
    )
        public;

    /**
     * Deposit multiple tokens to the vault. Quantities should be in the
     * order of the addresses of the tokens being deposited.
     *
     * @param  _tokenAddresses   Array of the addresses of the ERC20 tokens
     * @param  _quantities       Array of the number of tokens to deposit
     */
    function batchDeposit(
        address[] _tokenAddresses,
        uint[] _quantities
    )
        public;

    /**
     * Withdraw multiple tokens from the vault. Quantities should be in the
     * order of the addresses of the tokens being withdrawn.
     *
     * @param  _tokenAddresses    Array of the addresses of the ERC20 tokens
     * @param  _quantities        Array of the number of tokens to withdraw
     */
    function batchWithdraw(
        address[] _tokenAddresses,
        uint[] _quantities
    )
        public;

    /**
     * Deposit any quantity of tokens into the vault.
     *
     * @param  _tokenAddress    The address of the ERC20 token
     * @param  _quantity        The number of tokens to deposit
     */
    function deposit(
        address _tokenAddress,
        uint _quantity
    )
        public;

    /**
     * Withdraw a quantity of tokens from the vault.
     *
     * @param  _tokenAddress    The address of the ERC20 token
     * @param  _quantity        The number of tokens to withdraw
     */
    function withdraw(
        address _tokenAddress,
        uint _quantity
    )
        public;

    /**
     * Deploys a new Set Token and adds it to the valid list of SetTokens
     *
     * @param  _factoryAddress  address       The address of the Factory to create from
     * @param  _components      address[]     The address of component tokens
     * @param  _units           uint[]        The units of each component token
     * @param  _naturalUnit     uint          The minimum unit to be issued or redeemed
     * @param  _name            string        The name of the new Set
     * @param  _symbol          string        The symbol of the new Set
     * @return setTokenAddress address        The address of the new Set
     */
    function create(
        address _factoryAddress,
        address[] _components,
        uint[] _units,
        uint _naturalUnit,
        string _name,
        string _symbol
    )
        public
        returns(address);

    function calculateTransferValue(
        uint _componentUnits,
        uint _naturalUnit,
        uint _quantity
    )
        pure
        internal
        returns(uint);
 }