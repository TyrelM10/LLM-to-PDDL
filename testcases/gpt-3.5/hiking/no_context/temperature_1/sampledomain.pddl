
(define (domain walking_tour)
    (:requirements :strips)
    (:types person car - object)

    (:predicates 
        (at-point ?location - object)
        (has-car ?car - car)
        (has-tent ?location - object)
        (has-luggage ?location - object)
        (partners ?person - person)
        (tired ?person - person)
        (driven ?car - car)
    )

    (:action drive
        :parameters (?car - car ?from - object ?to - object)
        :precondition (and (has-car ?car) (at-point ?from))
        :effect (and (not (at-point ?from)) (at-point ?to) (driven ?car))
    )

    (:action walk
        :parameters (?from - object ?to - object ?person - person ?car - car)
        :precondition (and (at-point ?from) (partners ?person) (not (driven ?car)))
        :effect (and (not (at-point ?from)) (at-point ?to) (tired ?person))
    )

    (:action rest
        :parameters (?location - object ?person - person)
        :precondition (and (at-point ?location) (has-tent ?location) (tired ?person))
        :effect (and (not (tired ?person)))
    )
)
