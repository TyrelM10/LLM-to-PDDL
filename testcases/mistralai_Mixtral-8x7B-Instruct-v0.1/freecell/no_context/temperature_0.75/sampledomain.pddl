
(define (domain FreeCell)
  (:types card location)
  (:constants
      col-0 - location
      col-1 - location
      col-2 - location
      col-3 - location
      col-4 - location
      col-5 - location
      col-6 - location
      col-7 - location
      freecell-0 - location
      freecell-1 - location
      freecell-2 - location
      freecell-3 - location
      homecell-0 - location
      homecell-1 - location
      homecell-2 - location
      homecell-3 - location
      ace-of-spades - card
      ...
      king-of-clubs - card)
  (:predicates
      (on ?c - card ?loc - location)
      (empty ?loc - location)
      (same-suit ?c1 - card ?c2 - card)
      (opposite-color ?c1 - card ?c2 - card)
      (valid-move-to-homecell ?c - card)
      (freecell-location ?l - location)
      (column-location ?l - location)
      (columns-at ?c - location integer))
  (:functions
      (value ?c - card)
      (next-card ?c - card ?col - location))
  (:action MoveCardToFreeCell
      :parameters (?c - card ?fromLoc - location)
      :precondition (and (on ?c ?fromLoc) (empty freecell-0))
      :effect (and (not (on ?c ?fromLoc))
                  (on ?c freecell-0)))
  (:action MoveCardToHomeCell
      :parameters (?c - card ?fromLoc - location)
      :precondition (and (or (and (freecell-location ?fromLoc)
                               (not (on ?c freecell-0))
                               (not (on freecell-0 freecell-0)))
                          (and (column-location ?fromLoc)
                               (valid-move-to-homecell ?c)
                               (not (on ?c (nth 0 (columns-at (- 8 ?fromLoc))))))))
      :effect (and (not (on ?c ?fromLoc))
                  (on ?c homecell-(- (the integer (value ?c)))))))
