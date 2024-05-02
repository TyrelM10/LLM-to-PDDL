
(define (domain robot-domain)
  (:requirements :strips)
  (:predicates
    (at-robot ?room)
    (at-ball ?ball ?room)
    (empty ?gripper)
    (holding ?gripper ?ball)
    (full ?gripper)
    (goal-reached)
  )
  
  (:action pick-up
    :parameters (?gripper ?ball ?room)
    :precondition (and (at-robot ?room) (at-ball ?ball ?room) (empty ?gripper))
    :effect (and (holding ?gripper ?ball) (not (at-ball ?ball ?room)) (not (empty ?gripper)))
  )
  
  (:action put-down
    :parameters (?gripper ?ball ?room)
    :precondition (and (at-robot ?room) (holding ?gripper ?ball))
    :effect (and (at-ball ?ball ?room) (empty ?gripper) (not (holding ?gripper ?ball)))
  )
  
  (:action move
    :parameters (?from ?to)
    :precondition (at-robot ?from)
    :effect (at-robot ?to)
  )
  
  (:action unload
    :parameters (?gripper)
    :precondition (and (at-robot ?room) (empty ?gripper))
    :effect (goal-reached)
  )
)
