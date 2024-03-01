# CP-AutoTest
Auto test multiple code samples for Competitive Programming

## Demo

https://github.com/jacakira/CP-AutoTest/assets/98449572/29aa57fe-cb9c-4e54-9f85-ca3275eeb0c2

## Dependencies

This program requires the zsh terminal and an installation of the gcc compiler to run. 

## Usage

For the program to run, files `$1.cpp`, `$1.in` and `$1.out` are required in the same directory. We run the program with the command `cprun $1`. For example if our files were given by `a.cpp`, `a.in` and `a.out` we would use the command `cprun a`

### Compilation

The file is compiled with the gcc compiler using the following command:
`g++-13 $1.cpp -o $1`

### Format for sample cases

Each sample case must be delimited by a `---`. For example, 3 sample cases could be given as shown below:

```
3
2 4 5
Hello
---
5
1 3 5 3 6
Beautiful
---
4
1 9 11 3
World
---
```

### Format for ouptut

The output will be formatted in the same way as the input, with each case delimited by a `---`.

