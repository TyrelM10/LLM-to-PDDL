(define (domain blocks-world)
    (:requirements :strips)
    (:predicates 
        (on ?b1 ?b2)    ; block ?b1 is on top of block ?b2
        (ontable ?b)    ; block ?b is on the table
        (clear ?b)      ; block ?b has nothing on top of it
    )

    (:action move
        :parameters (?b1 ?b2)
        :precondition (and 
            (clear ?b1)
            (ontable ?b1)
            (clear ?b2)
        )
        :effect (and 
            (not (ontable ?b1))
            (not (clear ?b2))
            (clear ?b1)
            (on ?b1 ?b2)
        )
    )

    (:action move-to-table
        :parameters (?b)
        :precondition (and 
            (clear ?b)
            (ontable ?b)
        )
        :effect (and 
            (not (on ?b ?x))
            (clear ?b)
            (ontable ?b)
        )
    )
)