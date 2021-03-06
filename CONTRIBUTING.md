# Contributing

## Getting Started

Fork and clone per usual, then run:

```bash
$ bundle install
$ git submodule init
$ git submodule update
```

## Running the Tests

Run the tests with `rake`:

```bash
$ bundle exec rake
```

** If you do not go through the [Getting Started](#getting-started) section your tests will _not_ pass.**

You can run individual test suites using the `ruby` command:

```bash
$ ruby path/to/something_test.rb
```

## Running Locally

Run the server with `rackup`:

```bash
$ rackup
Puma 2.7.1 starting...
* Min threads: 0, max threads: 16
* Environment: development
* Listening on tcp://0.0.0.0:9292...
```

At this point you can navigate to an existing endpoint in your browser, e.g.
[localhost:9292/exercises/ruby/bob](http://localhost:9292/exercises/ruby/bob)

## The Problem Data

The supporting code for a given problem can be found in language-specific
subdirectories under the `problems` directory.

**If you're not seeing any problems it is probably because you haven't
updated or inititialized the submodules. Be sure to work through the
[Getting Started](#getting-started) section.**

Each language-specific directory is a git submodule. If you wish to make
changes to a problem, look for the corresponding repository on GitHub under
`exercism/x{LANGUAGE_NAME}`.

So, for example, the Scala examples can be found in this repository:

```bash
$ ls problems/scala
```

The corresponding git repository is at
[github.com/exercism/xscala](https://github.com/exercism/xscala).

The READMEs are constructed using shared metadata in the `metadata` directory.
This is also a git submodule, and if you wish to make changes to it, the codebase
can be found on GitHub under [exercism/x-common](https://github.com/exercism/x-common).

If you have global instructions for a given language, it can go in a file
named `SETUP.md` in the root of the language repository. These will be
included in the README for each problem.

## Implementing a new language

If you're interested in adding problems for a language that we don't yet have,
[email me](mailto:kytrinyx@exercism.io) or [tweet at me](https://twitter.com/kytrinyx)
and I'll set up a new repo for that language.

Then you can fork & clone per usual.

We will need at least 10 problems in order to launch, as well as a small handful of
people who can kick off the nitpicking. These people should have a good grasp of the
styles and idioms in use in that language.

For more about this, see the [CONTRIBUTING.md file](https://github.com/exercism/exercism.io/blob/master/CONTRIBUTING.md) in the main exercism.io repository.

## Abstractions

The core ideas in the codebase are:

* [Progression](lib/xapi/progression.rb) - a complete list of all the problems currently available for
  a language, in the order that they will be delivered by default. This is
  based on the contents of the `EXERCISES.txt` file in the language-specific
  repository.
* [Problem](lib/xapi/problem.rb) - the basic unit of work in exercism. It is in a given language,
  and has a `slug` that identifies it.
  An exercise consists of a `Readme` and `Code`.
* [Readme](lib/xapi/readme.rb) - a language-independent explanation of the problem to be solved.
* [Code](lib/xapi/code.rb) - supporting code to solve the problem. In its most basic form, it
  consists of a test suite, but there can be other supporting files (class
  or type definitions, metadata files, etc).
* [Lesson](lib/xapi/lesson.rb) - a subset of problems in a progression.
* [Course](lib/xapi/homework.rb) - a collection of lessons.

There is also the concept of `Homework` which wraps the process of getting
a user's current exercise set from exercism.io, and then producing a course
from it.

**NOTE** A _problem_ is a README and test suite/supporting code (language+slug). An _exercise_ is a problem worked by a user.

## Code Arrangement

The sinatra app lives in `lib/app`, and the business logic lives in
`lib/xapi`. To determine whether something is business logic or web
application logic, think about whether or not a different interface (say,
perhaps a command-line interface) would also need that behavior.

The tests live under `test`, and the path to the test file will mirror the
path to the code file, except with `test` rather than `lib`:

```bash
lib/app/routes/demo.rb
test/app/routes/demo_test.rb
```

There could be exceptions to this, but they are rare.
