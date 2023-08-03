# Solidity Coding Style Guide

Writing well-structured Solidity code is essential for creating maintainable, secure, and efficient smart contracts. This guide outlines best practices and recommendations to enhance the readability and reliability of your code.


(Adapted from the following sources:)

* [Solidity Official Style Guide](https://docs.soliditylang.org/en/v0.8.0/style-guide.html#)
* [Chainlink GitHub Repository](https://github.com/smartcontractkit/chainlink/blob/2.3.0-hotfix-Op/contracts/STYLE.md)
* [Consensys Smart Contract Best Practices](https://consensys.github.io/smart-contract-best-practices/)

## Contract Layout
* License and Version
* Imports
* Errors
* Interfaces, Libraries, Contracts
* Type Declarations
* State Variables
* Events
* Modifiers
* Functions

### Function Layout
* Constructor
* Receive Function
* Fallback Function
* External Functions
* Public Functions
* Internal Functions
* Private Functions
* View & Pure Functions

## Variables
* Use camelCase for variable names.
* Prefix storage variables with s_.
```Solidity
uint256 private s_myVariable;
```
* Prefix immutable variables with i_.
```Solidity
address private immutable i_owner;
```
* Constants should be in all capital letters with underscores.
```Solidity
uint256 private constant MAX_VALUE = 100;
```
* Specify explicit data sizes for uint variables (e.g., uint8 to uint256).
* Declare variables as constant if their value won't change. (gas efficiency)
* Declare variables as immutable if assigned a value only once. (gas efficiency)
* Opt for private variables vs public for gas efficiency; expose them using getters.

## Functions
* Use camelCase for function names.
* Prefix private and internal methods with an underscore.
```Solidity
function _internalFunction() internal {
    // logic
}
```
* Clearly declare method visibility.
* Prefer external over public for functions meant for external use. (gas efficiency)

## Modifiers
* Use modifiers to minimize code duplication.
* Modifiers should not modify the contract's state, but rather read it.


## Events
* Use CamelCase for events names.
* Only trigger events on actual state changes.


## Errors
* Use CamelCase for errors names and it must follow the following format ContractName__ErrorName
* Prefer custom error types over emitting strings. (gas efficiency)
```Solidity
error Lottery__NotOwner();

modifier onlyOwner{
    if(msg.sender != i_owner) revert Lottery__NotOwner();
    _;
}

modifier onlyOwner{
    require(msg.sender == i_owner, "Only the owner can do this.");   
    _;
}
```

## External Calls

### Handle errors in external calls

Solidity offers low-level call methods that work on raw addresses: address.call(), address.callcode(), address.delegatecall(), and address.send(). These low-level methods never throw an exception, but will return false if the call encounters an exception. Make sure to handle the possibility that the call will fail, by checking the return value.

### Don't use transfer() or send().

.transfer() and .send() forward exactly 2,300 gas to the recipient. The goal of this hardcoded gas stipend was to prevent reentrancy vulnerabilities, but this only makes sense under the assumption that gas costs are constant. Recently EIP 1884 was included in the Istanbul hard fork. One of the changes included in EIP 1884 is an increase to the gas cost of the SLOAD operation, causing a contract's fallback function to cost more than 2300 gas. It's recommended to stop using .transfer() and .send() and instead use .call().

### Favor pull over push for external calls

External calls can fail accidentally or deliberately. To minimize the damage caused by such failures, it is often better to isolate each external call into its own transaction that can be initiated by the recipient of the call. This is especially relevant for payments, where it is better to let users withdraw funds rather than push funds to them automatically. Avoid combining multiple ether transfers in a single transaction.

### State change before external calls

Ensure that all state changes occur before making external calls, i.e., update balances or internal code before calling external code.

```Solidity
error transferFail();
error ceroBalance();

function withdraw(uint256 amount) external {
    uint256 balance = balances[msg.sender];
    if(balance <= 0) revert ceroBalance();
    balances[msg.sender] = 0;

    (bool success, ) = msg.sender.call{value: bal}("");
    if(!success) revert transferFail();
}
```
