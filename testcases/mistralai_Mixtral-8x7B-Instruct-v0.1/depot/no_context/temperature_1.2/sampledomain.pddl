
(define (domain logistics-blocks)
(:requirements :strips :typing)

(:types block location)

(:predicates (on ?x - block ?y - block)
             (clear ?x - block)
             (holding ?x - block)
             (at ?x - block ?y - location))

(:action pick-up
  :parameters (?x - block ?y - location)
  :precondition (and (clear ?x) (at ?x ?y))
  :effect (and (not (at ?x ?y)) (not (clear ?x)) (holding ?x)))

(:action put-down
  :parameters (?x - block ?y - location)
  :precondition (holding ?x)
  :effect (and (not (holding ?x)) (at ?x ?y)))

(:action stack
  :parameters (?x - block ?y - block)
  :precondition (and (clear ?x) (clear ?y) (holding ?x))
  :effect (and (not (clear ?y)) (not (holding ?x)) (clear ?x) (on ?x ?y)))

(:action unstack
  :parameters (?x - block ?y - block)
  :precondition (and (on ?x ?y) (clear ?x) (not (holding ?x)))
  :effect (and (clear ?y) (holding ?x) (not (on ?x ?y))))
)
