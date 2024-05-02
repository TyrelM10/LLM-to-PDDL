
(define (domain robot)
(:requirements :strips :typing)
(:types room ball - object)
(:constants i o - room)
(:predicates
    (robot_at ?r - room)
    (ball_at ?b - ball)
    (holding ?o - object)
    (unique-ball ?b)
    (at-other-room ?r))

(:action pickup
    :parameters (?r - room ?b - ball)
    :precondition (and (robot_at ?r) (ball_at ?r) (unique-ball ?b) (not (holding ?b)) (at-other-room ?r))
    :effect (and (holding ?b) (ball_at i) (robot_at i))
)

(:action at-other-room
    :parameters (?r - room)
    :precondition (robot_at o)
    :effect (robot_at ?r)
)

(:action putdown
    :parameters (?r - room ?b - ball)
    :precondition (holding ?b)
    :effect (and (ball_at ?r) (not (holding ?b)) (robot_at ?r))
)

(:action move
    :parameters (?from - room ?to - room ?b - ball)
    :precondition (and (robot_at ?from) (ball_at ?from) (not (= ?from ?to)) (not (holding ?b)))
    :effect (and (not (ball_at ?from)) (not (robot_at ?from)) (ball_at ?to) (robot_at ?to))
)
)
