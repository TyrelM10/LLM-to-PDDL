(define (domain combined-logistics-blocks)
  (:requirements :strips :typing)
  (:types
    crate pallet truck hoist location)
  
  (:predicates
    (at-truck ?t - truck ?l - location)
    (at-hoist ?h - hoist ?l - location)
    (at-crate ?c - crate ?l - location)
    (on-crate ?c - crate ?p - pallet)
    (on-truck ?c - crate ?t - truck)
    (on-pallet ?c - crate ?p - pallet)
    (empty-hoist ?h - hoist)
    (empty-pallet ?p - pallet)
    (empty-truck ?t - truck)
  )
  
  (:action load-truck
    :parameters (?c - crate ?t - truck ?l - location)
    :precondition (and (at-crate ?c ?l) (at-truck ?t ?l) (empty-truck ?t))
    :effect (and (not (at-crate ?c ?l)) (on-truck ?c ?t) (not (empty-truck ?t)))
  )
  
  (:action unload-truck
    :parameters (?c - crate ?t - truck ?l - location)
    :precondition (and (on-truck ?c ?t) (at-truck ?t ?l))
    :effect (and (not (on-truck ?c ?t)) (at-crate ?c ?l) (empty-truck ?t))
  )
  
  (:action load-pallet
    :parameters (?c - crate ?p - pallet ?h - hoist ?l - location)
    :precondition (and (at-crate ?c ?l) (at-hoist ?h ?l) (empty-hoist ?h) (empty-pallet ?p))
    :effect (and (not (at-crate ?c ?l)) (on-pallet ?c ?p) (not (empty-pallet ?p)))
  )
  
  (:action unload-pallet
    :parameters (?c - crate ?p - pallet ?h - hoist ?l - location)
    :precondition (and (on-pallet ?c ?p) (at-hoist ?h ?l))
    :effect (and (not (on-pallet ?c ?p)) (at-crate ?c ?l) (empty-pallet ?p))
  )
)
