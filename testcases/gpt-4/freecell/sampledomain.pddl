(define (domain freecell)
  (:requirements :strips :typing)
  (:types
    card column homecell freecell suit)

  (:predicates
    (on-top ?c - card ?col - column)
    (in-freecell ?c - card ?f - freecell)
    (in-homecell ?c - card ?h - homecell)
    (empty-freecell ?f - freecell)
    (empty-column ?col - column)
    (next-card ?c1 ?c2 - card) ; ?c1 is directly below ?c2
    (same-suit ?c1 ?c2 - card)
    (opposite-color ?c1 ?c2 - card)
  )

  (:action move-to-freecell
    :parameters (?c - card ?col - column ?f - freecell)
    :precondition (and (on-top ?c ?col) (empty-freecell ?f))
    :effect (and (not (on-top ?c ?col)) (in-freecell ?c ?f) (not (empty-freecell ?f)))
  )

  (:action move-from-freecell-to-homecell
    :parameters (?c - card ?f - freecell ?h - homecell)
    :precondition (and (in-freecell ?c ?f) (in-homecell ?hcard ?h) (same-suit ?c ?hcard) (next-card ?hcard ?c))
    :effect (and (not (in-freecell ?c ?f)) (in-homecell ?c ?h) (empty-freecell ?f))
  )

  (:action move-from-column-to-homecell
    :parameters (?c - card ?col - column ?h - homecell)
    :precondition (and (on-top ?c ?col) (in-homecell ?hcard ?h) (same-suit ?c ?hcard) (next-card ?hcard ?c))
    :effect (and (not (on-top ?c ?col)) (in-homecell ?c ?h))
  )

  (:action move-between-columns
    :parameters (?c - card ?from-col ?to-col - column)
    :precondition (and (on-top ?c ?from-col) (on-top ?top-card ?to-col) (opposite-color ?c ?top-card) (next-card ?c ?top-card))
    :effect (and (not (on-top ?c ?from-col)) (on-top ?c ?to-col))
  )

  (:action move-to-new-column
    :parameters (?c - card ?from-col - column ?to-col - column)
    :precondition (and (on-top ?c ?from-col) (empty-column ?to-col))
    :effect (and (not (on-top ?c ?from-col)) (on-top ?c ?to-col) (not (empty-column ?to-col)))
  )
)
