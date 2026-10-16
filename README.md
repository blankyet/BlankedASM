# blsm

**A self-hosting x86-64 assembler for Linux, bootstrapped from a
find-and-replace script. No existing assembler, no libc, no linker
in the final stage.**

blsm assembles its own source code into a standalone ELF executable,
writing the ELF and program headers itself.

## Highlights

- **Self-hosting:** blsm compiles itself, and I recompile it repeatedly in
  the build to check the output stays stable.
- **Built from nothing:** the only non-blsm tool in the chain is a shell
  script that swaps words for hex bytes.
- **Writes ELF directly:** emits the ELF header and program header by
  hand. No `as`, `ld` or gcc in the final stage.
- **Labels without label support:** the first stage has no jump labels,
  yet supports forward jumps through a two-run trick (see below).
- **Working demos:** hello world, `cat`, and a [HTTP] server, all written
  in blsm.

## The bootstrap chain

```
v0  shell script (find/replace)  ->  raw machine code
v1  written in v0 hex, injected into a C stub's .my_code section
v2  real assembler with functions, writes complete ELF files
v3  v2 compiles its own source -> final ./blsm
```

| Stage | What it is | Tools needed |
|-------|------------|--------------|
| v0 | Find-and-replace script, so I don't write hex everywhere | shell |
| v1 | First real assembler. All logic in machine code, all variables on the stack | gcc, objcopy (as a loader only) |
| v2 | Normal code with functions. Emits ELF headers itself | none |
| v3 | v2 assembling its own source | none |

## The interesting part: forward jumps with no labels

v1 has no label table, but code often needs to jump to a place that comes
*later* in the file. The solution is to run the whole program twice:

1. **Pass 1:** every instruction is wrapped in `if r15 == 0, skip`. Nothing
   really executes, but each label stores its address (read from `rip`)
   on the stack. At the end of the file, `r15` is set to 1 and execution
   jumps back to the start.
2. **Pass 2:** `r15 == 1`, so instructions execute for real. Every label,
   including ones defined after the jump, is already known.

It is a classic two-pass assembler, but the passes happen at runtime
inside the machine code instead of in a separate tool.

## What I learned

- x86-64 instruction encoding and the Linux syscall interface
- The ELF file format: headers, segments, entry point
- How compilers and assemblers bootstrap themselves
- File I/O and buffering at the lowest level (`read`, `lseek`, handling
  lines that cross buffer boundaries)
- Debugging machine code with raw register and memory dumps

## Build

Needs Linux x86-64, `gcc` and `objcopy`.

```
cd linux_x86
./build.sh
```

This builds v1, uses v1 to build v2, uses v2 to build `blsm`, then
recompiles itself several times to confirm it is stable.

## Limitations / TODO

blsm is a learning project and still rough:

- [ ] **No error handling.** Bad input can crash it or produce a broken
      binary, with no error message.
- [ ] **Not user friendly.** No helpful messages, no line numbers, no
      usage hints when something goes wrong.
- [ ] **only 64bit registers** Not supported: `r8`-`r15` and the smaller forms (`eax`, `ax`, `al`, ...).

## Usage

```
./blsm <file.blsm> [output_name | -j]
```

```
./blsm demos/hello_world.blsm -j          # assemble and run
./blsm demos/hello_world.blsm hi && ./hi  # write an executable
./blsm demos/server.blsm -j
```