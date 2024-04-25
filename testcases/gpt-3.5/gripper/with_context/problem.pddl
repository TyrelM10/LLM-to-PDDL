(define (problem robot-problem)
  (:domain robot-domain)
  (:objects
    ball1 ball2 - ball
    gripper1 gripper2 - gripper
    room1 room2 - room
  )
  (:init
    (at-robot room1)
    (at-ball ball1 room1)
    (at-ball ball2 room1)
    (empty gripper1)
    (empty gripper2)
  )
  (:goal (and
          (at-ball ball1 room2)
          (at-ball ball2 room2)
          (goal-reached)
        )
  )
)