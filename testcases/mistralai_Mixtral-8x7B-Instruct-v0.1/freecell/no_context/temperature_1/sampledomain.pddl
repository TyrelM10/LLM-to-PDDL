
(define (domain cards)
  (:requirements :strips :typing)
  
  (!*types
      card - object
      location
  )
  
  (!*constants
      table - location
      column - location
      freecell - location
      foundation - location
  )
  
  (!*predicates
      (on-table ?x - card)
      (in-column ?x - card ?y - location)
      (occupied-freecell ?x - card)
      (unoccupied-freecell ?x - card)
      (same-suit ?x - card ?y - card)
      (opposite-color-and-higher-value ?x - card ?y - card)
      (value-of ?x - card ?n - number)
      (top-card ?x - card)
      (full-column ?x - location)
      (number-of-cards-in-column ?x - location ?n - number)
  )
  
  (:action move
    :parameters (?x - card, ?a - location, ?b - location)
    :precondition (and (or (on-table ?x) (in-column ?x ?a)) (not (in-column ?x ?b)) (not (occupied-freecell ?x)))
    :effect (and (not (on-table ?x)) (not (in-column ?x ?a)) (unoccupied-freecell ?x) (in-column ?x ?b))
  )
  
  (:action move-to-freecell
    :parameters (?c - card ?fc - freecell)
    :precondition (and (or (on-table ?c) (in-column ?col ?c)) (not (occupied-freecell ?fc)))
    :effect (and (not (on-table ?c)) (not (in-column ?col ?c)) (occupied-freecell ?fc) (on ?c ?fc))
  )
  
  (:action move-from-freecell
    :parameters (?c - card ?fc - freecell ?dest - location)
    :precondition (and (occupied-freecell ?fc) (not (in-column ?c dest)) (opposite-color-and-higher-value ?c (top-card dest))))
    :effect (and (unoccupied-freecell ?fc) (if (eq dest column) (not (in-column ?c dest)) (not (on ?c fc)) (on-table ?c))
  ))
  
  (:action move-to-column
    :parameters (?src_card - card ?src - source ?dst - destination)
    :precondition (and (if (eq src freecell)(not (occupied-freecell src))) (if (eq dst column) (= (number-of-cards-in-column dst) 7) (not (full-column dst))))
    :effect (and (if (eq src freecell) (unoccupied-freecell src)) (if (eq dst column) (= (number-of-cards-in-column dst) (+ 1 (number-of-cards-in-column dst))) (= (number-of-cards-in-column src) (- (number-of-cards-in-column src) 1))) (if (eq dst column) (on src_card dst) (not (on src_card src)))))
  
  (:action move-to-homecell
    :parameters (?c - card ?h - homecell)
    :precondition (and (or (on-table ?c) (in-column ?c h)) (same-suit ?c (top-card h)) (< (value-of ?c) (value-of (top-card h))))
    :effect (and (not (on-table ?c)) (not (in-column ?c h)) (on ?c h)))
)
