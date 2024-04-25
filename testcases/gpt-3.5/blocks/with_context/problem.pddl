(define (problem blocks-world-problem)
    (:domain blocks-world)
    (:objects
        block1 block2 block3
    )
    (:init
        (clear block1)
        (clear block2)
        (clear block3)
        (ontable block1)
        (ontable block2)
        (ontable block3)
    )
    (:goal (and 
        (on block1 block2)
        (on block2 block3)
    ))
)
