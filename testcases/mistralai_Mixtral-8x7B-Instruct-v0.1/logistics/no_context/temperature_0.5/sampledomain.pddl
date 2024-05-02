
(define (domain delivery-robot)
(:requirements :strips :typing)
(:types robot location package - object)
(:constants
    home - location
    office - location
    warehouse - location
    r1 - robot
    pkg1 pkg2 pkg3 - package)
(:predicates
    (at ?r - robot ?l - location)
    (carrying ?r - robot ?p - package)
    (full ?r - robot)
    (free ?r - robot)
    (at-destination ?package - package))
(:action pickup
    :parameters (?r - robot ?p - package ?l - location)
    :precondition (and (at ?r ?l) (not (full ?r)) (at-destination ?p) (not (carrying ?r ?p)))
    :effect (and (at-destination ?p) (not (at-destination ?p)) (carrying ?r ?p) (full ?r)))
(:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (at ?r ?from) (free ?r))
    :effect (and (not (at ?r ?from)) (at ?r ?to) (not (free ?r)) (free ?r) (not (at ?r ?to)) (at ?r ?to)))
(:action dropoff
    :parameters (?r - robot ?p - package ?l - location)
    :precondition (and (at ?r ?l) (carrying ?r ?p) (at-destination ?p))
    :effect (and (at-destination nil) (not (carrying ?r ?p)) (not (full ?r)) (free ?r)))
(:action load
    :parameters (?r - robot ?p - package ?l - location)
    :precondition (and (at ?r ?l) (free ?r) (or (eq ?p pkg1) (eq ?p pkg2) (eq ?p pkg3)))
    :effect (and (carrying ?r ?p) (full ?r) (not (free ?r)))))
