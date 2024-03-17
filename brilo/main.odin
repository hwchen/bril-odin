package bril

import "core:bufio"
import "core:encoding/json"
import "core:fmt"
import "core:log"
import "core:os"

import bril_json "./json"

main :: proc() {
    context.logger = log.create_console_logger(.Info)

    buf: [4096]u8
    bytes_read, _ := os.read(os.stdin, buf[:])


    program: bril_json.Program
    _jerr := json.unmarshal(buf[:bytes_read], &program)

    fmt.print(program)
}
