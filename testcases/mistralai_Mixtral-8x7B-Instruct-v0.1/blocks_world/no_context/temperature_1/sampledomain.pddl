
(define (domain blocks-strips)
  (:requirements :strips :typing)
  
  (!declare (types block))
  (!declare (predicates (on ?x - block ?y - block)
                         (ontable ?x - block)
                         (clear ?x - block)))

  (:action move
    :parameters (?x ?y - block)
    :precondition (and (clear ?x) (ontable ?y) (distinct ?x ?y))
    :effect (and (not (clear ?x)) (not (ontable ?x))
                 (not (clear ?y)) (not (ontable ?y))
                 (on ?x ?y) (clear ?x))))
