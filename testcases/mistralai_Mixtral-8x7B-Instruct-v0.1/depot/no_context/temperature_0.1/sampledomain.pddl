
(define (domain logistics-blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types of objects
  (:types truck crate pallet hoist location)
  
  ;; Define predicates
  (:predicates
    (location ?x - object ?l - location)
    (clear ?x - object)
    (holding ?x - object)
    (on ?x - crate ?y - crate)
    (ontop ?x - crate ?y - pallet)
    (at-location ?t - truck ?l - location))
  
  ;; Define action schemas
  (:action pick-up-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (location ?c l1) (clear ?c) (at-location ?h l1) (ontop ?c nil))
    :effect (and (not (location ?c l1)) (not (ontop ?c nil)) (not (clear ?c)) (not (at-location ?h l1))
                (holding ?c) (on ?c ?h) (location ?c l2) (at-location ?h l1)))
  
  (:action put-down-crate
    :parameters (?c - crate ?h - hoist ?l1 - location ?l2 - location)
    :precondition (and (holding ?c) (on ?c ?h) (at-location ?h l1) (location ?c l2))
    :effect (and (not (holding ?c)) (not (on ?c ?h)) (clear ?h) (clear ?c)
                (ontop ?c nil) (location ?c l2) (at-location ?h l2)))
  
  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-location ?t from))
    :effect (and (not (at-location ?t from)) (at-location ?t to)))
  
  (:action load-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (clear h) (clear c) (ontop c nil))
    :effect (and (holding c) (not (ontop c nil)) (not (clear c)) (not (clear h)) (on c h)))
  
  (:action unload-crane
    :parameters (?t - truck ?c - crate ?h - hoist)
    :precondition (and (at-location t h) (holding c) (on c h))
    :effect (and (not (holding c)) (not (on c h)) (clear h) (clear c) (ontop c nil) (at-location c h)))
  
  (:action stack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (clear c2) (clear h) (ontop c2 nil))
    :effect (and (not (holding c1)) (not (ontop c2 nil)) (on c1 c2) (clear h) (clear c1)))
  
  (:action unstack-crates
    :parameters (?c1 - crate ?c2 - crate ?h - hoist)
    :precondition (and (holding c1) (on c1 c2))
    :effect (and (not (holding c1)) (not (on c1 c2)) (clear c1) (ontop c2 nil) (clear h))))
