
(define (domain shopping)
   (:requirements :strips)
   (:predicates 
     (at-person ?p)
     (at ?x)
     (want ?x)
     (buy ?x))

   (:action go
     :parameters (?p)
     :precondition (at-person ?p)
     :effect (at ?p))

   (:action pick-up
     :parameters (?x ?l)
     :precondition (and (at ?l) (want ?x))
     :effect (and (buy ?x) (not (want ?x)))
)
