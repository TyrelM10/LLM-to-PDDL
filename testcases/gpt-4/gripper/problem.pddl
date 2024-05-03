(define (problem simplified-dual-gripper-transport-problem)
  (:domain dual-gripper-transport)
  (:objects
    ball1 ball2 - ball
    room1 room2 - room
    gripper1 gripper2 - gripper
  )

  (:init
    (ball-at ball1 room1)
    (ball-at ball2 room1)
    (gripper-at gripper1 room1)
    (gripper-at gripper2 room1)
    (free gripper1)
    (free gripper2)
  )

  (:goal
    (and
      (ball-at ball1 room2)
      (ball-at ball2 room2)
    )
  )
)
