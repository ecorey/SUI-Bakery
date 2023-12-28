module bakery::counter {


    use sui::transfer;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};

    // shared Counter
    struct Counter has key {
        id: UID, 
        owner: address,
        value: u64
    }

    public fun owner(counter: &Counter): address {
        counter.owner
    }

    public fun value(counter: &Counter): u64 {
        counter.value
    }

    
    // create and share counter object
    public entry fun create(ctx: &mut TxContext) {
        transfer::share_object( Counter {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            value: 0
        })
    }




}