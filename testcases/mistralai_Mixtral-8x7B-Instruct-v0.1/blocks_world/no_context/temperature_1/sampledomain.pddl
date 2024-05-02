
(define (domain blocks-world)
(:types block)
(:predicates
	(on ?x - block ?y - block)
        (clear ?x - block)
        (handempty)
        (holding ?x - block))
(:action pick-up
    :parameters (?x - block)
    :precondition (and (clear ?x) (handempty))
    :effect (and (not (clear ?x)) (holding ?x) (not (handempty))))
(:action put-down
    :parameters (?x - block)
    :precondition (and (holding ?x))
    :effect (and (clear ?x) (on ?x nil) (handempty) (not (holding ?x)))) ; changed on-table to on x nil
(:action stack
    :parameters (?x - block ?y - block)
    :precondition (and (clear ?x) (holding ?x) (clear ?y) (handempty))
    :effect (and (not (clear ?y)) (not (holding ?x)) (on ?x ?y) (clear z) (handempty)))
(:action unstack
    :parameters (?x - block ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (clear ?y) (holding ?x) (not (on ?x ?y)) (clear z))))
