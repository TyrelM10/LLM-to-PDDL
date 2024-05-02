
(define (domain LogisticsBlocksWorld)
  (:requirements :strips :typing)
  
  ;; Define object types
  (:types location truck crate pallet hoist)
  
  ;; Define predicates
  (:predicates
    (location ?x - object ?l - location)
    (truck-at ?t - truck ?l - location)
    (holding ?h - hoist ?o - object)
    (unloaded ?c - crate)
    (on ?c1 - crate ?c2 - crate)
    (ontable ?c - crate ?p - pallet)
    (free ?h - hoist)
    (clear ?x - crate)
    (carrying ?t - truck ?c - crate)
    (full ?p - pallet))
  
  ;; Define actions
  (:action load-crane
      :parameters (?h - hoist ?c - crate ?l - location)
      :precondition (and (unloaded ?c) (clear ?c) (location ?c ?l))
      :effect (and (not (unloaded ?c)) (holding ?h ?c)))
  
  (:action unload-crane
      :parameters (?h - hoist ?c - crate ?l - location)
      :precondition (holding ?h ?c)
      :effect (and (unloaded ?c) (not (holding ?h ?c)) (ontable ?c ?l)))
  
  (:action pick-up-crate
      :parameters (?t - truck ?c - crate ?l - location)
      :precondition (and (unloaded ?c) (clear ?c) (truck-at ?t ?l) (ontable ?c ?l))
      :effect (and (not (unloaded ?c)) (carrying ?t ?c)))
  
  (:action put-down-crate
      :parameters (?t - truck ?c - crate ?l - location)
      :precondition (and (carrying ?t ?c) (truck-at ?t ?l))
      :effect (and (unloaded ?c) (not (carrying ?t ?c)) (ontable ?c ?l)))
  
  (:action move-truck
      :parameters (?t - truck ?from - location ?to - location)
      :precondition (truck-at ?t ?from)
      :effect (and (not (truck-at ?t ?from)) (truck-at ?t ?to))))
