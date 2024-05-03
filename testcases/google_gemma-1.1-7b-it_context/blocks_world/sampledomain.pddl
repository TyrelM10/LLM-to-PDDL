(:domain blocks)

(:objects
    (block A)
    (block B)
    (block C)
    table)

(:predicates
    (:on ?block1 ?block2) ; Block ?block1 is on top of block ?block2 or on the table.
    (:free ?block) ; Block ?block is not under another block.
)

(:actions
    (:move ?block ?location) {
        (assert (on ?block ?location))
        (assert (not (free ?block)))
    }
)

(:goals
    (:stack ?block1 ?block2 ...)) ; Build a stack of blocks, starting with ?block1 and ending with ?block2.
)

(:init
    (free A)
    (free B)
    (free C)
    (on A table)
)