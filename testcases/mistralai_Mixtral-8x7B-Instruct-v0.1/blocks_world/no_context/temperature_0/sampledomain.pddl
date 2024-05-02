
(define (domain blocks-world)
  (:requirements :strips :typing)
  
  (:types block location)
  (:constants nil - block)
  
  (:predicates
    (ontable ?x - block)
    (clear ?x - block)
    (on ?x - block ?y - block)
    (holding ?x - block))
  
  (:action pick-up
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x))
    :effect (and (not (ontable ?x)) (not (clear ?x)) (not (on ?x _)) (holding ?x)))
  
  (:action put-down
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (ontable ?x) (clear ?x) (not (holding ?x))))
  
  (:action stack
    :parameters (?x - block ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (not (holding ?x)) (clear ?y) (on ?x ?y) (not (clear ?x)) (not (on ?x _)) (not (on ?y _)) (not (holding ?y)) ))
  
  (:action unstack
    :parameters (?x - block ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (holding ?z))
    :effect (and (holding ?x) (clear ?y) (not (on ?x ?y)) (not (clear ?x)))))
