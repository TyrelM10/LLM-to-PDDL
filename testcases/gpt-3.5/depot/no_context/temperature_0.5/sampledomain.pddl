
(define (domain logistics-blocks)
  (:requirements :strips :typing)
  
  (:types
    truck crate pallet hoist
  )
  
  (:predicates
    (truck ?t - truck)
    (crate ?c - crate)
    (pallet ?p - pallet)
    (hoist ?h - hoist)
    (on ?x ?y - crate)
    (empty ?p - pallet)
    (at ?t - truck ?x - crate)
    (holding ?h - hoist ?c - crate)
  )

  (:action load
    :parameters (?t - truck ?c - crate)
    :precondition (and (truck ?t) (crate ?c) (at ?t ?c) (empty ?p))
    :effect (and (not (at ?t ?c)) (holding ?h ?c))
  )

  (:action unload
    :parameters (?t - truck ?c - crate)
    :precondition (and (truck ?t) (crate ?c) (at ?t ?p) (holding ?h ?c))
    :effect (and (at ?t ?c) (not (holding ?h ?c)))
  )

  (:action stack
    :parameters (?h - hoist ?c - crate ?p - pallet)
    :precondition (and (hoist ?h) (crate ?c) (pallet ?p) (holding ?h ?c))
    :effect (and (not (holding ?h ?c)) (on ?c ?p))
  )

  (:action unstack
    :parameters (?h - hoist ?c - crate ?p - pallet)
    :precondition (and (hoist ?h) (crate ?c) (pallet ?p) (on ?c ?p))
    :effect (and (holding ?h ?c) (not (on ?c ?p)))
  )
)
