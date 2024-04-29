
(define (domain delivery)
  (:requirements :strips)
  (:types package person location)
  (:predicates
    (holding ?x - package)
    (at ?x - person ?y - location)
    (clear ?x - location))
  (:action pick-up
    :parameters (?p - package ?l - location ?p2 - person)
    :precondition (and (at ?p2 ?l) (clear ?l) (not (holding ?p)))
    :effect (and (at ?p ?l) (holding ?p) (not (clear ?l)) (not (at ?p ?l)))))
  (:action put-down
    :parameters (?p - package ?l - location ?p2 - person)
    :precondition (holding ?p ?p2)
    :effect (and (at ?p ?l) (clear ?l) (not (holding ?p)) (at ?p ?l))))
  (:action move
    :parameters (?p1 - person ?l1 - location ?l2 - location)
    :precondition (and (at ?p1 ?l1) (clear ?l1))
    :effect (and (not (at ?p1 ?l1)) (at ?p1 ?l2) (clear ?l2) (not (clear ?l1)) (at ?p1 ?l2))))
