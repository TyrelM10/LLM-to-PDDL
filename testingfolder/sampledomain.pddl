
(define (domain gripper-strips)

    (:requirements :strips :typing)
    
    (:types
        ball room gripper
    )

    (:predicates
        (at-robot ?r - room)
        (at-ball ?b - ball ?r - room)
        (in-gripper ?g - gripper ?b - ball)
        (empty ?g - gripper)
        (goal-complete)
    )

    (:action pick-up
        :parameters (?r - room ?b - ball ?g - gripper)
        :precondition (and (at-robot ?r) (at-ball ?b ?r) (empty ?g))
        :effect (and (not (at-ball ?b ?r)) (in-gripper ?g ?b))
    )

    (:action drop
        :parameters (?r - room ?b - ball ?g - gripper)
        :precondition (and (at-robot ?r) (in-gripper ?g ?b))
        :effect (and (at-ball ?b ?r) (not (in-gripper ?g ?b)))
    )

    (:action move
        :parameters (?from - room ?to - room)
        :precondition (at-robot ?from)
        :effect (and (at-robot ?to) (not (at-robot ?from)))
    )

    (:action unload
        :parameters (?r - room ?g - gripper)
        :precondition (and (at-robot ?r) (empty ?g) (goal-complete))
        :effect (and (not (empty ?g)) (not (goal-complete)))
    )

)
