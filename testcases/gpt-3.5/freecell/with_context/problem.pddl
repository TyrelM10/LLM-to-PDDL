(define (problem freecell-solitaire-2)
  (:domain freecell-solitaire)
  (:objects 
    card1 card2 card3 card4 card5 card6 card7 card8 - card
    freecell1 freecell2 freecell3 freecell4 - card
    homecell1 homecell2 homecell3 homecell4 - card
  )
  (:init 
    (column-empty card1) (column-empty card2) (column-empty card3) (column-empty card4)
    (column-empty card5) (column-empty card6) (column-empty card7) (column-empty card8)
    (freecell-empty freecell1) (freecell-empty freecell2) (freecell-empty freecell3) (freecell-empty freecell4)
    (less-than-eight-columns)
    (opposite-color card1 card2) (one-higher card1 card2)
    (opposite-color card2 card3) (one-higher card2 card3)
    (opposite-color card3 card4) (one-higher card3 card4)
    (opposite-color card4 card5) (one-higher card4 card5)
    (opposite-color card5 card6) (one-higher card5 card6)
    (opposite-color card6 card7) (one-higher card6 card7)
    (opposite-color card7 card8) (one-higher card7 card8)
  )
  (:goal 
    (and 
      (homecell homecell1) (homecell homecell2) (homecell homecell3) (homecell homecell4)
    )
  )
)
