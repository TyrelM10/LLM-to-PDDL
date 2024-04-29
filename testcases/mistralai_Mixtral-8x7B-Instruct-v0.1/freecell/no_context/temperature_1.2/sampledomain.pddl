 (define (domain freecell)
(:types location - object card - object column - object)
(:constants all-columns - listOf columns)
(:predicates
(empty-free-cell ?l - location)
(empty-home-cell ?l - location)
(full-column ?col - column)
(card-on-top ?c - card ?loc - location)
(at-free-cell ?c - card ?loc - location))

(:action move-to-free-cell
:parameters (?c - card ?src - location)
:precondition (and (card-on-top ?c ?src) (empty-free-cell ?dst))
:effect (and (not (card-on-top ?c ?src)) (at-free-cell ?c ?dst)))

(:action move-to-column
:parameters (?c - card ?src - location ?dest - column)
:precondition (and (card-on-top ?c ?src) (not (full-column ?dest)))
:effect (and (not (card-on-top ?c ?src)) (not (empty-column ?dest)) (card-on-top ?c ?dest)))

(:action move-from-column-top
:parameters (?c - card ?src - column ?dest - location)
:precondition (and (card-on-top ?c ?src) (or (eq ?dest home) (and (eq ?dest free) (empty-free-cell free))))
:effect (and (not (card-on-top ?c ?src)) (at-free-cell ?c ?dest)))

(:action move-from-column-middle
:parameters (?c - card ?src - column ?dest - location ?prev - card)
:precondition (and (not (card-on-top ?c ?src)) (card-on-top ?prev ?src) (or (eq ?dest home) (and (eq ?dest free) (empty-free-cell free))))
:effect (and (at-free-cell ?prev dest) (at-free-cell ?c dest)))
)