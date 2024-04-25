
(define (domain freecell)
  (:requirements :strips)
  (:types card suit column freecell homecell)
  (:predicates 
    (top-of-column ?c - card ?col - column)
    (in-freecell ?c - card ?f - freecell)
    (in-homecell ?c - card ?h - homecell)
    (same-suit ?c1 - card ?c2 - card)
    (one-lower ?c1 - card ?c2 - card)
    (one-higher ?c1 - card ?c2 - card)
    (opposite-color ?c1 - card ?c2 - card)
    (empty-freecell ?f - freecell)
    (empty-column ?col - column)
    (less-than-8-columns)
  )
  
  (:action move-to-freecell
    :parameters (?c - card ?col - column ?f - freecell)
    :precondition (and (top-of-column ?c ?col) (empty-freecell ?f))
    :effect (and (in-freecell ?c ?f) (not (top-of-column ?c ?col)))
  )
  
  (:action move-to-homecell
    :parameters (?c - card ?h - homecell)
    :precondition (and (in-freecell ?c ?f) (in-homecell ?c ?h) (same-suit ?c ?h) (one-lower ?c ?h))
    :effect (and (not (in-freecell ?c ?f)) (not (in-homecell ?c ?h)))
  )
  
  (:action move-between-columns
    :parameters (?c1 - card ?c2 - card ?col1 - column ?col2 - column)
    :precondition (and (top-of-column ?c1 ?col1) (in-freecell ?c2 ?f) (opposite-color ?c1 ?c2) (one-higher ?c1 ?c2))
    :effect (and (not (top-of-column ?c1 ?col1)) (not (in-freecell ?c1 ?f)) (top-of-column ?c1 ?col2))
  )
  
  (:action move-to-new-column
    :parameters (?c - card ?col1 - column ?col2 - column)
    :precondition (and (top-of-column ?c ?col1) (empty-column ?col2) (less-than-8-columns))
    :effect (and (not (top-of-column ?c ?col1)) (top-of-column ?c ?col2))
  )
)
