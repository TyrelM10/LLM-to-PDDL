
(define (domain blocks)
  (:requirements :strips)
  
  (:types block)
  
  (:predicates
    (clear ?x - block)
    (on ?x ?y - block)
    (ontable ?x - block)
    (handempty)
    (holding ?x - block))
  
  (:action pick-up
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x) (handempty))
    :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x)))
  
  (:action put-down
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (ontable ?x) (clear ?x) (handempty) (not (holding ?x))))
  
  (:action stack
    :parameters (?x ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (not (holding ?x)) (clear ?y) (on ?x ?y) (handempty)))
  
  (:action unstack
    :parameters (?x ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (holding ?x) (not (on ?x ?y)) (not (clear ?y)) (clear ?x))))
