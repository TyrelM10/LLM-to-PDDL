
(define (domain blocks-world)
    (:requirements :strips :typing)
    
    (:types block)
    
    (:constants
        clear - (block),
        on - (block block),
        table - block
    )
    
    (:predicates
       (on ?x - block ?y - block)
       (clear ?x - block)
       (ontable ?x - block)
    )
    
    (:action pick-up
        :parameters (?x - block)
        :precondition (and (clear ?x) (ontable ?x))
        :effect (and (not (ontable ?x)) (not (clear ?x)) (clear ?table) (on ?x table)))
    
    (:action put-down
        :parameters (?x - block)
        :precondition (clear ?table)
        :effect (and (ontable ?x) (clear ?x) (not (clear ?table)) (not (on ?x table))))
    
    (:action stack
        :parameters (?x - block ?y - block)
        :precondition (and (clear ?x) (on ?y table))
        :effect (and (not (ontable ?y)) (on ?y ?x) (clear ?x) (not (clear ?table)) (not (on ?y table))))
    
    (:action unstack
        :parameters (?x - block ?y - block)
        :precondition (and (on ?x ?y) (clear ?x))
        :effect (and (ontable ?y) (clear ?y) (not (ontable ?x)) (not (clear ?x)) (on ?x table))))
