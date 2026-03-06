will add later

3/5/26 - Initial Planning

I began the project by reading through the assignment instructions and identifying the main requirements of the prefix calculator. The program must read input line by line, evaluate prefix expressions, store successful results in a history list, and stop when the user enters "quit".

It must support numbers, unary negation, addition, multiplication, division, and history references using $n. I also noted that the parser must process expressions character by character, ignore whitespace, detect invalid expressions, and return both the computed value and any remaining characters so the program can verify that the entire input was consumed.

To approach the project, I broke the problem down into smaller, manageable pieces before writing any code. I plan to implement helper functions for skipping whitespace, parsing numbers, evaluating expressions, and handling each operator. The core evaluation function will determine what type of expression is being read and delegate to the appropriate helper function. I will also implement a loop that repeatedly reads input, evaluates it, prints results in the required format, and stores successful results in the history list using a functional approach. Starting with simple number parsing and gradually adding operators and history references should make the implementation easier to test and debug.


3/6/2026 - 10 AM
Session 1: Creating the parser

After finishing the initial planning, I started working on the first pieces of the parser. I aim to break down each part into sessions and work on each session on a new branch. The goal for this session was to begin implementing the basic helper functions that the rest of the calculator will rely on. Since the parser needs to evaluate expressions character by character, I focused on preparing the input for parsing and thinking through how expressions will be processed recursively.

The first functions I plan to implement are the whitespace-handling and number-parsing utilities. These functions will allow the program to ignore unnecessary spaces and correctly read numeric values from the input. Getting these basic parsing tools working first should make it easier to add support for operators and nested expressions later. Once these pieces are working, I will begin implementing the main expression-evaluation function that determines the type of expression being read.

Post Session 1 summary:

During this session I reorganized how the project repository was being managed. Initially I had been making edits directly through GitHub on the web interface, but this quickly became tedious and started causing inconsistencies between versions of the files. Editing remotely also made it difficult to properly test the program or keep track of changes in a meaningful way. Because of this, I decided to restart the workflow by cloning the repository to my local machine and managing it through GitHub Desktop instead. This allows me to develop locally in DrRacket, test the program as I write it, and commit updates to the repository in a cleaner and more controlled way.

After cloning the repository and confirming the folder structure was correct, I added the initial code structure for the calculator program. This included setting up the Racket language declaration, including the provided mode.rkt file, and creating the basic program skeleton. I implemented a placeholder main function and an eval-loop function that reads input and handles the quit condition, along with a stub for the eval-expression function that will later handle parsing expressions. At this stage the program structure is in place, and the next step will be implementing the helper functions for whitespace handling and number parsing so the expression parser can begin to take shape.
