// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./TokenVesting.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IProject {
    function transfer(address, uint256) external;
    function addProfit(uint256) external;
}

contract AEV is ERC20 {
    address public owner;

    modifier onlyOwner(address _owner) {
        require(_owner == msg.sender, "Invalid owner!");
        _;
    }

    event StakeToProject(
        address indexed staker,
        address indexed project,
        uint256 amount
    );

    event CreateTokenVesting(address indexed tokenVesting);

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _amount
    ) ERC20(_name, _symbol) {
        owner = msg.sender;
        _mint(msg.sender, _amount);
    }

    function mint(uint256 _amount) public onlyOwner(owner) {
        _mint(msg.sender, _amount);
    }

    function stakeToProject(address _project, uint256 _amount) public {
        _transfer(msg.sender, _project, _amount);
        IProject(_project).transfer(msg.sender, _amount);
        emit StakeToProject(msg.sender, _project, _amount);
    }

    function payEnergy(address _project, uint256 _amount) public {
        _transfer(msg.sender, _project, _amount);
        IProject(_project).addProfit(_amount);
    }

    function createTokenVesting(
        string calldata _name,
        uint256 _amount
    ) public onlyOwner(owner) {
        TokenVesting tokenVesting = new TokenVesting(
            owner,
            _name,
            address(this)
        );

        _transfer(msg.sender, address(tokenVesting), _amount);

        emit CreateTokenVesting(address(tokenVesting));
    }
}
