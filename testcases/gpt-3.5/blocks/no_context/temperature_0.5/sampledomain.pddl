
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
    :precondition (and (clear ?x) (on-table ?x) (not (holding ?x)))
    :effect (and (not (clear ?x)) (not (on-table ?x)) (holding ?x))
  )
  
  (:action put-down
    :parameters (?x)
    :precondition (holding ?x)
    :effect (and (clear ?x) (on-table ?x) (not (holding ?x)))
  )
  
  (:action stack
    :parameters (?x ?y)
    :precondition (and (clear ?x) (clear ?y) (holding ?x))
    :effect (and (not (clear ?y)) (not (holding ?x)) (on ?x ?y))
  )
)
