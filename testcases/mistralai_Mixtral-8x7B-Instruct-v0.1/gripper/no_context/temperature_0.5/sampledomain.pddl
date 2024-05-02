
(define (domain my_domain)
   (:requirements :strips)
   
   (:types gripper room)
   
   (:constants
      r0 - room
      r1 - room
      g0 - gripper
   )
   
   (:predicates
       (at ?g - gripper ?r - room)
   )
   
   (:action move
     :parameters (?g - gripper ?r1 ?r2 - room)
     :precondition (and (at ?g ?r1))
     :effect (and (not (at ?g ?r1)) (at ?g ?r2))
   )
)
