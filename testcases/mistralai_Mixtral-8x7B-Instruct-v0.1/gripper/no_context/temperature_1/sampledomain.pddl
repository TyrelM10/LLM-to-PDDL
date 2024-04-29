
(define (domain robotic-gripper)
  (:requirements :strips)

  (:types gripper location ball)

  (:constants left-gripper right-gripper)
  (:predicates
    (carrying ?g - gripper ?b - ball)
    (at ?x - location)
    (free ?g - gripper)
    (ball-here ?b - ball ?loc - location))

  (:action pick-up
    :parameters (?g - gripper ?b - ball ?loc - location)
    :precondition (and (at ?loc) (free ?g) (ball-here ?b loc))
    :effect (and (not (at ?loc)) (not (free ?g)) (carrying ?g ?b)))

  (:action put-down
    :parameters (?g - gripper ?b - ball ?loc - location)
    :precondition (and (carrying ?g ?b) (free ?loc))
    :effect (and (at ?loc) (free ?g) (not (carrying ?g ?b))))

  (:action move
    :parameters (?g1 - gripper ?loc1 - location ?g2 - gripper ?loc2 - location)
    :precondition (and (at ?loc1) (at ?loc2) (free ?g1) (free ?g2))
    :effect (and (not (at ?loc1)) (not (at ?loc2)) (at ?loc2) (at ?loc1))))
