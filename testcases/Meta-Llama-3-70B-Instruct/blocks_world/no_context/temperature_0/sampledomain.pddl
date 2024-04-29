
(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:action move-block-to-table
    :parameters (?block?y)
    :precondition (and (on?block?y) (clear?block) (hand-empty))
    :effect (and (on-table?block) (not (on?block?y)) (not (clear?y)) (not (hand-empty)))
  )
  (:action move-block-to-block
    :parameters (?block?target?y)
    :precondition (and (on?block?y) (clear?block) (clear?target) (hand-empty))
    :effect (and (on?block?target) (not (on?block?y)) (not (clear?target)) (not (hand-empty)))
  )
  (:action pick-up-block-from-table
    :parameters (?block)
    :precondition (and (on-table?block) (clear?block) (hand-empty))
    :effect (and (not (on-table?block)) (clear?block) (not (hand-empty)))
  )
  (:action pick-up-block-from-block
    :parameters (?block?target)
    :precondition (and (on?block?target) (clear?block) (hand-empty))
    :effect (and (not (on?block?target)) (clear?block) (not (hand-empty)))
  )
)
