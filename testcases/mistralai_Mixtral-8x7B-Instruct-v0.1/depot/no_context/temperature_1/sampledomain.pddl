
(define (domain truck_hoist)
(:requirements :strips :typing)
(:types crate truck pallet hoist location)

(:predicates
    (on ?c1 - crate ?c2 - crate)        ; Crate C1 is on top of crate C2
    (ontable-p ?x - object)             ; Object X is on the table or truck
    (clear-p ?x - object)               ; No other object is directly above X
    (holding-p ?h - hoist ?o - object)  ; Hoist H is holding object O
    (at-location-truck-p ?t - truck ?l - location); Truck T is located at L
    (at-location-object-p ?x - object ?l - location); Object X is located at L
    (adjacent-locations-p ?l1 - location ?l2 - location) ; Location L1 is adjacent to L2
)

(:action pickup
    :parameters (?h - hoist ?x - object ?l1 - location ?l2 - location)
    :precondition (and (at-location-object-p ?h l1) (at-location-object-p ?x l1) (adjacent-locations-p l1 l2))
    :effect (and (not (at-location-object-p ?x l1)) (not (at-location-object-p ?h l1))
                 (at-location-object-p ?h l2) (at-location-object-p ?x l2) (holding-p ?h ?x))
)

(:action putdown
    :parameters (?h - hoist ?x - object ?l1 - location ?l2 - location)
    :precondition (and (at-location-object-p ?h l1) (at-location-object-p ?x l1) (holding-p ?h ?x) (adjacent-locations-p l1 l2))
    :effect (and (not (holding-p ?h ?x)) (at-location-object-p ?h l2) (at-location-object-p ?x l2) (ontable-p ?x))
)

(:action load
    :parameters (?t - truck ?c - crate ?l1 - location ?l2 - location)
    :precondition (and (at-location-truck-p ?t l1) (at-location-object-p ?c l1) (ontable-p ?c) (adjacent-locations-p l1 l2))
    :effect (and (not (ontable-p ?c)) (not (at-location-object-p ?c l1))
                 (at-location-object-p ?c l2) (at-location-truck-p ?t l2))
)

(:action unload
    :parameters (?t - truck ?c - crate ?l1 - location ?l2 - location)
    :precondition (and (at-location-truck-p ?t l1) (at-location-object-p ?c l1) (at-location-truck-p ?t l2) (at-location-object-p ?c l2))
    :effect (and (not (at-location-object-p ?c l2)) (not (at-location-truck-p ?t l2))
                 (ontable-p ?c) (at-location-object-p ?c l1) (at-location-truck-p ?t l1))
)

(:action move
    :parameters (?t1 - truck ?t2 - truck ?l1 - location ?l2 - location)
    :precondition (and (at-location-truck-p ?t1 l1) (at-location-truck-p ?t2 l1) (adjacent-locations-p l1 l2))
    :effect (and (not (at-location-truck-p ?t1 l1)) (not (at-location-truck-p ?t2 l1))
                 (at-location-truck-p ?t1 l2) (at-location-truck-p ?t2 l2))
)

)
