
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
