
(define (domain robot-grippers)
(:types gripper room object)
(:constants g1 - gripper)
(:predicates
    (holding ?g - gripper ?o - object)
    (ontable ?o - object)
    (inroom ?r - room ?o - object)
    (sameRoom ?r1 - room ?r2 - room)
    (at ?g - gripper ?r - room)
)

(:action pick-up
:parameters (?g - gripper ?o - object ?r1 - room ?r2 - room)
:precondition (and (at ?g ?r1) (ontable ?o) (inroom ?r1 ?o) (not (holding ?g ?o)) (sameRoom ?r1 ?r2))
:effect (and (not (ontable ?o)) (at ?g ?r2) (holding ?g ?o) (inroom ?r2 ?o))
)

(:action put-down
:parameters (?g - gripper ?o - object ?r1 - room ?r2 - room)
:precondition (and (at ?g ?r1) (holding ?g ?o) (distinct ?r1 ?r2) (not (ontable ?o)))
:effect (and (ontable ?o) (at ?g ?r1) (not (holding ?g ?o)) (inroom ?r1 ?o))
)

(:action move
:parameters (?g - gripper ?r1 - room ?r2 - room)
:precondition (and (at ?g ?r1) (sameRoom ?r1 ?r2) (not (at ?g ?r2)))
:effect (and (at ?g ?r2) (not (at ?g ?r1)))
)
)
