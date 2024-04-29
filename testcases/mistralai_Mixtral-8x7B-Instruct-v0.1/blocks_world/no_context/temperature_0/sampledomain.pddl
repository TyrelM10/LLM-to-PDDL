
(define (domain blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types for clarity
  (:types block)
  (:predicates
    (ontable ?x - block)        ; x is on the table
    (clear ?x - block)          ; no other block directly rests upon x
    (on ?x ?y - block)           ; x is stacked on y
    (handempty)                 ; whether or not the robot hand is empty
    (holding ?x - block))       ; what object, if anything, the robot hand holds

  ;; Actions
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
    :effect (and (on ?x ?y) (clear ?x) (handempty) (not (holding ?x)) (not (clear ?y))))

  (:action unstack
    :parameters (?x ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (clear ?y) (holding ?x) (not (on ?x ?y)) (not (clear ?x)) (not (handempty)))))
