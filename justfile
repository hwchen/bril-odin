run:
    odin run brilo

run-with bril-file:
    cat {{bril-file}} | bril2json | just run

test:
    odin test brilo
