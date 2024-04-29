
(define (domain robotic-grippers)
(:requirements :strips :typing)

(:types robot ball room - object)
(:constants g1 g2 - robot)

(:predicates
(carrying ?r - robot ?b - ball)
(in ?b - ball ?r - room)
(two-balls-in-room ?r - room)
(all-balls-transported)
)

(:action pick-up
:parameters (?r - robot ?b - ball ?from_room - room)
:precondition (and (not (carrying ?r ?b)) (in ?b ?from_room))
:effect (and (not (in ?b ?from_room)) (carrying ?r ?b))
)

(:action put-down
:parameters (?r - robot ?b - ball ?to_room - room)
:precondition (carrying ?r ?b)
:effect (and (in ?b ?to_room) (not (carrying ?r ?b)))
)

(:action move
:parameters (?r1 ?r2 - robot ?b1 ?b2 - ball ?from_room ?to_room - room)
:precondition (and (or (and (carrying ?r1 ?b1) (not (carrying ?r2 ?b2))) (and (carrying ?r2 ?b2) (not (carrying ?r1 ?b1)))) (not (two-balls-in-room ?to_room)) (not (all-balls-transported)))
:effect (and (in ?b1 ?to_room) (in ?b2 ?to_room) (not (two-balls-in-room ?from_room)) (two-balls-in-room ?to_room) (not (all-balls-transported)) (not (carrying ?r1 ?b1)) (not (carrying ?r2 ?b2)))
)

(:action check-goal
:parameters ()
:precondition (and (two-balls-in-room "room1") (two-balls-in-room "room2"))
:effect (all-balls-transported)
)
)
