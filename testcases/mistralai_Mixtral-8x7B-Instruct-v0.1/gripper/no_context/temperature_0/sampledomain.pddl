
(define (domain robots-with-grippers)
(:requirements :strips :typing)
(:types robot gripper location)
(:constants
    - empty-robot - robot
    left-gripper right-gripper - gripper)
(:predicates
    (carrying ?r - robot ?o - object)
    (inroom ?o - object ?l - location)
    (at ?r - robot ?l - location)
    (same-room ?l1 - location ?l2 - location)
    (location-of ?o - object ?l - location))

(:action pick-up
    :parameters (?r - robot ?g - gripper ?o - object)
    :precondition (and (carrying empty-robot nil) (inroom ?o (location-of ?o)) (at ?r (location-of ?o)) (at ?r ?g))
    :effect (and (not (inroom ?o (location-of ?o))) (not (at ?r (location-of ?o))) (carrying ?r ?o)))

(:action put-down
    :parameters (?r - robot ?g - gripper ?o - object ?l - location)
    :precondition (and (carrying ?r ?o) (at ?r ?l) (location-of ?o ?l2) (same-room ?l ?l2))
    :effect (and (inroom ?o ?l) (at ?r ?l)
            (not (carrying ?r ?o))))

(:action move
    :parameters (?r - robot ?l - location)
    :precondition (and (at ?r (location-of ?r)) (same-room (location-of ?r) ?l))
    :effect (at ?r ?l)))
