
(define (domain truck-crane)
  (:requirements :strips :typing)
  
  ;; Types
  (:types crate truck pallet hoist location)
  
  ;; Constant definitions
  (:constants
    ;; Locations
    loc1 - location
    loc2 - location
    
    ;; Cranes & Hoists
    hoist1 - hoist
    hoist2 - hoist
    
    ;; Pallets
    palletA - pallet
    palletB - pallet
    
    ;; Trucks
    truck1 - truck
    truck2 - truck
    
    ;; Crates
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
  )
  
  ;; Predicates
  (:predicates
    (on ?c - crate ?p - pallet)         ; A crate is on a pallet
    (holding ?h - hoist ?c - crate)      ; A hoist holds a crate
    (clear ?x - object)                 ; An object has nothing on top of it
    (at-truck ?t - truck ?l - location)  ; A truck is at a location
    (at-hoist ?h - hoist ?l - location)  ; A hoist is at a location
  )
  
  ;; Action schemas
  (:action pick-up-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (at-hoist ?h ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)))
              (holding ?h ?c) (not (holding ?h nil))
  )
  
  (:action put-down-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (holding ?h ?c) (clear ?l) (at-hoist ?h ?l))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (on ?c nil) (clear ?c) (at-hoist ?h ?l)
  )
  
  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-truck ?t ?from))
    :effect (and (not (at-truck ?t ?from)) (at-truck ?t ?to))
  )
  
  (:action load-crate-onto-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at-truck ?t ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)) (on ?c ?t))
  )
  
  (:action unload-crate-from-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at-truck ?t ?l) (on ?c ?t))
    :effect (and (not (on ?c ?t)) (clear ?c) (on ?c nil))
  )
  
  (:action lift-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h ?c) (clear ?pl))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (not (clear ?pl)) (clear ?pl)
            (on ?c ?pl) (not (on ?c nil))
  )
  
  (:action lower-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h nil) (on ?c ?pl))
    :effect (and (holding ?h ?c) (not (holding ?h nil)))
            (clear ?pl) (not (clear ?pl))
            (on ?c nil) (not (on ?c ?pl))
  )
)
