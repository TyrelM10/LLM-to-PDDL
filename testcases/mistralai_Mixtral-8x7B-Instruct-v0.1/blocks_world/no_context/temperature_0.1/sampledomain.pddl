
(define (domain blocks-world)
  (:requirements :strips :typing)
  
  ;; Define types
  (:types block)
  (:predicates
    (ontable ?x - block)     ; x is on the table
    (clear ?x - block)       ; no block is on top of x
    (on ?x ?y - block)      ; x is on top of y
    (handempty)             ; nothing is held in hand
    (holding ?x - block))    ; something is being held in hand

  ;; Define action schemas
  (:action pick-up
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x) (handempty))
    :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x)))

  (:action put-down
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (not (holding ?x)) (clear ?x) (ontable ?x) (handempty)))

  (:action stack
    :parameters (?x ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (not (holding ?x)) (clear ?y) (on ?x ?y) (handempty)))

  (:action unstack
    :parameters (?x ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (holding ?x) (not (on ?x ?y)) (not (clear ?x))))
)
