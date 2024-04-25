
(define (domain robot-gripper)
  (:requirements :strips)

  (:types ball room gripper robot)

  (:predicates
    (at-robot ?r - robot ?room - room)
    (at-ball ?b - ball ?room - room)
    (in-gripper ?g - gripper ?b - ball)
    (empty ?g - gripper)
    (carrying ?r - robot ?b - ball)
  )

  (:action pick-up
    :parameters (?r - robot ?b - ball ?g - gripper ?room - room)
    :precondition (and
      (at-robot ?r ?room)
      (at-ball ?b ?room)
      (in-gripper ?g ?b)
      (empty ?g)
    )
    :effect (and
      (in-gripper ?g ?b)
      (not (empty ?g))
      (not (at-ball ?b ?room))
      (carrying ?r ?b)
    )
  )

  (:action put-down
    :parameters (?r - robot ?b - ball ?g - gripper ?room - room)
    :precondition (and
      (at-robot ?r ?room)
      (in-gripper ?g ?b)
      (carrying ?r ?b)
    )
    :effect (and
      (not (in-gripper ?g ?b))
      (empty ?g)
      (at-ball ?b ?room)
      (not (carrying ?r ?b))
    )
  )

  (:action move
    :parameters (?r - robot ?from - room ?to - room)
    :precondition (at-robot ?r ?from)
    :effect (and
      (at-robot ?r ?to)
      (not (at-robot ?r ?from))
    )
  )
)
