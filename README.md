# 4337_Project1
Prefix-notation calculator in Racket  
Author: Humza Maqsood - DAL934177

## Overview

This project implements a prefix expression calculator written in Racket. The program reads expressions from standard input, evaluates them using recursive parsing, and stores the results of successful evaluations in a history list. The calculator continues running until the user enters the command `quit`.

Expressions are written in prefix notation, meaning the operator appears before its operands. The program supports nested expressions, history references, and basic arithmetic operations.

## Repository Files

`project1.rkt`  
Main program implementation. Contains the evaluation loop, recursive parser, arithmetic operations, history system, and expression validation.

`mode.rkt`  
Provided helper file used to determine whether the program is running in interactive mode or batch mode. This file was not modified.

`README.md`  
Documentation describing the project, file structure, and instructions for running the program.

`devlog.md` (or development log file)  
Development log describing the design process and the work completed during each implementation session.

## Supported Operations

The calculator supports the following types of expressions:

- Integer numbers
- Unary negation using `-`
- Addition using `+`
- Multiplication using `*`
- Division using `/` (integer division)
- History references using `$n`

History references allow previously computed results to be reused in later expressions.

## Example Input
5
+1 2
*2 3
+*2 3 4
+$1 $2
-5


## Example Output

5
1: 5.0
+1 2
2: 3.0
*2 3
3: 6.0
+$1 $2
4: 8.0


Each successful expression is assigned a sequential ID and stored in history. The `$n` syntax retrieves the result with the corresponding ID.

## Error Handling

If an expression cannot be evaluated, the program prints:

Error: Invalid Expression


Examples of invalid expressions include:

- Expressions with extra tokens (for example `+1 2 3`)
- Invalid history references such as `$0`
- Division by zero
- Non-numeric input
- Missing operands

## Program Structure

The program is organized around several main components.

### `main`

The entry point of the program. It starts the evaluation loop with an empty history list.

### `eval-loop`

Continuously reads input from the user, evaluates expressions, prints results, and updates the history list.

### `eval-expression`

The core recursive parser that determines the type of expression being evaluated. It processes the input character by character and returns both the computed value and any remaining characters.

### Helper Functions

Several helper functions support the parser:

- `skip-whitespace` – removes leading whitespace characters
- `parse-number` – reads a numeric value from the input
- `parse-history` – handles `$n` history references
- `history-ref` – retrieves values from the history list
- `eval-negate` – evaluates unary negation
- `eval-plus` – evaluates addition
- `eval-times` – evaluates multiplication
- `eval-divide` – evaluates division
- `evaluate-line` – ensures that the entire input expression was consumed

## History System

Successful results are stored in a history list using `cons`. Each result is assigned an ID based on the order it was computed. History references use the syntax `$n`, where `n` corresponds to the ID number of the result.

Example:

5
1: 5.0
8
2: 8.0
+$1 $2
3: 13.0


## Interactive vs Batch Mode

The program supports both interactive and batch execution through the provided `mode.rkt` file.

- Interactive mode displays a prompt (`> `)
- Batch mode suppresses the prompt

## Running the Program

The program can be run in DrRacket or from the command line.

Interactive mode:

racket project1.rkt


Batch mode:

racket project1.rkt -b


## Testing

The calculator was tested using a variety of valid and invalid expressions, including:

5
+1 2
*2 3
+$1 $2
+1 2 3
$0
/5 0
abc


Additional tests included nested expressions, whitespace variations, and history references to ensure correct parsing and evaluation behavior.

## Development Process

The project was implemented incrementally by dividing the work into several sessions. The parser was built first, followed by the operator logic, history support, and final integration with the evaluation loop. This approach made it easier to isolate bugs and verify each feature before moving on to the next part of the implementation.

## Notes for the TA

The program was tested with both valid and invalid expressions to verify correct parsing and error handling. The development log included in the repository documents the design process, debugging steps, and implementation decisions made during the project.

## Author

Humza Maqsood - DAL934177
