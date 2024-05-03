(define (domain blocks-world)
    (:requirements :strips :typing)
    (:types
        Block Stack Location
    )
    (:predicates
        (clear? - Location - "Location is clear.")
        (stacked? - Block Block - "Block b1 is stacked on top of block b2.")
    )
    (:init
        (forall
            (?x Block)
            (clear? ground))
    )
    (:actions)
    (:action move
        :parameters (?block1 ?from-location ?to-location)
        :precondition (and (clear? ?to-location) (clear? ?from-location) (stacked? ?block1 ?something))
        :effect (and (clear? ?from-location) (clear? ?to-location) (not (stacked? ?block1 ?something)) (stacked? ?block1 ?to-location))
    )
    (:action pickup
        :parameters (?block)
        :precondition (clear? ground)
        :effect (clear? ground) (not (clear? hand)) (holding ?block)
    )
    (:action putdown
        :parameters (?block)
        :precondition (and (clear? hand) (clear? ?destination))
        :effect (and (clear? hand) (clear? ?destination) (stacked? ?block ?destination))
    )
)