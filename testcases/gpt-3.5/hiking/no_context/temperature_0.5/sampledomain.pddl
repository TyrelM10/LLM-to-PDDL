
(define (domain circular_walk)
    (:requirements :strips)
    (:types location car)
    
    (:predicates
        (at ?x - car ?l - location)
        (driven ?c1 - car ?l1 - location ?l2 - location)
        (walked ?l1 - location ?l2 - location)
        (tired)
        (tent_at ?l - location)
        (ready_to_walk)
    )
    
    (:action drive
        :parameters (?c - car ?l1 - location ?l2 - location)
        :precondition (and (at ?c ?l1))
        :effect (and (not (at ?c ?l1)) (at ?c ?l2) (driven ?c ?l1 ?l2))
    )
    
    (:action walk
        :parameters (?l1 - location ?l2 - location)
        :precondition (and (walked ?l1 ?l2) (tired) (tent_at ?l2))
        :effect (and (not (tent_at ?l2)) (walked ?l1 ?l2) (ready_to_walk))
    )
)
