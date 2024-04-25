
(define (domain blocks-world)
  (:requirements :strips)
  
  (:predicates
    (on-table ?x)
    (on ?x ?y)
    (clear ?x)
    (holding ?x)
  )
  
  (:action pick-up
    :parameters (?x)
    :precondition (and (clear ?x) (on-table ?x))
    :effect (and (not (on-table ?x)) (not (clear ?x)) (holding ?x))
  )
  
  (:action put-down
    :parameters (?x)
    :precondition (holding ?x)
    :effect (and (on-table ?x) (clear ?x) (not (holding ?x)))
  )
  
  (:action stack
    :parameters (?x ?y)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (on ?x ?y) (clear ?x) (not (holding ?x)))
  )
  
  (:action unstack
    :parameters (?x ?y)
    :precondition (and (on ?x ?y) (clear ?x))
    :effect (and (clear ?y) (not (on ?x ?y)) (holding ?x))
  )
)
