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

2/6/2026 5:30 pm
Dev thoughts:

Initially I had planned to do the project in sessions of time, what ever I get done in a session, I get done. I realized that was too broad and would not help me get the project done in time. I realized I needed to redefine my scope. So I have shifted my sessions to be task/goal based instead. Instead of "how much will I get done?" it is "here is what I am going to do". That helps me feel more secure in my plan. The current layout of my sessions is as follows:


Session 2: Core Parser Implementation
Session 3: History System and Expression Validation
Session 4: Program Integration and Final Testing
Session 5: Debug unresolved issues and submit

Quick addendum, the date is supposed to be -3/6/2026- in the log above this

3/6/2026 6:15 pm
Session 2:

In Session 2, the project moved beyond the basic skeleton from Session 1 and began implementing the actual parser logic. I added the helper functions needed to process expressions character by character, including skip-whitespace to ignore leading spaces and parse-number to read numeric values from the input. I then expanded eval-expression so it could recognize numbers and operators, and added the recursive helper functions eval-negate, eval-plus, eval-times, and eval-divide to support unary negation and the main binary operations. This gave the program its first real parsing structure and made it capable of evaluating prefix expressions internally, even though the main loop was still using placeholder output at this stage.

One issue that came up during this session was with loading mode.rkt. At first, I tried using require, then switched to include, and ran into repeated errors involving prompt? being undefined. After checking both files more carefully, I realized the issue came from how mode.rkt was structured and how it was being referenced from the main file. I decided not to modify the provided mode.rkt file directly and instead adjusted the way it was loaded so that prompt? could be accessed without changing the assignment file itself. That debugging process took some extra time, but it resolved the import problem and let me keep building the parser without changing the provided support file.

note to self, start next project earlier

3/6/26 7:29 pm
Session 3: History and Expression Validation

I made a big whoopsie. I thought I was working on session 2 branch, but I had actually been on main the whole time. I had downloaded github desktop as my version tracker, and forgot to switch to branch "session 2" on there. So you'll see Session 2 and Session 1 as matching. What actually happened is as stated before. I've taken the opportunity to reflect on my dumb mistake, and now have verified that I am currently working on branch 3. The reason I did not reverse the commit and recommit off branch 2, is that the version I committed was actually what I would have merged anyways. In a way, I saved myself some time, but it was through a bad practice that should not be repeated. That being said, lets start session 3!

In this session I connected the parser that was built earlier to the main evaluation loop so that user input could actually be evaluated instead of always returning the placeholder error message. I implemented a helper function that converts each input line into a list of characters and passes it to the parser, then verifies that the entire expression was consumed. If any extra characters remain after parsing, the program treats the expression as invalid. This ensures partially valid inputs such as "+1 2 3" or "+1 2 2" are correctly rejected rather than evaluated incorrectly.

I also implemented the history system required by the assignment. Successful results are now stored in a history list and can be referenced later using the "$n" syntax. Because new results are added to the front of the history list using cons, I added logic to correctly retrieve values based on their original ID order. I updated the evaluation loop so that valid expressions print their result with an ID number and invalid expressions display the required error message. During testing I verified that valid prefix expressions, nested expressions, history references, and several invalid cases such as divide-by-zero and malformed expressions all behaved correctly.

here are my test cases:

Language: racket, with debugging; memory limit: 128 MB.
> 5
1: 5.0
> 5
2: 5.0
> +1 2
3: 3.0
> *2 3
4: 6.0
> +$1 $2
5: 10.0
> +1 2 3
Error: Invalid Expression
> +1 2 2
Error: Invalid Expression
> $0
Error: Invalid Expression
> /5 0
Error: Invalid Expression
> quit
> 

Just copied it straight from DrRacket