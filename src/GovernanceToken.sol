//SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title GovernanceToken
 * @dev A governance token contract based on ERC20 and Ownable.
 * This token represent the voting power in the DAO.
 */
contract GovernanceToken is ERC20, Ownable {
    mapping(address => bool) public hasDelegated;
    mapping(address => address) public delegates;
    mapping(address => uint256) public delegatedVotes;

    event VotingPowerDelgated(address indexed delegator, address indexed delegate, uint256 indexed amount);
    event VotingPowerUndelgated(address indexed delegator, address indexed delegate, uint256 indexed amount);

    /**
     * @dev Constructor to initialize the governance token with name, symbol, and initial supply.
     * @param name The name of the token.
     * @param symbol The symbol of the token.
     * @param initialSupply The initial supply of the token to be minted to the deployer.
     */
    constructor(string memory name, string memory symbol, uint256 initialSupply)
        ERC20(name, symbol)
        Ownable(msg.sender)
    {
        _mint(msg.sender, initialSupply);
    }

    /*____________________________________________EXTERNAL FUNCTIONS _____________________________________________*/

    /**
     * @dev Delegates voting power to another address.
     * @param delegate The address to delegate voting power to.
     * @param amount The amount of voting power to delegate.
     */

    function delegateVotingPower(address delegate, uint256 amount) external {
        require(delegate != address(0), "Cannot delegate to zero address.");
        require(delegate != msg.sender, "Cannot delegate to self.");
        require(amount > 0, "Amount must be greater than 0.");
        require(balanceOf(msg.sender) >= amount, "Inssufficient balance.");

        _transfer(msg.sender, delegate, amount);
        delegates[msg.sender] = delegate;
        delegatedVotes[delegate] += amount;
        hasDelegated[msg.sender] = true;

        emit VotingPowerDelgated(msg.sender, delegate, amount);
    }

    /**
     * @dev Undelegates voting power from the previously delegated address.
     * @param amount The amount of voting power to undelegate.
     */
    function undelegatedVotingPower(uint256 amount) external {
        require(hasDelegated[msg.sender], "Cannot undelegate if no voting power has been delegated.");
        require(amount > 0, "Amount must be greater than 0.");
        require(delegatedVotes[delegates[msg.sender]] >= amount, "Cannot undelegate more than delegated amount.");

        address delegate = delegates[msg.sender];
        _transfer(delegate, msg.sender, amount);

        delegatedVotes[delegate] -= amount;
        if (delegatedVotes[delegate] == 0) {
            hasDelegated[msg.sender] = false;
            delete delegates[msg.sender];
        }

        emit VotingPowerUndelgated(msg.sender, delegate, amount);
    }

    /**
     * @dev Returns the voting power of an account(including delegated votes).
     * @param account The address to check the voting power for.
     * @return balanceOf Total voting power of the account.
     */
    function getVotingPower(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
