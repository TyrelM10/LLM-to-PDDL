
(define (domain blocks-world)
    (:requirements :strips)
    (:predicates 
        (on-table ?b - cube)
        (on ?b1 - cube ?b2 - cube)
        (clear ?b - cube)
    )

    (:action pickup
        :parameters (?b - cube)
        :precondition (and (clear ?b) (on-table ?b))
        :effect (and (not (on-table ?b)) (not (clear ?b)))
    )

    (:action putdown
        :parameters (?b - cube)
        :precondition ()
        :effect (and (on-table ?b) (clear ?b))
    )

    (:action stack
        :parameters (?b1 - cube ?b2 - cube)
        :precondition (and (clear ?b2) (clear ?b1) (not (= ?b1 ?b2)))
        :effect (and (not (clear ?b2)) (on ?b1 ?b2) (clear ?b1))
    )

    (:action unstack
        :parameters (?b1 - cube ?b2 - cube)
        :precondition (and (on ?b1 ?b2) (clear ?b1))
        :effect (and (clear ?b2) (clear ?b1) (not (on ?b1 ?b2)))
    )
)
