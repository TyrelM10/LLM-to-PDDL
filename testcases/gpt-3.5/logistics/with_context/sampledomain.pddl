(define (domain transportation)
    (:requirements :strips :typing)
    (:types city location airport - location truck airplane - object package - object)
    (:predicates 
        (at ?v - object ?l - location)
        (in ?p - package ?l - location)
        (connected ?c1 ?c2 - city)
        (can_drive ?t - truck)
        (can_fly ?a - airplane)
        (at_airport ?l - location)
    )

    (:action drive
        :parameters (?t - truck ?from ?to - location)
        :precondition (and 
            (at ?t ?from)
            (connected ?from ?to)
            (can_drive ?t)
        )
        :effect (and 
            (not (at ?t ?from))
            (at ?t ?to)
        )
    )

    (:action fly
        :parameters (?a - airplane ?from ?to - location)
        :precondition (and 
            (at ?a ?from)
            (at_airport ?from)
            (at_airport ?to)
            (can_fly ?a)
        )
        :effect (and 
            (not (at ?a ?from))
            (at ?a ?to)
        )
    )
)
