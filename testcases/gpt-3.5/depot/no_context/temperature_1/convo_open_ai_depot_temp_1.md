**USER** :
This domain was devised in order to see what would happen if two previously well-researched domains were joined together. These were the logistics and blocks domains. They are combined to form a domain in which trucks can transport crates around and then the crates must be stacked onto pallets at their destinations. The stacking is achieved using hoists, so the stacking problem is like a blocks-world problem with hands. Trucks can behave like "tables", since the pallets on which crates are stacked are limited.
 
 Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.
**LLM MODEL** (CHAT_GPT):
```pddl
(define (domain logistics-and-blocks)
    (:requirements :strips)
    (:predicates 
        (At ?obj ?loc)
        (On ?crate ?pallet)
        (EmptyHand)
        (Holding ?obj)
        (Truck ?truck)
        (Pallet ?pallet)
        (Crate ?crate)
        (HoistAvailable)
    )
    
    (:action load
        :parameters (?crate ?truck)
        :precondition (At ?crate ?truck) 
        :effect (and (Holding ?crate) (not (At ?crate ?truck)) (not (EmptyHand)))
    )
    
    (:action unload
        :parameters (?crate ?truck)
        :precondition (and (Holding ?crate) (Truck ?truck))
        :effect (and (At ?crate ?truck) (not (Holding ?crate)) (EmptyHand))
    )
    
    (:action stack
        :parameters (?crate ?pallet)
        :precondition (and (Holding ?crate) (Pallet ?pallet) (HoistAvailable))
        :effect (and (On ?crate ?pallet) (not (Holding ?crate)) (HoistAvailable))
    )
    
    (:action unstack
        :parameters (?crate ?pallet)
        :precondition (and (On ?crate ?pallet) (Pallet ?pallet) (HoistAvailable))
        :effect (and (Holding ?crate) (not (On ?crate ?pallet)) (HoistAvailable))
    )
)

```