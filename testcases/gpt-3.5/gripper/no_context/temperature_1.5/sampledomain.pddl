
(define (domain robot_balls_transfer)
  (:requirements :strips)

  (:types object - agent
          ball gripper - object
          robot number - object
          room - object)

  (:predicates 
    (robot ?r - robot)
    (gripper ?g - gripper)
    (ball ?b - ball)
    (room ?room - room)
    (carrying ?r - robot ?x - ball)
    (has_capacity ?g - gripper ?n - number)
  )

  (:action pick
    :parameters (?r - robot ?g - gripper ?b - ball ?room - room)
    :precondition (and 
      (robot ?r) 
      (gripper ?g) 
      (ball ?b) 
      (room ?room) 
      (has_capacity ?g 1)
      (carrying ?r none)
      (at-robot ?r ?room)
    )
    
    :effect (and 
      (carrying ?r ?b)
      (not (at-robot ?r ?room))
    )
  )

  (:action place
    :parameters (?r - robot ?g - gripper ?room - room)
    :precondition (and 
      (robot ?r) 
      (gripper ?g) 
      (room ?room) 
      (carrying ?r ?b)
    )
    
    :effect (and 
      (not (carrying ?r ?b))
      (at-robot ?r ?room)
    )
  )
)
