will add later

3/5/26 - Initial Planning

I began the project by reading through the assignment instructions and identifying the main requirements of the prefix calculator. The program must read input line by line, evaluate prefix expressions, store successful results in a history list, and stop when the user enters "quit".

It must support numbers, unary negation, addition, multiplication, division, and history references using $n. I also noted that the parser must process expressions character by character, ignore whitespace, detect invalid expressions, and return both the computed value and any remaining characters so the program can verify that the entire input was consumed.

To approach the project, I broke the problem down into smaller, manageable pieces before writing any code. I plan to implement helper functions for skipping whitespace, parsing numbers, evaluating expressions, and handling each operator. The core evaluation function will determine what type of expression is being read and delegate to the appropriate helper function. I will also implement a loop that repeatedly reads input, evaluates it, prints results in the required format, and stores successful results in the history list using a functional approach. Starting with simple number parsing and gradually adding operators and history references should make the implementation easier to test and debug.
