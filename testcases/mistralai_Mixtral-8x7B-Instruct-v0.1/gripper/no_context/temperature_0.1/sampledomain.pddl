
(define (domain robotic-arm)
(:requirements :strips)

(:types gripper object)
(:constants
gripper-1 - gripper
gripper-2 - gripper
block-1 - object
block-2 - object
)

(:predicates
gripper-empty(?x - gripper)
holding(?x - object)
clear(?x - object)
)

(:action pick-up
:parameters (?g - gripper ?o - object)
:precondition (and (gripper-empty ?g) (clear ?o))
:effect (and (holding ?o) (not (clear ?o)) (not (gripper-empty ?g)))
)

(:action put-down
:parameters (?g - gripper ?o - object)
:precondition (holding ?o)
:effect (and (gripper-empty ?g) (clear ?o) (not (holding ?o)))
)

(:action move
:parameters (?g1 - gripper ?g2 - gripper)
:precondition (and (gripper-empty ?g1) (gripper-empty ?g2))
:effect (and (not (gripper-empty ?g1)) (not (gripper-empty ?g2)))
)
