
(define (domain blocks-world-corrected)
  (:requirements :strips)

  (:types block)
  (:constants block0 block1 block2 - block)

  (:predicates
    (clear ?b - block)
    (ontable ?b - block)
    (on ?b1 - block ?b2 - block)
  )

  (:action move
    :parameters (?x ?y - block)
    :precondition (and (clear ?x) (ontable ?x) (clear ?y))
    :effect (and (not (clear ?x)) (not (ontable ?x)) (on ?x ?y) (clear ?y) (not (on ?z ?x)))
  )
)
