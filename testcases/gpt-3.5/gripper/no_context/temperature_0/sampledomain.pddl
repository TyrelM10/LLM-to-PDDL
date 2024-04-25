
(define (domain robot-domain)
  (:requirements :strips)
  
  (:types ball room gripper)
  
  (:predicates
    (at-robot ?r - room)
    (at-ball ?b - ball ?r - room)
    (in-gripper ?g - gripper ?b - ball)
    (empty ?g - gripper)
    (goal-achieved)
  )
  
  (:action pick-up
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (at-robot ?r) (at-ball ?b ?r) (empty ?g)
    :effect (and (in-gripper ?g ?b) (not (at-ball ?b ?r)))
  )
  
  (:action put-down
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (at-robot ?r) (in-gripper ?g ?b)
    :effect (and (at-ball ?b ?r) (not (in-gripper ?g ?b)))
  )
  
  (:action move
    :parameters (?from - room ?to - room)
    :precondition (at-robot ?from)
    :effect (and (at-robot ?to) (not (at-robot ?from)))
  )
  
  (:action increase-goal
    :parameters ()
    :precondition (not (goal-achieved))
    :effect (goal-achieved)
  )
)
