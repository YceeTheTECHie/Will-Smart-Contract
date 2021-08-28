// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Will {
address owner;
uint fortune;
bool Deceased;

constructor()payable {
    owner =  msg.sender;
    fortune = msg.value;
    Deceased = false;
}

address payable[] childrenWallets;

// create modifiers to restrict access
modifier onlyOwner {
    require(msg.sender == owner);
    _;
}

modifier isDeceased {
    require(Deceased == true);
    _;
}

mapping(address => uint) children;

    function setInheritance(address payable wallet, uint amount)public onlyOwner{
    childrenWallets.push(wallet);
    children[wallet] = amount;
    }
    function payOut() private isDeceased{
        for(uint i =0; i<childrenWallets.length;i++){
            // transferring crypto to childrens' wallet
        childrenWallets[i].transfer(children[childrenWallets[i]]);
        }
    }

    function hasBeenDeceased() public onlyOwner{
        Deceased = true;
        payOut();
    }
} 
