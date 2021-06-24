pragma solidity >= 0.5.0 < 0.8.6;

//----------------------------------------------------------------------------------
//  ERC20 token standard interface


contract ERC20Token {
    function totalSuplay() public view returns(uint);
    
    function balanceOf(address tokenOwner) public view returns (uint);

    function allowance(address tokenOwner, address spender) public view returns(uint remaining);
    
    function transfer(address to, uint token) public returns (bool success);
    
    function approve(address spender, uint tokens) public returns (bool success);
    
    function transferFrom(address from, address to,uint tokens) public returns (bool success);
    
    //Events
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

//----------------------------------------------------------------------------------
// Safe Math library

contract SafeMath {
    function safeAdd(uint a, uint b) public pure returns(uint c) {
        c = a + b;
        require(c >= a);
    }
    
    function safeSub(uint a, uint b) public pure returns(uint c) {
        require(b>= a);
        c = a - b;
    }
}

//----------------------------------------------------------------------------------
//pragma solidity >= 0.5.0 < 0.8.6;

contract myToken is ERC20Token, SafeMath{
//----------------------------------------------------------------------------------   
    //Initialize constructor
    constructor() public{
        name = "hero";
        symbol = "hr";
        decimals = 18;
        _totalSupply = 1000000;
        
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    } 
    
//----------------------------------------------------------------------------------
    string public name;
    string public symbol;
    uint8  public decimals;
    
    uint256 public _totalSupply;
    
    
    mapping(address => uint) balances;
    mapping(address => mapping(address =>uint)) allowed;
    
    
    function totalSuplay() public view returns (uint) {
        return _totalSupply - balances[address(0)];
        
    } 
    
    function balanceOf(address tokenOwner) public view returns (uint balance) {
       return balances[tokenOwner];
       
    }
    
    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
        
    }
    
    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
        
    }
    
    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }
    
    function transferFrom(address from, address to, uint tokens) public returns (bool) {
        balances[from] = safeSub(balances[from], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender],tokens);
    }
    


}