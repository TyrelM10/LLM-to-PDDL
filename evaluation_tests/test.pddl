(define (domain dual-gripper-transport)
  (:requirements :strips :typing)
  (:types
    ball room gripper)
  
  (:predicates
    (ball-at ?b - ball ?r - room)           ; Ball is at a specific room
    (gripper-at ?g - gripper ?r - room)     ; Gripper is at a specific room
    (free ?g - gripper)                     ; Gripper is not carrying any ball
    (carry ?g - gripper ?b - ball)          ; Gripper is carrying a specific ball
  )
  
  (:action move
    :parameters (?g - gripper ?from - room ?to - room)
    :precondition (and (gripper-at ?g ?from) (free ?g))
    :effect (and (not (gripper-at ?g ?from)) (gripper-at ?g ?to))
  )
  
  (:action pick
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (and (gripper-at ?g ?r) (ball-at ?b ?r) (free ?g))
    :effect (and (not (ball-at ?b ?r)) (not (free ?g)) (carry ?g ?b))
  )
  
  (:action drop
    :parameters (?g - gripper ?b - ball ?r - room)
    :precondition (and (gripper-at ?g ?r) (carry ?g ?b))
    :effect (and (not (carry ?g ?b)) (ball-at ?b ?r) (free ?g))
  )

  (:action move-carrying
    :parameters (?g - gripper ?b - ball ?from - room ?to - room)
    :precondition (and (gripper-at ?g ?from) (carry ?g ?b))
    :effect (and (not (gripper-at ?g ?from)) (gripper-at ?g ?to))
  )
)
