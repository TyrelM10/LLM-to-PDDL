(define (domain circular_route)

    (:requirements
        :strips
        :typing
        :durative-actions
        :equality
    )

    (:types
        location
        car
        person
        day
    )

    (:predicates
        (at ?x - person ?loc - location)
        (driving ?c - car)
        (tent_at ?loc - location)
        (leg_complete ?loc1 - location ?loc2 - location)
        (route_clockwise ?loc1 - location ?loc2 - location)
        (same_day ?d1 - day ?d2 - day)
    )

    (:action drive
        :parameters (?c - car ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at start (driving ?c) (at ?c ?from))
            (at start (not (at ?c ?to)))
            (at start (same_day ?d (increase ?d 1)))
            (at start (not (tent_at ?from)))
            (at start (not (tent_at ?to)))
        )
        :effect (and
            (at start (not (at ?c ?from)))
            (at end (at ?c ?to))
        )
    )

    (:action walk
        :parameters (?p1 - person ?p2 - person ?from - location ?to - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p1 ?from) (at ?p2 ?from) (route_clockwise ?from ?to) (same_day ?d (increase ?d 1))
            (not (at ?p1 ?to))
            (not (at ?p2 ?to))
            (tent_at ?from)
            (leg_complete ?from ?to)
        )
        :effect (and
            (not (at ?p1 ?from)) (not (at ?p2 ?from))
            (at ?p1 ?to) (at ?p2 ?to)
        )
    )

    (:action rest
        :parameters (?p - person ?loc - location ?d - day)
        :duration (= ?duration 1)
        :precondition (and 
            (at ?p ?loc) (tent_at ?loc) (same_day ?d (increase ?d 1))
        )
        :effect (and
            (not (at ?p ?loc))
            (at ?p ?loc)
        )
    )

)
