**USER** :
Freecell is a solitaire game that comes with Windows.If you haven't seen it before: One has 8 columns of cards, 4 freecells and 4 homecells. The cards start in "random" (random according to MS's brain damaged RNG) piles in the 8 columns. We can move a card in the following ways:  1. we can move any card that is on top of a column to an empty free cell. The free cells only take one card each. 2. We can move any card from a free cell or from top of a column to a home cell if that home cell contains a card of the same suit and is one lower in value aces have value 1, Jacks 11, Queens 12, Kings 13, and to make things more symmetric we start the homecells off containing "phone" cards with value 0. 3. we can move any card from the  top of a column or from a freecell to the top of another column if that column currently holds a card with an opposite colour suit that has one higher value.  4. we can move any card from a free cell or on top of a column to a new column if there are less than 8 columns.  The aim is to get all of the card home. The problems show quite a good variety of difficulty.
 
 Instruction: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. This code should be solved in a STRIPS Planner. Do not give any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain freecell)
  (:predicates 
    (on-top?card?column)
    (in-freecell?card?freecell)
    (in-homecell?card?homecell)
    (is-suit?card?suit)
    (is-value?card?value)
    (is-opposite-color?suit1?suit2)
    (is-one-higher?value1?value2)
    (is-empty?column)
    (is-empty-freecell?freecell)
    (is-homecell-empty?homecell)
  )
  (:actions
    (move-to-freecell
      :parameters (?card?column?freecell)
      :preconditions (and (on-top?card?column) (is-empty-freecell?freecell))
      :effects (and (in-freecell?card?freecell) (not (on-top?card?column)))
    )
    (move-to-homecell
      :parameters (?card?column?homecell)
      :preconditions (and (on-top?card?column) (is-homecell-empty?homecell) (is-suit?card?suit) (is-value?card?value) (is-value?homecell 0))
      :effects (and (in-homecell?card?homecell) (not (on-top?card?column)))
    )
    (move-to-column
      :parameters (?card?column1?column2)
      :preconditions (and (on-top?card?column1) (is-opposite-color?suit1?suit2) (is-one-higher?value2?value1) (is-empty?column2))
      :effects (and (on-top?card?column2) (not (on-top?card?column1)))
    )
    (move-from-freecell-to-column
      :parameters (?card?freecell?column)
      :preconditions (and (in-freecell?card?freecell) (is-empty?column))
      :effects (and (on-top?card?column) (not (in-freecell?card?freecell)))
    )
  )
)

```
**USER** :
```pddl

(define (domain freecell)
  (:predicates 
    (on-top?card?column)
    (in-freecell?card?freecell)
    (in-homecell?card?homecell)
    (is-suit?card?suit)
    (is-value?card?value)
    (is-opposite-color?suit1?suit2)
    (is-one-higher?value1?value2)
    (is-empty?column)
    (is-empty-freecell?freecell)
    (is-homecell-empty?homecell)
  )
  (:actions
    (move-to-freecell
      :parameters (?card?column?freecell)
      :preconditions (and (on-top?card?column) (is-empty-freecell?freecell))
      :effects (and (in-freecell?card?freecell) (not (on-top?card?column)))
    )
    (move-to-homecell
      :parameters (?card?column?homecell)
      :preconditions (and (on-top?card?column) (is-homecell-empty?homecell) (is-suit?card?suit) (is-value?card?value) (is-value?homecell 0))
      :effects (and (in-homecell?card?homecell) (not (on-top?card?column)))
    )
    (move-to-column
      :parameters (?card?column1?column2)
      :preconditions (and (on-top?card?column1) (is-opposite-color?suit1?suit2) (is-one-higher?value2?value1) (is-empty?column2))
      :effects (and (on-top?card?column2) (not (on-top?card?column1)))
    )
    (move-from-freecell-to-column
      :parameters (?card?freecell?column)
      :preconditions (and (in-freecell?card?freecell) (is-empty?column))
      :effects (and (on-top?card?column) (not (in-freecell?card?freecell)))
    )
  )
)

```
 
 The above code produces the following error: There is a value error on finding unknown keyword in domain definition: 'actions'. Valid keywords in definition are 'requirements', 'types', 'predicates', 'constants' and 'action'. Remove the keyword 'actions' from definition, keep the rest of code the same.
 
Requirement 1: Correct the error and only give the entire PDDL code for solving in a STRIPS Planner.
 Requirement 2: Do not create a problem file and do not use conditional expressions.
 Requirement 3: Give your output as the PDDL code in code blocks delimited only between ```pddl <CODE></CODE> ``` without any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain freecell)
  (:predicates 
    (on-top?card?column)
    (in-freecell?card?freecell)
    (in-homecell?card?homecell)
    (is-suit?card?suit)
    (is-value?card?value)
    (is-opposite-color?suit1?suit2)
    (is-one-higher?value1?value2)
    (is-empty?column)
    (is-empty-freecell?freecell)
    (is-homecell-empty?homecell)
  )
  (:action move-to-freecell
    :parameters (?card?column?freecell)
    :preconditions (and (on-top?card?column) (is-empty-freecell?freecell))
    :effects (and (in-freecell?card?freecell) (not (on-top?card?column)))
  )
  (:action move-to-homecell
    :parameters (?card?column?homecell)
    :preconditions (and (on-top?card?column) (is-homecell-empty?homecell) (is-suit?card?suit) (is-value?card?value) (is-value?homecell 0))
    :effects (and (in-homecell?card?homecell) (not (on-top?card?column)))
  )
  (:action move-to-column
    :parameters (?card?column1?column2)
    :preconditions (and (on-top?card?column1) (is-opposite-color?suit1?suit2) (is-one-higher?value2?value1) (is-empty?column2))
    :effects (and (on-top?card?column2) (not (on-top?card?column1)))
  )
  (:action move-from-freecell-to-column
    :parameters (?card?freecell?column)
    :preconditions (and (in-freecell?card?freecell) (is-empty?column))
    :effects (and (on-top?card?column) (not (in-freecell?card?freecell)))
  )
)

```
**USER** :
```pddl

(define (domain freecell)
  (:predicates 
    (on-top?card?column)
    (in-freecell?card?freecell)
    (in-homecell?card?homecell)
    (is-suit?card?suit)
    (is-value?card?value)
    (is-opposite-color?suit1?suit2)
    (is-one-higher?value1?value2)
    (is-empty?column)
    (is-empty-freecell?freecell)
    (is-homecell-empty?homecell)
  )
  (:action move-to-freecell
    :parameters (?card?column?freecell)
    :preconditions (and (on-top?card?column) (is-empty-freecell?freecell))
    :effects (and (in-freecell?card?freecell) (not (on-top?card?column)))
  )
  (:action move-to-homecell
    :parameters (?card?column?homecell)
    :preconditions (and (on-top?card?column) (is-homecell-empty?homecell) (is-suit?card?suit) (is-value?card?value) (is-value?homecell 0))
    :effects (and (in-homecell?card?homecell) (not (on-top?card?column)))
  )
  (:action move-to-column
    :parameters (?card?column1?column2)
    :preconditions (and (on-top?card?column1) (is-opposite-color?suit1?suit2) (is-one-higher?value2?value1) (is-empty?column2))
    :effects (and (on-top?card?column2) (not (on-top?card?column1)))
  )
  (:action move-from-freecell-to-column
    :parameters (?card?freecell?column)
    :preconditions (and (in-freecell?card?freecell) (is-empty?column))
    :effects (and (on-top?card?column) (not (in-freecell?card?freecell)))
  )
)

```
 
 The above code produces the following error: There is a value error where Predicate Statement must start with ":precondition" keyword and not ":preconditions."
 
Requirement 1: Correct the error and only give the entire PDDL code for solving in a STRIPS Planner.
 Requirement 2: Do not create a problem file and do not use conditional expressions.
 Requirement 3: Give your output as the PDDL code in code blocks delimited only between ```pddl <CODE></CODE> ``` without any explanations.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain freecell)
  (:predicates 
    (on-top?card?column)
    (in-freecell?card?freecell)
    (in-homecell?card?homecell)
    (is-suit?card?suit)
    (is-value?card?value)
    (is-opposite-color?suit1?suit2)
    (is-one-higher?value1?value2)
    (is-empty?column)
    (is-empty-freecell?freecell)
    (is-homecell-empty?homecell)
  )
  (:action move-to-freecell
    :parameters (?card?column?freecell)
    :precondition (and (on-top?card?column) (is-empty-freecell?freecell))
    :effect (and (in-freecell?card?freecell) (not (on-top?card?column)))
  )
  (:action move-to-homecell
    :parameters (?card?column?homecell)
    :precondition (and (on-top?card?column) (is-homecell-empty?homecell) (is-suit?card?suit) (is-value?card?value) (is-value?homecell 0))
    :effect (and (in-homecell?card?homecell) (not (on-top?card?column)))
  )
  (:action move-to-column
    :parameters (?card?column1?column2)
    :precondition (and (on-top?card?column1) (is-opposite-color?suit1?suit2) (is-one-higher?value2?value1) (is-empty?column2))
    :effect (and (on-top?card?column2) (not (on-top?card?column1)))
  )
  (:action move-from-freecell-to-column
    :parameters (?card?freecell?column)
    :precondition (and (in-freecell?card?freecell) (is-empty?column))
    :effect (and (on-top?card?column) (not (in-freecell?card?freecell)))
  )
)

```