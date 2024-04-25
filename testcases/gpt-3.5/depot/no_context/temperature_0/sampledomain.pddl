
(define (domain logistics-blocks)
  (:requirements :strips)
  
  (:types
    truck location - object
    crate pallet - object
  )

  (:predicates
    (at-truck ?t - truck ?l - location)
    (at-crate ?c - crate ?l - location)
    (at-pallet ?p - pallet ?l - location)
    (on ?c - crate ?p - pallet)
    (empty ?p - pallet)
    (hoist-free)
  )

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (at-truck ?t ?from)
    :effect (and (not (at-truck ?t ?from)) (at-truck ?t ?to))
  )

  (:action load-crate
    :parameters (?c - crate ?t - truck ?l - location ?p - pallet)
    :precondition (and (at-crate ?c ?l) (at-truck ?t ?l) (empty ?p))
    :effect (and (not (at-crate ?c ?l)) (on ?c ?p) (not (empty ?p)))
  )

  (:action unload-crate
    :parameters (?c - crate ?t - truck ?l - location ?p - pallet)
    :precondition (and (on ?c ?p) (at-truck ?t ?l))
    :effect (and (at-crate ?c ?l) (empty ?p))
  )

  (:action stack-crate
    :parameters (?c - crate ?p - pallet)
    :precondition (and (on ?c ?p) (at-pallet ?p ?l) (hoist-free))
    :effect (and (not (on ?c ?p)) (hoist-free))
  )

  (:action use-hoist
    :parameters (?p - pallet)
    :precondition (and (at-pallet ?p ?l) (empty ?p))
    :effect (not (hoist-free))
  )
)
