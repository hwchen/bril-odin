package bril_json

Program :: struct {
    functions: []Function,
}

Function :: struct {
    name:   string,
    args:   []string,
    type:   Maybe(string),
    instrs: []Code,
}

// Label or Instruction
Code :: struct {
    // If label
    label:  string,

    // If Instruction
    op:     string,
    dest:   Maybe(string),
    type:   Maybe(string),
    args:   []string,
    funcs:  []string,
    labels: []string,
}
