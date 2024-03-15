package bril

Program :: struct {
    functions: []Function,
}

Function :: struct {
    name:   string,
    args:   []string,
    type:   Maybe(string),
    instrs: []Instruction,
}

Label :: struct {
    label: string,
}

Instruction :: struct {
    op:     string,
    dest:   string,
    type:   string,
    args:   []string,
    funcs:  []string,
    labels: []string,
}
