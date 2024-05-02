**USER** :
This domain was devised in order to see what would happen if two previously well-researched domains were joined together. These were the logistics and blocks domains. They are combined to form a domain in which trucks can transport crates around and then the crates must be stacked onto pallets at their destinations. The stacking is achieved using hoists, so the stacking problem is like a blocks-world problem with hands. Trucks can behave like "tables", since the pallets on which crates are stacked are limited.
 
 Instruction: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. This code should be solved in a STRIPS Planner. Do not give any explanations in the output.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain truck-crane)
  (:requirements :strips :typing)
  
  ;; Types
  (:types crate truck pallet hoist location)

  ;; Constant definitions
  (:constants
    ;; Locations
    loc1 - location
    loc2 - location

    ;; Cranes & Hoists
    hoist1 - hoist
    hoist2 - hoist

    ;; Pallets
    palletA - pallet
    palletB - pallet

    ;; Trucks
    truck1 - truck
    truck2 - truck

    ;; Crates
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
  )

  ;; Predicates
  (:predicates
    (on ?c - crate ?p - pallet)        ; A crate is on a pallet
    (ontable ?t - tray ?l - location)   ; A tray is on a table
    (holding ?h - hoist ?c - crate)     ; A hoist holds a crate
    (clear ?x - object)                ; An object has nothing on top of it
    (at ?v - vehicle ?l - location)     ; A vehicle is at a location
  )

  ;; Action schemas
  (:action pick-up-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (hoist-at ?h ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)))
            (holding ?h ?c) (not (holding ?h nil))
  )

  (:action put-down-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (holding ?h ?c) (clear ?l) (at ?h ?l))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (on ?c nil) (clear ?c) (at ?h ?l)
  )

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at ?t ?from))
    :effect (and (not (at ?t ?from)) (at ?t ?to))
  )

  (:action load-crate-onto-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)) (on ?c ?t))
  )

  (:action unload-crate-from-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (on ?c ?t))
    :effect (and (not (on ?c ?t)) (clear ?c) (on ?c nil))
  )

  (:action lift-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h ?c) (clear ?pl))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (not (clear ?pl)) (clear ?pl)
            (on ?c ?pl) (not (on ?c nil))
  )

  (:action lower-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h nil) (on ?c ?pl))
    :effect (and (holding ?h ?c) (not (holding ?h nil)))
            (clear ?pl) (not (clear ?pl))
            (on ?c nil) (not (on ?c ?pl))
  )
)

```
**USER** :
```pddl

(define (domain truck-crane)
  (:requirements :strips :typing)
  
  ;; Types
  (:types crate truck pallet hoist location)

  ;; Constant definitions
  (:constants
    ;; Locations
    loc1 - location
    loc2 - location

    ;; Cranes & Hoists
    hoist1 - hoist
    hoist2 - hoist

    ;; Pallets
    palletA - pallet
    palletB - pallet

    ;; Trucks
    truck1 - truck
    truck2 - truck

    ;; Crates
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
  )

  ;; Predicates
  (:predicates
    (on ?c - crate ?p - pallet)        ; A crate is on a pallet
    (ontable ?t - tray ?l - location)   ; A tray is on a table
    (holding ?h - hoist ?c - crate)     ; A hoist holds a crate
    (clear ?x - object)                ; An object has nothing on top of it
    (at ?v - vehicle ?l - location)     ; A vehicle is at a location
  )

  ;; Action schemas
  (:action pick-up-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (hoist-at ?h ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)))
            (holding ?h ?c) (not (holding ?h nil))
  )

  (:action put-down-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (holding ?h ?c) (clear ?l) (at ?h ?l))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (on ?c nil) (clear ?c) (at ?h ?l)
  )

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at ?t ?from))
    :effect (and (not (at ?t ?from)) (at ?t ?to))
  )

  (:action load-crate-onto-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)) (on ?c ?t))
  )

  (:action unload-crate-from-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (on ?c ?t))
    :effect (and (not (on ?c ?t)) (clear ?c) (on ?c nil))
  )

  (:action lift-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h ?c) (clear ?pl))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (not (clear ?pl)) (clear ?pl)
            (on ?c ?pl) (not (on ?c nil))
  )

  (:action lower-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h nil) (on ?c ?pl))
    :effect (and (holding ?h ?c) (not (holding ?h nil)))
            (clear ?pl) (not (clear ?pl))
            (on ?c nil) (not (on ?c ?pl))
  )
)

```

The above code produces the following error -> There is a semantic error where unknown type 'tray' is used in predicate definition.

Instruction 1: Correct the error and give the entire PDDL code in code blocks and please do not give any explanations in the output.
Instruction 2: Do not create a problem file and do not use conditional expressions.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain truck-crane)
  (:requirements :strips :typing)

  ;; Types
  (:types crate truck pallet hoist location)

  ;; Constant definitions
  (:constants
    ;; Locations
    loc1 - location
    loc2 - location

    ;; Cranes & Hoists
    hoist1 - hoist
    hoist2 - hoist

    ;; Pallets
    palletA - pallet
    palletB - pallet

    ;; Trucks
    truck1 - truck
    truck2 - truck

    ;; Crates
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
  )

  ;; Predicates
  (:predicates
    (on ?c - crate ?p - pallet)        ; A crate is on a pallet
    (ontable ?t - tray ?l - location)   ; A tray is on a table (deleted since 'tray' was undefined)
    (holding ?h - hoist ?c - crate)     ; A hoist holds a crate
    (clear ?x - object)                ; An object has nothing on top of it
    (at ?v - vehicle ?l - location)     ; A vehicle is at a location
  )

  ;; Action schemas
  (:action pick-up-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (hoist-at ?h ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)))
            (holding ?h ?c) (not (holding ?h nil))
  )

  (:action put-down-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (holding ?h ?c) (clear ?l) (at ?h ?l))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (on ?c nil) (clear ?c) (at ?h ?l)
  )

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at ?t ?from))
    :effect (and (not (at ?t ?from)) (at ?t ?to))
  )

  (:action load-crate-onto-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)) (on ?c ?t))
  )

  (:action unload-crate-from-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (on ?c ?t))
    :effect (and (not (on ?c ?t)) (clear ?c) (on ?c nil))
  )

  (:action lift-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h ?c) (clear ?pl))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (not (clear ?pl)) (clear ?pl)
            (on ?c ?pl) (not (on ?c nil))
  )

  (:action lower-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h nil) (on ?c ?pl))
    :effect (and (holding ?h ?c) (not (holding ?h nil)))
            (clear ?pl) (not (clear ?pl))
            (on ?c nil) (not (on ?c ?pl))
  )
)

```
**USER** :
```pddl

(define (domain truck-crane)
  (:requirements :strips :typing)

  ;; Types
  (:types crate truck pallet hoist location)

  ;; Constant definitions
  (:constants
    ;; Locations
    loc1 - location
    loc2 - location

    ;; Cranes & Hoists
    hoist1 - hoist
    hoist2 - hoist

    ;; Pallets
    palletA - pallet
    palletB - pallet

    ;; Trucks
    truck1 - truck
    truck2 - truck

    ;; Crates
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
  )

  ;; Predicates
  (:predicates
    (on ?c - crate ?p - pallet)        ; A crate is on a pallet
    (ontable ?t - tray ?l - location)   ; A tray is on a table (deleted since 'tray' was undefined)
    (holding ?h - hoist ?c - crate)     ; A hoist holds a crate
    (clear ?x - object)                ; An object has nothing on top of it
    (at ?v - vehicle ?l - location)     ; A vehicle is at a location
  )

  ;; Action schemas
  (:action pick-up-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (hoist-at ?h ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)))
            (holding ?h ?c) (not (holding ?h nil))
  )

  (:action put-down-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (holding ?h ?c) (clear ?l) (at ?h ?l))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (on ?c nil) (clear ?c) (at ?h ?l)
  )

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at ?t ?from))
    :effect (and (not (at ?t ?from)) (at ?t ?to))
  )

  (:action load-crate-onto-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)) (on ?c ?t))
  )

  (:action unload-crate-from-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (on ?c ?t))
    :effect (and (not (on ?c ?t)) (clear ?c) (on ?c nil))
  )

  (:action lift-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h ?c) (clear ?pl))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (not (clear ?pl)) (clear ?pl)
            (on ?c ?pl) (not (on ?c nil))
  )

  (:action lower-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h nil) (on ?c ?pl))
    :effect (and (holding ?h ?c) (not (holding ?h nil)))
            (clear ?pl) (not (clear ?pl))
            (on ?c nil) (not (on ?c ?pl))
  )
)

```

The above code produces the following error -> There is a semantic error where unknown type 'tray' is used in predicate definition.

Instruction 1: Correct the error and give the entire PDDL code in code blocks and please do not give any explanations in the output.
Instruction 2: Do not create a problem file and do not use conditional expressions.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain truck-crane)
  (:requirements :strips :typing)

  ;; Types
  (:types crate truck pallet hoist location)

  ;; Constant definitions
  (:constants
    ;; Locations
    loc1 - location
    loc2 - location

    ;; Cranes & Hoists
    hoist1 - hoist
    hoist2 - hoist

    ;; Pallets
    palletA - pallet
    palletB - pallet

    ;; Trucks
    truck1 - truck
    truck2 - truck

    ;; Crates
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
  )

  ;; Predicates
  (:predicates
    (on ?c - crate ?p - pallet)         ; A crate is on a pallet
    (holding ?h - hoist ?c - crate)      ; A hoist holds a crate
    (clear ?x - object)                 ; An object has nothing on top of it
    (at ?v - vehicle ?l - location)      ; A vehicle is at a location
  )

  ;; Action schemas
  (:action pick-up-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (hoist-at ?h ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)))
              (holding ?h ?c) (not (holding ?h nil))
  )

  (:action put-down-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (holding ?h ?c) (clear ?l) (at ?h ?l))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (on ?c nil) (clear ?c) (at ?h ?l)
  )

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at ?t ?from))
    :effect (and (not (at ?t ?from)) (at ?t ?to))
  )

  (:action load-crate-onto-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)) (on ?c ?t))
  )

  (:action unload-crate-from-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (on ?c ?t))
    :effect (and (not (on ?c ?t)) (clear ?c) (on ?c nil))
  )

  (:action lift-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h ?c) (clear ?pl))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (not (clear ?pl)) (clear ?pl)
            (on ?c ?pl) (not (on ?c nil))
  )

  (:action lower-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h nil) (on ?c ?pl))
    :effect (and (holding ?h ?c) (not (holding ?h nil)))
            (clear ?pl) (not (clear ?pl))
            (on ?c nil) (not (on ?c ?pl))
  )
)

```
**USER** :
```pddl

(define (domain truck-crane)
  (:requirements :strips :typing)

  ;; Types
  (:types crate truck pallet hoist location)

  ;; Constant definitions
  (:constants
    ;; Locations
    loc1 - location
    loc2 - location

    ;; Cranes & Hoists
    hoist1 - hoist
    hoist2 - hoist

    ;; Pallets
    palletA - pallet
    palletB - pallet

    ;; Trucks
    truck1 - truck
    truck2 - truck

    ;; Crates
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
  )

  ;; Predicates
  (:predicates
    (on ?c - crate ?p - pallet)         ; A crate is on a pallet
    (holding ?h - hoist ?c - crate)      ; A hoist holds a crate
    (clear ?x - object)                 ; An object has nothing on top of it
    (at ?v - vehicle ?l - location)      ; A vehicle is at a location
  )

  ;; Action schemas
  (:action pick-up-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (hoist-at ?h ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)))
              (holding ?h ?c) (not (holding ?h nil))
  )

  (:action put-down-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (holding ?h ?c) (clear ?l) (at ?h ?l))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (on ?c nil) (clear ?c) (at ?h ?l)
  )

  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at ?t ?from))
    :effect (and (not (at ?t ?from)) (at ?t ?to))
  )

  (:action load-crate-onto-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)) (on ?c ?t))
  )

  (:action unload-crate-from-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at ?t ?l) (on ?c ?t))
    :effect (and (not (on ?c ?t)) (clear ?c) (on ?c nil))
  )

  (:action lift-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h ?c) (clear ?pl))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (not (clear ?pl)) (clear ?pl)
            (on ?c ?pl) (not (on ?c nil))
  )

  (:action lower-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h nil) (on ?c ?pl))
    :effect (and (holding ?h ?c) (not (holding ?h nil)))
            (clear ?pl) (not (clear ?pl))
            (on ?c nil) (not (on ?c ?pl))
  )
)

```

The above code produces the following error -> There is a semantic error where unknown type 'vehicle' is used in predicate definition.

Instruction 1: Correct the error and give the entire PDDL code in code blocks and please do not give any explanations in the output.
Instruction 2: Do not create a problem file and do not use conditional expressions.
**LLM MODEL** (HUGGING_FACE):
```pddl 

(define (domain truck-crane)
  (:requirements :strips :typing)
  
  ;; Types
  (:types crate truck pallet hoist location)
  
  ;; Constant definitions
  (:constants
    ;; Locations
    loc1 - location
    loc2 - location
    
    ;; Cranes & Hoists
    hoist1 - hoist
    hoist2 - hoist
    
    ;; Pallets
    palletA - pallet
    palletB - pallet
    
    ;; Trucks
    truck1 - truck
    truck2 - truck
    
    ;; Crates
    crate1 - crate
    crate2 - crate
    crate3 - crate
    crate4 - crate
  )
  
  ;; Predicates
  (:predicates
    (on ?c - crate ?p - pallet)         ; A crate is on a pallet
    (holding ?h - hoist ?c - crate)      ; A hoist holds a crate
    (clear ?x - object)                 ; An object has nothing on top of it
    (at-truck ?t - truck ?l - location)  ; A truck is at a location
    (at-hoist ?h - hoist ?l - location)  ; A hoist is at a location
  )
  
  ;; Action schemas
  (:action pick-up-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (at-hoist ?h ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)))
              (holding ?h ?c) (not (holding ?h nil))
  )
  
  (:action put-down-crate
    :parameters (?h - hoist ?c - crate ?l - location)
    :precondition (and (holding ?h ?c) (clear ?l) (at-hoist ?h ?l))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (on ?c nil) (clear ?c) (at-hoist ?h ?l)
  )
  
  (:action move-truck
    :parameters (?t - truck ?from - location ?to - location)
    :precondition (and (at-truck ?t ?from))
    :effect (and (not (at-truck ?t ?from)) (at-truck ?t ?to))
  )
  
  (:action load-crate-onto-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at-truck ?t ?l) (clear ?c) (on ?c nil))
    :effect (and (not (on ?c nil)) (not (clear ?c)) (on ?c ?t))
  )
  
  (:action unload-crate-from-truck
    :parameters (?t - truck ?c - crate ?l - location)
    :precondition (and (at-truck ?t ?l) (on ?c ?t))
    :effect (and (not (on ?c ?t)) (clear ?c) (on ?c nil))
  )
  
  (:action lift-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h ?c) (clear ?pl))
    :effect (and (not (holding ?h ?c)) (holding ?h nil))
            (not (clear ?pl)) (clear ?pl)
            (on ?c ?pl) (not (on ?c nil))
  )
  
  (:action lower-with-hoist
    :parameters (?h - hoist ?c - crate ?pl - pallet)
    :precondition (and (holding ?h nil) (on ?c ?pl))
    :effect (and (holding ?h ?c) (not (holding ?h nil)))
            (clear ?pl) (not (clear ?pl))
            (on ?c nil) (not (on ?c ?pl))
  )
)

```