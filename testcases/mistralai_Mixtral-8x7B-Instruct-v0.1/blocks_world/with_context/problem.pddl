(define (problem blocks-1)
    (:domain blocks)
    (:objects
        A B C - block
    )
    (:init
        (clear A)
        (ontable A)
        (clear B)
        (ontable B)
        (clear C)
        (ontable C)
        (handempty)
    )
    (:goal
        (and (on A B) (on B C))
    )
)