
(define (domain transportation)
(:requirements :strips :typing)
(:types
  vehicle person destination - object
)
(:predicates
  (at ?x - vehicle ?y - destination)
  (driving ?x - person)
)
(:action travel
  :parameters (?v - vehicle ?o - destination ?d - destination)
  :precondition (at ?v ?o)
  :effect (and
            (at ?v ?d)
            (not (at ?v ?o))
          )
)
(:action drive
  :parameters (?p - person ?v - vehicle)
  :precondition ()
  :effect (driving ?p)
)
)
