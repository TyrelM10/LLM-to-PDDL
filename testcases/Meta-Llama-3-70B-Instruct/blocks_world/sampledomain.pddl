(define (domain blocks-world)
  (:predicates 
    (on?x?y) 
    (on-table?x) 
    (clear?x) 
    (hand-empty)
  )
  (:action move-block 
      :parameters (?b?from?to) 
      :precondition (and (on?b?from) (clear?b) (clear?to) (hand-empty)) 
      :effect (and (on?b?to) (on?b?from) (clear?to) (hand-empty))
    )
    (:action pick-up 
      :parameters (?b?from) 
      :precondition (and (on?b?from) (clear?b) (hand-empty)) 
      :effect (and (clear?b) (hand-empty))
    )
    (:action put-down 
      :parameters (?b?to) 
      :precondition (and (hand-empty) (clear?to)) 
      :effect (and (on?b?to) (clear?b) (hand-empty))
    )
)