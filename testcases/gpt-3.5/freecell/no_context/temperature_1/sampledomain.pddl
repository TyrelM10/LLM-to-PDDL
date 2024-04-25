
(define (domain freecell)
    (:requirements :strips)
    (:types card suit stack)
    (:predicates 
        (top_of_stack ?c - card ?s - stack)
        (homecell_contains ?c - card)
        (freecell_contains ?c - card)
        (card_value ?c - card ?v - card)
        (color_of_suit ?s - suit ?c - card)
        (next_value ?v1 ?v2 - card)
        (opposite_color ?s1 ?s2 - suit)
        (empty_freecell)
        (less_than_8_columns)
    )

    (:action move_to_freecell
        :parameters (?c ?s)
        :precondition (and (top_of_stack ?c ?s) (empty_freecell))
        :effect (and (freecell_contains ?c) (not (top_of_stack ?c ?s)))
    )

    (:action move_to_homecell
        :parameters (?c)
        :precondition (and (freecell_contains ?c) (homecell_contains ?c) (card_value ?c ?v) (next_value ?v ?v) )
        :effect (and (not (freecell_contains ?c)) (not (top_of_stack ?c ?s)))
    )

    (:action move_within_column
        :parameters (?c1 ?c2 ?s1 ?s2)
        :precondition (and (top_of_stack ?c1 ?s1) (top_of_stack ?c2 ?s2) (opposite_color ?s1 ?s2) (next_value ?c2 ?c1) (less_than_8_columns))
        :effect (and (top_of_stack ?c1 ?s2) (not (top_of_stack ?c1 ?s1)))
    )

    (:action move_to_new_column
        :parameters (?c ?s1 ?s2)
        :precondition (and (top_of_stack ?c ?s1) (less_than_8_columns))
        :effect (and (top_of_stack ?c ?s2) (not (top_of_stack ?c ?s1)))
    )
)
