# CO Lab Framework (2024)

**Welcome to the official Lab Framework for the 2023-2024 edition of the Computer Organization course at Vrije Universiteit Amsterdam.**

---

For all information about the course, the assignments, or the Lab in general, please refer to the [Canvas page](https://canvas.vu.nl/courses/75342) or the official [Lab Manual](https://computerscienceeducation.gitbook.io/co-lab-manual/). 
This document only gives information about the technicalities of setting up and using the framework.

## Installation
This framework is set up to work with Microsoft's Visual Studio Code (VS Code) including its GUI debugger. 
Start by opening the root folder of the framework (so the folder that this file is residing in) in VS Code. 
It is important that you do not open VS Code to a parent folder of the framework, as then the setup will not be recognized.

### Installing Extensions
To use the framework with all its features, you will need to install some extensions. 
Upon first opening the framework in VS Code, a prompt should appear in the bottom right corner asking whether you want to install the recommended extensions. 
If the prompt did not appear or you have accidentally dismissed it, simply follow these steps:

1. Open the "Extensions" panel ("View" → "Extensions" | ⇧⌘X | Ctrl + Shift + X)
2. Type "@recommended" in the search bar.
3. Install all (4) extensions that are listed.

If the aforementioned steps do not work for you, you can also find the list of required extensions in the `extensions.json` file as part of the `.vscode` folder of the framework and manually search and install the extensions.

### Additional Extension Setup
The Assembly language extension uses semicolons as line comments by default. 
The AT&T syntax, however, uses the hash character and does not treat lines starting with a semicolon as being commented. 
If you want to fix this behavior such that you can use the line comment keyboard shortcut (⌘/ | CTRL + /), follow the steps given in the [Guide for Fixing the Line Comment Symbol](#guide-for-fixing-the-line-comment-symbol).

## Skeleton Files
For the first 9 assignments, skeleton files are provided that should serve as the starting point for your implementation. 
It is essential that you do not delete or modify the existing code (except for the comments). 
Otherwise your program might no longer work with the automated tests on CodeGrade.

Each file has a list of function names at the top. These are the library functions that are you allowed to use for that particular assignment. 
If you use any additional library functions, your submission will not be accepted during hand-in. 
If you believe that a required function is missing from the list, please approach one of the TAs during your Lab session.

## Building and Running Programs
To build any assignment, open a terminal in the root folder of the framework and run:
```bash
make <folder>/<file>.S
```

You may also use the given shortcut targets:
```bash
make a<num>
```
to build and run the program in one step. The shortcut for `a1` would be equivalent to:
```bash
make a1-hello/a1-hello && ./a1-hello/a1-hello
```

More detailed information on the assembly and linking processes can be found in the Makefile or in the [associated chapter of the Lab Manual](https://computerscienceeducation.gitbook.io/co-lab-manual/reference-documentation/building-and-running-programs).

### Address Sanitization
If you want to run your programs with an address sanitizer (e.g., for debugging) you can add the `SANITIZE=1` option to any make command. This will build the given target with the `-fsanitize=address` flag.


## Using the Debugger
> Note that the installed LLDB extension does not work out-of-the-box on some Intel based Macs.
> If you are on a Mac with an Intel processor, follow the steps given in the [Intel Mac Debugger Fix](#intel-mac-debugger-fix) before continuing here.

To access the VS Code debugger, open the "Run and Debug" panel ("View" → "Run" | ⇧⌘D | Ctrl + Shift + D), select the desired configuration at the top, and click the run button next to the configuration name (F5). 
If no configurations are shown confirm that the VS Code is opened to the root folder of the framework and a folder names `.vscode` exists. 
That folder should contain a `launch.json` file. 

The go-to configuration is **"Debug Current File"**. 
This configuration will build and run the program currently opened in the active editor (the main window of your VS Code application). 
Some assignments require additional arguments to be passed to the program. 
For those, specific configurations exist that will prompt for the required arguments before starting the debugger.

> **Note:** Some assignments involve multiple files, it is necessary to have the file that is named like the make target opened when using the "Debug Current File" configuration (e.g., `a4plus-fib-rec.S` instead of `a4plus-fib-main.S`).

If you have never used a debugger before or need a quick refresher on how to work with it, the Lab Manual contains an introductory guide on [How to use a Debugger](https://computerscienceeducation.gitbook.io/co-lab-manual/appendix/how-to-use-a-debugger).

## Playground
The folder `a0-playground` contains two files: 
- the example `sieve` program as discussed in the [Lab Manual](https://computerscienceeducation.gitbook.io/co-lab-manual/reference-documentation/a0-a-running-example)
- a `sandbox` file that has a structure similar to the assignment skeleton files

You can use and modify both of these programs for experimenting or add further files. 
Any added files that have the correct `.S` extension should be valid Makefile targets and can be built like the given files.

**The `sieve` program is a great way to test your setup and also familiarize yourself with the x86-64 Assembly language.**

## File Preambles
All Assembly (.S) files have a number of lines at the start of the file that may look cryptic at first glance (`#ifdef MACOS ...`).
**Do not modify these lines!** 

These *preambles* are fundamental for compatibility of the written Assembly with both macOS and Linux operating systems as well as with the CodeGrade testing system. You may safely ignore the lines. 

For those interested, a short explanation is provided below:

### Function Redirects
Due to historical reasons C function names are prefixed with an underscore on macOS. 
So, a call like `printf()` in a C program would be compiled to `call _printf` in Assembly and a `call printf` instruction would give an `Undefined symbols` error during linking.

In order to allow the same programs to run on macOS and on Linux (and with that on CodeGrade), all function calls that are allowed for the particular assignment are redirected based on the operating system. 
If the program is preprocessed with the `MACOS` flag (which is automatically included in the assembly commands of the Makefile when run on macOS) all calls to functions that are allowed as part of the assignment are redirected to the associated function with a prefixed underscore. 

These redirects for macOS are not sufficient on their own however. 
If someone was to write a program on macOS and already include the needed function prefixes in their function calls, the program would run on their machine but would not compile on CodeGrade.
To avoid the confusion, the preamble also gives the analogue redirects (from `_func` to `func`) for when the `MACOS` flag is not set

### Standalone
Most assignments ask you to implement a `main` routine, so a standalone program, along with a certain subroutine. 
As parts of the automated tests, not only your standalone program is tested, but also the required subroutine implementation. 

When testing the subroutine implementation, the `main` routine of your program should be ignored (→ no longer be the entry point to the program) such that the `main` routine of the tests can be used.

One option would have been separate the `main` program and subroutine in separate files, such that the tests could then be linked with only the subroutine implementation. 
This, however, seemed to needlessly blow up the number of files in the framework. 
Thereby, the files include the preprocessor directives `#ifdef STANDALONE ...`, which is used to only make your `main` implementation global when the `STANDALONE` flag is set during the preprocessor run (which again is automatically handled by the Makefile targets).

# Appendix

## Guide for Fixing the Line Comment Symbol
As explained before, the Assembly language extensions uses semicolons by default for line comments. 
The syntax and assembler used in this framework, however, require the hash character for commented lines. 

You can modify the behavior of the extension using the steps below. 
The initial steps (opening the configuration file) differ between Windows and macOS/Linux (and Codespaces), the final steps are universal to all OSs.

### macOS / Linux
1. Open a Terminal window and type:\
`cd ~/.vscode/extensions/13xforever.language-x86-64-assembly-` \
but do not press enter yet.

2. Use the Tab key to autocomplete the command for the version of the extension that you have installed (e.g., 3.1.4) and press enter.

3. Now enter:\
`code language-configuration.json`

4. Continue to the [universal](#universal) steps below.

### Windows
1. Open a **Command Line / Powershell** window (not a WSL terminal!) and type:\
`cd ~\.vscode\extensions\13xforever.language-x86-64-assembly-` \
but do not press enter yet.

2. Use the Tab key to autocomplete the command for the version of the extension that you have installed (e.g., 3.1.4) and press enter.

3. Now enter:\
`code language-configuration.json`

4. Continue to the [universal](#universal) steps below.

### Codespaces
1. Open a Terminal (⌃\` | Ctrl + \`) and type:\
`cd ~/.vscode-remote/extensions/13xforever.language-x86-64-assembly-` \
but do not press enter yet.

2. Use the Tab key to autocomplete the command for the version of the extension that you have installed (e.g., 3.1.4) and press enter.

3. Now enter:\
`code language-configuration.json`

4. Continue to the [universal](#universal) steps below.

### Universal
A VS Code editor should open and show the `language-configuration.json` file contents. The file content should look something like this:

```yaml
{
    "comments": {
        // symbol used for single line comment. Remove this entry if your language does not support line comments
        "lineComment": ";"
    },
    // symbols used as brackets
    // ...
}
```

To update the settings, simply change the `;` value of the `lineComment` property to a `#`. The contents should now look like this:

```yaml
{
    "comments": {
        // symbol used for single line comment. Remove this entry if your language does not support line comments
        "lineComment": "#"
    },
    // symbols used as brackets
    // ...
}
```

Finally, save the file and restart VS Code for the settings to take effect 


## Intel Mac Debugger Fix
The Code LLDB extension that is needed for the debugger seems to give issues on some macOS devices running on Intel processors.
If you are on an Intel based Mac, you will need to delete a file in the extension folder as explained below to fix the issue:

1. Open a Terminal window and type:\
`cd ~/.vscode/extensions/vadimcn.vscode-lldb-` \
but do not press enter yet.

2. Use the Tab key to autocomplete the command for the (newest) version of the extension that you have installed (e.g., 1.10.0) and press enter.

3. Now enter:\
`rm lldb/bin/debugserver`
