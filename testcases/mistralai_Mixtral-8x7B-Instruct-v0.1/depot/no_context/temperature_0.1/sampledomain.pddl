
(define (domain truck_and_crane)
  (:requirements :strips :typing)
  
  (:types location crate agent - object)
  (:constants crane0 - agent)
  
  (:predicates
    (at ?a - agent ?l - location)
    (holding ?c - crate)
    (clear ?a - agent)
    (ontable ?c - crate))
  
  (:action pick-up
    :parameters (?c - crate ?a - agent ?l - location)
    :precondition (and (at ?a ?l) (ontable ?c) (clear ?a))
    :effect (and (not (ontable ?c)) (not (clear ?a)) (holding ?c) (not (at ?a ?l))))
  
  (:action put-down
    :parameters (?c - crate ?a - agent ?l - location)
    :precondition (and (at ?a ?l) (holding ?c))
    :effect (and (ontable ?c) (clear ?a) (not (holding ?c)) (at ?a ?l)))
  
  (:action move-agent
    :parameters (?a - agent ?from - location ?to - location)
    :precondition (and (at ?a ?from))
    :effect (and (not (at ?a ?from)) (at ?a ?to))))
