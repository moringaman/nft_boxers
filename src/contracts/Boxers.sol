pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";


contract Boxers is Ownable, ERC721 {
    using SafeMath for uint;
    
    event NewBoxer(string name, uint id);
    // TODO:
    // add - bocrec id for chainlink updates
    // nationality
    // age
    // ko %
    // Chainlink
    
    struct boxer {
        uint id;
        string name;
        uint ranking;
        uint wins;
        uint losses;
        uint age;
        string weight;
        string url;
    }
    
    string[] public urls;
    mapping(string => bool) urlExists;
    mapping(uint => boxer) boxers;
    boxer[] public boxerArray;
    
    
    constructor() ERC721 ("BOXER", "BXR") public {}
    
    function mint(address _to, string memory _tokenURI, string memory _name, uint  _ranking, uint _wins, uint _losses, uint _draws, uint _age, string memory _weight ) public  returns (bool) {
        
        require(!urlExists[_tokenURI]);
        urls.push(_tokenURI);
        uint _id = urls.length -1;
        
         boxer memory myBoxer = boxer( _id, _name, _ranking, _wins, _losses, _age, _weight, _tokenURI );
        
        //  boxerArray.push(boxer(_id, _name, _ranking, _wins, _losses, _age, _weight, _tokenURI));
        
         boxerArray.push(myBoxer);
         boxers[_id] = myBoxer;
        emit NewBoxer(_name, _id );
        _mintWithTokenURI(_id, _to, _tokenURI);
        return true;
    }
    
    function _mintWithTokenURI(uint _id, address _to, string memory _tokenURI) internal {
        _mint(_to, _id);
        _setTokenURI(_id, _tokenURI);
         
        urlExists[_tokenURI] = true;
    }
    
    function getBoxer(uint _id) view public returns(boxer memory) {
        return boxers[_id];
    }
    
}
