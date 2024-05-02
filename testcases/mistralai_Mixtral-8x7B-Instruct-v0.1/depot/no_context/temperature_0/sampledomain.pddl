
(define (domain LogisticsBlocksWorld)
  (:requirements :strips :typing)
  
  ;; Define types of objects
  (:types truck crate pallet hoist agent location)

  ;; Define predicates
  (:predicates (at ?x - agent)
               (on-truck ?c - crate ?t - truck)
               (on ?c1 - crate ?c2 - crate)
               (ontop ?o - object ?b - crate)
               (clear ?b - crate)
               (handempty ?h - hoist)
               (holding ?h - hoist ?b - crate))

  ;; Define action schemas
  (:action PickUpCrane
    :parameters (?h - hoist ?b - crate)
    :precondition (and (ontop ?b (table)) (handempty ?h))
    :effect (and (not (ontop ?b (table))) (not (handempty ?h)) (holding ?h ?b)))

  (:action PutDownCrane
    :parameters (?h - hoist ?b - crate)
    :precondition (holding ?h ?b)
    :effect (and (not (holding ?h ?b)) (ontop ?b (table)) (handempty ?h)))

  (:action LoadPallet
    :parameters (?t - truck ?p - pallet ?c - crate)
    :precondition (and (at ?t) (on-truck ?c ?t) (clear ?p))
    :effect (and (not (on-truck ?c ?t)) (on ?c ?p)))

  (:action UnloadPallet
    :parameters (?t - truck ?p - pallet ?c - crate)
    :precondition (and (at ?t) (on ?c ?p) (clear ?t))
    :effect (and (not (on ?c ?p)) (on-truck ?c ?t))))
