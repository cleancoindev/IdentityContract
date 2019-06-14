pragma solidity ^0.5.4;

import "./Identity.sol";
import "openzeppelin-solidity/contracts/drafts/Counters.sol";
import "zos-lib/contracts/Initializable.sol";
import "tabookey-gasless/contracts/RelayRecipient.sol";

contract IdentityFactory is RelayRecipient {

    using Counters for Counters.Counter;
    Counters.Counter public identityCount;

    mapping(uint => Identity) public identities;

    event identityCreated(address identityAddress, address owner);

    function createIdentity(address _owner) public {
        Identity identity;
        identity = new Identity();
        identity.initialize(_owner);
        identities[identityCount.current()] = identity;
        identityCount.increment();
        emit identityCreated(address(identity), _owner);
    }

        /*
    @GSN FUNCTIONS
    */
    function accept_relayed_call(address /*relay*/, address /*from*/,
        bytes memory /*encoded_function*/, uint /*gas_price*/, 
        uint /*transaction_fee*/ ) public view returns(uint32) {
    return 0; // accept everything.
    }
    // nothing to be done post-call.
    // still, we must implement this method.
    function post_relayed_call(address /*relay*/, address /*from*/,
        bytes memory /*encoded_function*/, bool /*success*/,
        uint /*used_gas*/, uint /*transaction_fee*/ ) public {
    }

    function init_hub(RelayHub hub_addr) public {
    init_relay_hub(hub_addr);
    }




}