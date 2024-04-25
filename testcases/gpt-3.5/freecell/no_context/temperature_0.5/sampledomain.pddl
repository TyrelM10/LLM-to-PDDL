
(define (domain freecell)
  (:requirements :strips)
  
  (:types card suit column)
  
  (:predicates
    (on-top-of ?c1 - card ?c2 - card)
    (in-freecell ?c - card)
    (in-homecell ?c - card)
    (in-column ?c - card ?col - column)
    (empty-freecell)
    (empty-column ?col - column)
    (same-suit ?c1 - card ?c2 - card)
    (one-lower ?c1 - card ?c2 - card)
    (one-higher ?c1 - card ?c2 - card)
    (opposite-color ?c1 - card ?c2 - card)
  )
  
  (:action move-to-freecell
    :parameters (?c - card ?col - column)
    :precondition (and (in-column ?c ?col) (not (in-freecell ?c)) (empty-freecell))
    :effect (and (in-freecell ?c) (not (in-column ?c ?col)))
  )
  
  (:action move-to-homecell
    :parameters (?c - card ?col - column)
    :precondition (and (in-freecell ?c) (in-homecell ?col) (same-suit ?c ?col) (one-lower ?c ?col))
    :effect (and (in-homecell ?c) (not (in-freecell ?c)))
  )
  
  (:action move-between-columns
    :parameters (?c1 - card ?c2 - card ?col1 - column ?col2 - column)
    :precondition (and (in-freecell ?c1) (on-top-of ?c1 ?col1) (in-freecell ?c2) (on-top-of ?c2 ?col2) (one-higher ?c1 ?c2) (opposite-color ?c1 ?c2) (not (empty-column ?col2)))
    :effect (and (on-top-of ?c1 ?c2) (not (on-top-of ?c1 ?col1)) (not (in-freecell ?c1)))
  )
  
  (:action move-to-new-column
    :parameters (?c - card ?col - column)
    :precondition (and (in-freecell ?c) (empty-column ?col))
    :effect (and (on-top-of ?c ?col) (not (in-freecell ?c)))
  )
)
