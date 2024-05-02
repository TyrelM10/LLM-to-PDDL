
(define (domain freecell)
  (:requirements :strips :typing)
  
  ;; types
  (:types card location)
  
  ;; defining suits and ranks for each card
  (:predicates
    (suit ?c - card (s - symbol))
    (rank ?c - card (n - number))
    (on-top-of ?c1 - card ?c2 - card)
    (in-column ?c - card ?cl - location)
    (in-freecell ?fc - card ?fl - location)
    (in-homecell ?hc - card ?hl - location)
    (same-suit ?c1 - card ?c2 - card)
    (valid-move-to-homecells ?c1 - card ?c2 - card)
    (opposite-color ?c1 - card ?c2 - card)
    (valid-move-between-columns ?c1 - card ?c2 - card)
    (less-than-eight-open-columns open-columns))
  
  ;; initializing suits and ranks for cards
  (:init
    (suit C1 clubs) (rank C1 two)
    (suit C2 diamonds) (rank C2 three)
    (suit C3 hearts) (rank C3 four)
    (suit C4 spades) (rank C4 five)
    (suit C5 clubs) (rank C5 six)
    (suit C6 diamonds) (rank C6 seven)
    (suit C7 hearts) (rank C7 eight)
    (suit C8 spades) (rank C8 nine))
  
  ;; defining constraints for suits and ranks
  (:constraint (distinct (suits C1 C2 C3 C4 C5 C6 C7 C8)))
  (:constraint (distinct (ranks C1 C2 C3 C4 C5 C6 C7 C8)))
  
  ;; Typed fact definition for same-suit
  (:typed-fact-definition same-suit
      :domain card
      :arguments (?c1 ?c2)
      :conditions (and (eq ?c1 Ace) (true))
                  (and (eq ?c2 Ace) (false))
                  (and (neq ?c1 Ace) (neq ?c2 Ace) (eq (suit ?c1) (suit ?c2))))
  
  ;; Action schemas
  (:action move_card_to_empty_freecell
      :parameters (?from ?to - card ?ft - location ?tt - location)
      :precondition (and (or (in-column ?from ft) (in-freecell ?from ft)) (= tt empty))
      :effect (and (not (in-column ?from ft)) (not (in-freecell ?from ft)) (not (= tt empty))
	          (in-freecell ?from tt)))
  
  (:action move_card_to_homecell
      :parameters (?from ?to - card ?ft - location ?tl - location)
      :precondition (and (or (in-column ?from ft) (in-freecell ?from ft)) (valid-move-to-homecells ?from to))
      :effect (and (not (in-column ?from ft)) (not (in-freecell ?from ft))
	          (in-homecell ?from tl) (not (in-homecell ?from ft))))
  
  (:action move_card_between_columns
      :parameters (?src ?dst - card ?sl - location ?dl - location)
      :precondition (and (in-column ?src sl) (in-column ?dst dl)
	                (valid-move-between-columns ?src ?dst))
      :effect (and (not (in-column ?src sl)) (not (in-column ?dst dl))
	          (on-top-of ?src ?dst) (not (on-top-of ?anything ?dst)))))
