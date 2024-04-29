
(define (domain freecell)
  (:requirements :strips :typing)
  (:types card location freecell homecell column)
  (:constants
    Empty - location
    Ace - card
    Two - card
    Three - card
    Four - card
    Five - card
    Six - card
    Seven - card
    Eight - card
    Nine - card
    Ten - card
    Jack - card
    Queen - card
    King - card
    Club Diamond Heart Spade - suit
    C1 C2 C3 C4 C5 C6 C7 C8 - column
    FC1 FC2 FC3 FC4 - freecell
    H1 H2 H3 H4 - homecell
  )
  (:predicates
    (on ?c1 - card ?c2 - card)
    (ontable ?c - card)
    (freecell-empty ?f - freecell)
    (homecell-full ?h - homecell)
    (homecell-value-leq ?h - homecell ?v)
    (column-value-geq ?col - column ?v)
    (same-suit ?c1 - card ?c2 - card)
    (opposite-color ?c1 - card ?c2 - card)
    (lesser-value ?c1 - card ?c2 - card)
    (equal-value ?c1 - card ?c2 - card)
  )
  (:action MoveToFreeCell
    :parameters (?c - card ?fc - freecell)
    :precondition (and (on ?c Empty) (freecell-empty fc))
    :effect (and (not (on ?c Empty)) (not (freecell-empty fc)) (on ?c fc) (not (ontable ?c)))
  )
  (:action MoveFromFreeCell
    :parameters (?c - card ?dest - location)
    :precondition (and (on ?c (the-card dest)) (eq dest Empty))
    :effect (and (on ?c Empty) (not (on ?c (the-card dest))) (ontable ?c))
  )
  (:action MoveCardToColumn
    :parameters (?src - location ?dst - column)
    :precondition (and (if (eq src Empty) then (column-value-geq dst (val (the-card src)) (val (first-card dst)))) else true)
                     (on (the-card src) (the-card dst)))
    :effect (and (not (on (the-card src) (the-card dst))) (on (the-card src) dst)
                (when (eq src (the-column col1)) (column-value-geq dst (add-one (val (first-card dst)))))
                (when (eq dst (the-column col2)) (column-value-geq dst (add-two (val (first-card dst)))))
               )
  )
  (:action MoveToHomeCell
    :parameters (?c - card ?hc - homecell)
    :precondition (and (or (ontable ?c) (on ?c (the-card hc)))
                      (same-suit c hc)
                      (homecell-value-leq hc (val c))
                      (lesser-value c (max-card hc)))
    :effect (and (not (ontable ?c)) (not (on ?c (the-card hc)))
                (on ?c Empty) (homecell-value-leq hc (add-one (val c)))
                (not (homecell-value-leq hc (val c))))
  )
)

(:function val (?x - card) 
  0
)

(:function first-card (?x - column)
  Empty
)

(:function max-card (?x - homecell)
  King
)

(:function add-one (?x - number)
  1 + x
)

(:function add-two (?x - number)
  2 + x
)
