
(define (domain robot-domain)
  (:requirements :typing)
  
  (:types
    ball
    room
    gripper
  )

  (:predicates
    (at-robot ?r - room)
    (at-ball ?b - ball ?r - room)
    (empty ?g - gripper)
    (holding ?g - gripper ?b - ball)
  )

  (:action pick-up
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (at-robot ?r) (at-ball ?b ?r) (empty ?g)
    :effect (and (not (at-ball ?b ?r)) (holding ?g ?b))
  )

  (:action put-down
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (at-robot ?r) (holding ?g ?b)
    :effect (and (at-ball ?b ?r) (empty ?g))
  )

  (:action move
    :parameters (?from - room ?to - room)
    :precondition (at-robot ?from)
    :effect (and (not (at-robot ?from)) (at-robot ?to))
  )
)
