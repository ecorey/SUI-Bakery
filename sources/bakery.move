module bakery::bakery {

    // IMPORTS
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;


    // INIT
    fun init(ctx: &mut TxContext) {
        transfer::share_object(
            Counter {
                id: object::new(ctx),
                counter_flour: 0,
                counter_salt: 0,
                counter_yeast: 0,
                counter_dough: 0,
                counter_bread: 0,
            }
        )
    }


    // COUNTER
    struct Counter has key, store {
        id: UID,
        counter_flour: u64,
        counter_salt: u64,
        counter_yeast: u64,
        counter_dough: u64,
        counter_bread: u64,
    }

    public entry fun delete_counter(counter: Counter) {
        
        let Counter {
             id,
             counter_flour: _,
             counter_salt: _,
             counter_yeast: _,
             counter_dough: _,
             counter_bread: _, 
             } = counter;
        
        object::delete(id);
    }

    // FLOUR OBJECT -----------------------------------------
    struct Flour has key, store{
       id: UID,
        
    }


    // function to create a new object and return the object, as a public entry fun can transfer but not return an object
    fun new_flour( ctx: &mut TxContext): Flour {
        Flour {
          
          id: object::new(ctx),
            
        }

        
    }


    // function to create the flour object and tansfer it to the caller of the function
    public entry fun create_flour(counter_obj: &mut Counter, ctx: &mut TxContext) {
        let flour = new_flour(ctx);
        transfer::transfer(flour, tx_context::sender(ctx));

        counter_obj.counter_flour = counter_obj.counter_flour + 1;
    }   


    // function to deconstruct and delete the flour object
    public entry fun delete_flour(flour: Flour) {

        let Flour {
             id 
             } = flour;
        
        object::delete(id);
    }



    // SALT OBJECT -----------------------------------------
    // follows the same structure as the Flour object
    struct Salt has key, store {
       id: UID,
        
    }

    
    fun new_salt( ctx: &mut TxContext): Salt {
        Salt {
          
          id: object::new(ctx),
            
        }
    }


    public entry fun create_salt(counter_obj: &mut Counter, ctx: &mut TxContext) {
        let salt = new_salt(ctx);
        transfer::transfer(salt, tx_context::sender(ctx));

        counter_obj.counter_salt = counter_obj.counter_salt + 1;
    }   
    

    public entry fun delete_salt(salt: Salt) {
        
        let Salt {
             id 
             } = salt;
        
        object::delete(id);
    }



    // YEAST OBJECT -----------------------------------------
    // follows the same structure as the Flour object
    struct Yeast has key, store {
       id: UID,        
    }

    
    fun new_yeast( ctx: &mut TxContext): Yeast {
        Yeast {
          
          id: object::new(ctx),
            
        }
    }


    public entry fun create_yeast(counter_obj: &mut Counter, ctx: &mut TxContext) {
        let yeast = new_yeast(ctx);
        transfer::transfer(yeast, tx_context::sender(ctx));

        counter_obj.counter_yeast = counter_obj.counter_yeast + 1;
    }   
    

    public entry fun delete_yeast(yeast: Yeast) {
        
        let Yeast {
             id 
             } = yeast;
        
        object::delete(id);
    }



    // DOUGH OBJECT -----------------------------------------
    // follows the same structure as the Flour object with the exception of the create_dough function
    struct Dough has key, store {
        id: UID,
        
    }

    
    // function to take in Flour, Salt, and Yeast objects, delete them and create the dough object and transfer it to the caller of the function
    public entry fun create_dough(counter_obj: &mut Counter, flour: Flour, salt: Salt, yeast: Yeast, ctx: &mut TxContext) {
        
         let Flour {
             id 
             } = flour;
        
        object::delete(id);

        let Salt {
             id 
             } = salt;
        
        object::delete(id);

        let Yeast {
             id 
             } = yeast;
        
        object::delete(id);
        
        let dough = new_dough(ctx);
        transfer::transfer(dough, tx_context::sender(ctx));

        counter_obj.counter_dough = counter_obj.counter_dough + 1;
    }   

    
     fun new_dough( ctx: &mut TxContext): Dough {
        Dough {
          id: object::new(ctx),
        }
    }

    
    public entry fun delete_dough(dough: Dough) {
        
        let Dough {
             id 
             } = dough;
        
        object::delete(id);
    }

    
    // BREAD OBJECT -----------------------------------------
    // follows the same structure as the Flour object with the exception of the create_bread function
    struct Bread has key, store {
        id: UID,
        
    }


    // function to take in Dough object, delete them and create the bread object and transfer it to the caller of the function
    public entry fun create_bread(counter_obj: &mut Counter, dough: Dough, ctx: &mut TxContext) {
        
         let Dough {
             id 
             } = dough;
        
        object::delete(id);
 
        let bread = new_bread(ctx);
        transfer::transfer(bread, tx_context::sender(ctx));

        counter_obj.counter_bread = counter_obj.counter_bread + 1;
    }   

    
     fun new_bread( ctx: &mut TxContext): Bread {
        Bread {
          
          id: object::new(ctx),
            
        }
    }


    public entry fun delete_bread(bread: Bread) {
        
        let Bread {
             id 
             } = bread;
        
        object::delete(id);
    }

    





    
   // ----------------------------------------------------
   // TESTS
   // ----------------------------------------------------


    

    #[test]
    public fun test_bakery() {
        use sui::test_scenario;

        let admin = @0x123;
        let initial_owner = @0x456;

        let scenario_val = test_scenario::begin(admin);
        let scenario = &mut scenario_val;

        // tx1 setting up test environment
        {
            init(test_scenario::ctx(scenario));
        };

        // next test
        test_scenario::next_tx(scenario, initial_owner);
        {
            let counter = test_scenario::take_shared<Counter>(scenario);
            
            
            create_flour(&mut counter, test_scenario::ctx(scenario)); 
            let flour: Flour = test_scenario::take_from_sender(scenario); 
            delete_flour(flour); 

            delete_counter(counter);

        };

        test_scenario::end(scenario_val);
    }

}