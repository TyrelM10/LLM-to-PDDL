
(define (domain blocks-world)
  (:requirements :strips :typing)
  ;; Predicate definitions
  (:types block)
  (:predicates
    (clear ?x - block)
    (ontable ?x - block)
    (handempty)
    (holding ?x - block)
    (on-table ?x - block)
    (on ?x ?y - block))
  ;; Action definitions
  (:action pick-up
    :parameters (?x)
    :precondition (and (clear ?x) (ontable ?x) (handempty))
    :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x)))
  (:action put-down
    :parameters (?x)
    :precondition (holding ?x)
    :effect (and (ontable ?x) (clear ?x) (handempty) (not (holding ?x))))
  (:action stack
    :parameters (?x ?y)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (on ?x ?y) (clear ?x) (handempty) (not (holding ?x)) (not (clear ?y)) (not (on-table ?y)) (on-table ?x)))
  (:action unstack
    :parameters (?x ?y)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (clear ?y) (holding ?x) (not (on ?x ?y)) (not (clear ?x)) (not (handempty)) (on-table ?y) (not (on-table ?x))))
  (:action place
    :parameters (?x ?y)
    :precondition (and (holding ?x) (clear ?y) (on-table ?x))
    :effect (and (on ?x ?y) (clear ?x) (handempty) (not (holding ?x)) (not (clear ?y)) (not (on-table ?x)) (on-table ?y))))
