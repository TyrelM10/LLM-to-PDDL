**GPT-3.5 - Managing Context - LOGISTICS** [Conversation Link](https://chat.openai.com/share/066c8fea-74a3-48de-a1c2-d66a4fc81525)

---
**STEP 1:**
**USER:**
There are several cities, each containing several locations, some of which are airports. There are also trucks, which can drive within a single city, and airplanes, which can fly between airports. The goal is to get some packages from various locations to various new locations. This domain was created by Bart Selman and Henry Kautz, based on an earlier domain by Manuela Veloso.

Requirement: Generate PDDL domain code for the above text description in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain transportation)
    (:requirements :strips :typing)
    (:types city location - place airport - location truck airplane - vehicle package - object)
    (:predicates 
        (at ?v - vehicle ?l - location)
        (in ?p - package ?l - location)
        (connected ?c1 ?c2 - city)
        (can_drive ?t - truck)
        (can_fly ?a - airplane)
        (at_airport ?l - location)
    )

    (:action drive
        :parameters (?t - truck ?from ?to - location)
        :precondition (and 
            (at ?t ?from)
            (connected ?from ?to)
            (can_drive ?t)
        )
        :effect (and 
            (not (at ?t ?from))
            (at ?t ?to)
        )
    )

    (:action fly
        :parameters (?a - airplane ?from ?to - location)
        :precondition (and 
            (at ?a ?from)
            (at_airport ?from)
            (at_airport ?to)
            (can_fly ?a)
        )
        :effect (and 
            (not (at ?a ?from))
            (at ?a ?to)
        )
    )
)
```
**STEP 2:**
**USER:**
The above code produces the following error -> There is a semantic error of unknown parent type: place.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain transportation)
    (:requirements :strips :typing)
    (:types city location airport - location truck airplane - vehicle package - object)
    (:predicates 
        (at ?v - vehicle ?l - location)
        (in ?p - package ?l - location)
        (connected ?c1 ?c2 - city)
        (can_drive ?t - truck)
        (can_fly ?a - airplane)
        (at_airport ?l - location)
    )

    (:action drive
        :parameters (?t - truck ?from ?to - location)
        :precondition (and 
            (at ?t ?from)
            (connected ?from ?to)
            (can_drive ?t)
        )
        :effect (and 
            (not (at ?t ?from))
            (at ?t ?to)
        )
    )

    (:action fly
        :parameters (?a - airplane ?from ?to - location)
        :precondition (and 
            (at ?a ?from)
            (at_airport ?from)
            (at_airport ?to)
            (can_fly ?a)
        )
        :effect (and 
            (not (at ?a ?from))
            (at ?a ?to)
        )
    )
)
```


**STEP 3:**
**USER:**
The above code produces the following error -> There is a semantic error of unknown parent type: vehicle.

Requirement 1: Correct the error and give the entire pddl domain code. 
Requirement 2: Do not create a problem file. Do not use conditional expressions.
Requirement 3: Generate PDDL domain code in code blocks delimited only between ```pddl <CODE></CODE> ```. Do not give any explanations.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (domain transportation)
    (:requirements :strips :typing)
    (:types city location airport - location truck airplane - object package - object)
    (:predicates 
        (at ?v - object ?l - location)
        (in ?p - package ?l - location)
        (connected ?c1 ?c2 - city)
        (can_drive ?t - truck)
        (can_fly ?a - airplane)
        (at_airport ?l - location)
    )

    (:action drive
        :parameters (?t - truck ?from ?to - location)
        :precondition (and 
            (at ?t ?from)
            (connected ?from ?to)
            (can_drive ?t)
        )
        :effect (and 
            (not (at ?t ?from))
            (at ?t ?to)
        )
    )

    (:action fly
        :parameters (?a - airplane ?from ?to - location)
        :precondition (and 
            (at ?a ?from)
            (at_airport ?from)
            (at_airport ?to)
            (can_fly ?a)
        )
        :effect (and 
            (not (at ?a ?from))
            (at ?a ?to)
        )
    )
)
```
<span style="color:green">_**NOTE:** DOMAIN WAS SUCCESSFULLY PARSED_</span>

---

**BELOW IS THE PART TO GET THE PROBLEM FROM THE LLM FOR THIS DOMAIN TO SOLVE**

**USER:**
For the above the PDDL domain code, create a problem file in PDDL that when put into a planner to solve will give valid actions and an action path to reach a goal.

**LLM MODEL (GPT-3.5-Turbo):**
```
(define (problem transportation_problem)
    (:domain transportation)
    (:objects
        truck1 airplane1 - object
        city1 city2 - city
        location1 location2 location3 - location
        package1 package2 - object
    )
    (:init
        (at truck1 location1)
        (at airplane1 location1)
        (connected city1 city2)
        (at_airport location1)
        (at_airport location2)
        (at_airport location3)
        (can_drive truck1)
        (can_fly airplane1)
        (in package1 location1)
        (in package2 location3)
    )
    (:goal (and 
        (at package1 location2)
        (at package2 location1)
    ))
)
```

<span style="color:red">_**NOTE:** This code did not produce any plan and also took too long in validator._</span>