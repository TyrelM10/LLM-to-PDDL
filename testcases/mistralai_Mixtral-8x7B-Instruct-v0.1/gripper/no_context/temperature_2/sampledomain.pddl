
(define (domain robots-with-grippers)
(:requirements :strips :typing)
(:types room object ball - object)
(:constants (robot1 - robot))
(:predicates
    (carrying ?r - robot ?b - ball)
    (in-room ?o - object ?r - room)
    (at-room ?x - robot ?r - room))

(:action pickup
    :parameters (?r - room ?ball - ball)
    :precondition (and (in-room ?ball ?r) (at-room robot1 ?r))
    :effect (and (not (in-room ?ball ?r)) (carrying robot1 ?ball) (not (at-room robot1 ?r))))

(:action putdown
    :parameters (?r - room ?ball - ball)
    :precondition (carrying robot1 ?ball)
    :effect (and (in-room ?ball ?r) (not (carrying robot1 ?ball)) (at-room robot1 ?r)))

(:action move
    :parameters (?from - room ?to - room)
    :precondition (at-room robot1 ?from)
    :effect (and (not (at-room robot1 ?from)) (at-room robot1 ?to))))
