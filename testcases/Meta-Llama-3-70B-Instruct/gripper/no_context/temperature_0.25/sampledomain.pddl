
(define (domain ball-mover)
  (:predicates 
    (in-room?r?b)
    (in-gripper?g?b)
    (in-gripper-empty?g)
    (room?r)
    (ball?b)
    (gripper?g)
  )
  (:action move-gripper
      :parameters (?g?r1?r2)
      :precondition (and (in-gripper-empty?g) (room?r1) (room?r2))
      :effect (and (not (in-gripper-empty?g)) (in-room?r2?g))
    )
  (:action pick-up
      :parameters (?g?b?r)
      :precondition (and (in-gripper-empty?g) (in-room?r?b) (room?r))
      :effect (and (in-gripper?g?b) (not (in-room?r?b)) (not (in-gripper-empty?g)))
    )
  (:action drop
      :parameters (?g?b?r)
      :precondition (and (in-gripper?g?b) (room?r))
      :effect (and (in-room?r?b) (not (in-gripper?g?b)) (in-gripper-empty?g))
    )
)
