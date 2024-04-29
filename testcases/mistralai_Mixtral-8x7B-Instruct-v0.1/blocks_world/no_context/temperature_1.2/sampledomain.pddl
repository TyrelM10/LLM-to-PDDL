
(define (domain blocks-world)
(:requirements :strips :typing)
(:types block)

(:predicates
    (ontable ?x - block)
    (clear ?x - block)
    (on ?x ?y - block)
    (holding ?x - block))

(:action pick-up
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x) (not (holding ?x)))
    :effect (and (not (ontable ?x)) (not (clear ?x)) (not (on ?x ?y))
                 (not (clear ?y)) (holding ?x)))

(:action put-down
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (ontable ?x) (clear ?x) (not (holding ?x))))

(:action stack
    :parameters (?x ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (on ?x ?y) (clear ?x) (not (holding ?x)) (not (clear ?y)))))

(:action unstack
    :parameters (?x ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (not (holding ?x)))
    :effect (and (clear ?y) (holding ?x) (not (on ?x ?y)) (not (clear ?x))))
