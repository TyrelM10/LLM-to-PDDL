
(define (domain blocks-world)
  (:types block)
  (:predicates (on ?x - block ?y - block)   ; x is on top of y
               (clear ?x - block))          ; nothing is on top of x
  (:action pick-up
    :parameters (?b - block)
    :precondition (and (clear ?b))
    :effect (and (not (clear ?b)) (not (on ?b nil)))
              (and (not (on ?x ?b)) (not (on ?b ?x)) (not (on ?b ?b)) (not (on nil ?b)) ) )
  (:action put-down
    :parameters (?b - block)
    :precondition (clear ?b)
    :effect (and (clear nil) (on ?b nil) (not (clear ?b)) (on nil ?b) ))
  (:action stack
    :parameters (?b1 - block ?b2 - block)
    :precondition (and (clear ?b1) (on ?b2 nil))
    :effect (and (not (clear ?b1)) (not (on ?b2 nil)) (not (on nil ?b2)) (on ?b1 ?b2) (not (on ?b1 ?b1)) (not (on ?b1 nil)) ) )
  (:action unstack
    :parameters (?b1 - block ?b2 - block)
    :precondition (and (on ?b1 ?b2) (clear ?b1))
    :effect (and (clear ?b2) (on ?b1 nil) (not (on ?b1 ?b2)) (not (on ?b2 ?b1)) (not (on ?b2 nil)) (not (on ?b2 ?b2)) ) ))
