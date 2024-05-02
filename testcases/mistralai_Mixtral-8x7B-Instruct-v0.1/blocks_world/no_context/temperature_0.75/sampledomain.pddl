
(define (domain blocks-world
    :requirements :strips :typing)
  (:types block)
  (:predicates
      (ontable ?x - block)
      (clear ?x - block)
      (on ?x ?y - block)
      (handempty)
      (holding ?x - block))

  (:action pick-up
      :parameters (?x - block)
      :precondition (and (clear ?x) (ontable ?x) (handempty))
      :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x)))

  (:action put-down
      :parameters (?x - block)
      :precondition (holding ?x)
      :effect (and (not (holding ?x)) (ontable ?x) (clear ?x) (handempty)))

  (:action stack
      :parameters (?x ?y - block)
      :precondition (and (holding ?x) (clear ?y))
      :effect (and (not (holding ?x)) (not (clear ?y)) (clear ?x) (on ?x ?y)))

  (:action unstack
      :parameters (?x ?y - block)
      :precondition (and (on ?x ?y) (clear ?x) (handempty))
      :effect (and (holding ?x) (clear ?y) (not (on ?x ?y)) (not (clear ?x))))
)
