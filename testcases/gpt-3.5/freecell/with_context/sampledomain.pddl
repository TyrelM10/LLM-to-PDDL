(define (domain freecell-solitaire)
  (:requirements :strips)
  (:types card)
  (:predicates 
    (column-empty ?col - card)
    (freecell-empty ?cell)
    (homecell ?card - card)
    (same-suit ?card1 - card ?card2 - card)
    (one-higher ?card1 - card ?card2 - card)
    (opposite-color ?card1 - card ?card2 - card)
    (less-than-eight-columns)
  )
  
  (:action move-to-freecell
    :parameters (?card - card ?column - card ?freecell - card)
    :precondition (and (freecell-empty ?freecell) (column-empty ?column))
    :effect (and 
              (not (freecell-empty ?freecell))
              (not (column-empty ?column))
              (same-suit ?card ?freecell)
            )
  )

  (:action move-to-homecell
    :parameters (?card - card ?homecell - card)
    :precondition (and (homecell ?homecell) (one-higher ?homecell ?card) (freecell-empty ?card))
    :effect (and 
              (homecell ?card)
              (not (freecell-empty ?card))
            )
  )

  (:action move-between-columns
    :parameters (?card1 - card ?column1 - card ?column2 - card)
    :precondition (and (freecell-empty ?card1) (freecell-empty ?card2) (opposite-color ?card1 ?column2) (one-higher ?card1 ?column2))
    :effect (and 
              (not (column-empty ?column1))
              (not (column-empty ?column2))
            )
  )

  (:action move-to-new-column
    :parameters (?card - card ?column - card)
    :precondition (and (column-empty ?column) (less-than-eight-columns))
    :effect (and 
              (not (column-empty ?column))
            )
  )
)