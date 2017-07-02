# gbud
[![Gem Version](https://badge.fury.io/rb/gbud.svg)](https://badge.fury.io/rb/gbud)

[Documentation](https://d3d1rty.github.io/gbud/)

## Table of Contents
* About
* Why use gbud?
* Why not bundler?
* Getting started
    * Installation
    * Usage
* Contributing
    * Code of Conduct
    * Code Style
    * Documentation
    * Testing
* TODO

## About
This project aims to simplify the initialization of a Ruby project by setting up the appropriate directories and files needed. By default, projects created by `gbud` are GPL-3.0 compliant, although support for the LGPL-3.0 is on the way; `gbud` will never support instantiating non-free projects.

## Why Use gbud?
`gbud` rapidly scaffolds a new gem for you, allowing you to skip the tedious part of building out a gem manually. It automatically protects the freedom of your code by including the GPL with your project, providing command-line options for users to get copyright and warranty information for your project, as well as inserting boilerplate GPL copyright notices on each of the source files for the project. Future efforts will allow selection of the LGPL as an alternative to the GPL.

## Why Not bundler?
`gbud` does not aim to solve the same problem that `bundler` solves, and there is no reason why you can't instantiate a project with `gbud` and use `bundler` for dependency management. However, `bundler` did not meet my requirements for creating a project from scratch (i.e. the way *I want it done*), thus I produced this gem to meet my own need. I hope it also proves useful to you, and anyone is welcome to recommending or implementing reasonable changes and enhancements to `gbud`.

## Getting Started
### Installation
To install from RubyGems, execute:

`gem install gbud`

Alternatively, you could build from source:

```
git clone https://github.com/d3d1rty/gbud.git
cd gbud
gem build gbud.gemspec
gem install ./gbud-0.0.4.gem
```

### Usage
Navigate to the directory you want to hold the project

Execute command `gbud -n NAME` where `NAME` is the name for your project

Answer the prompts to set the required information for the project

Based off your input, gbud will generate

  * a skeleton directory for the project
  * an executable (if CLI is specified)
  * main script
  * library file
  * test script
  * gemspec
  * Gemfile
  * Guardfile
  * Rakefile
  * README
  * LICENSE

Navigate to the generated project directory

Get the dependencies with `bundle install`

Execute `rake test` to verify everything is good to go

## Contributing
### Code of Conduct
All contributions are welcome, but are merged at the discretion of the core
contributor(s). Contributions to the project will be
judged on their merits without respect to a contributor's publicly or
privately held beliefs, opinions, ideology, nationality, ethnicity, or
demographic. Most communications within the project should be limited to
project planning, development, bugfixing, or other relevant topics; for
off-topic discussions, contributors are expected to use good judgement
and to avoid intentionally abusive behavior. Conflict should be resolved
at the lowest level possible with minimal disruption to the project. Core
contributor(s) reserve the right to request that a contributor alter their
behavior, however, nothing in this code of conduct should be construed in
such a manner that it infringes upon any contributor's freedom of expression.

### Code Style
To keep a consistent code style, it is recommended to use
[rubocop](https://github.com/bbatsov/rubocop). If you use `vim` and
[syntastic](https://github.com/vim-syntastic/syntastic), you
can use `rubocop` as a Ruby checker. To manually run `rubocop`, you
can run the following commands:

```
# Run rubocop for the entire project
bundle exec rubocop
# Run rubocop for a specific file
bundle exec rubocop foo/bar.rb
```

### Documentation
Comment any code contributions according to the existing conventions within the project.
Reference the examples listed below:

Example top-level comment:

```
##
# = ClassNameGoesHere
# Author::    Dick Davis (+/- individual contributors)
# Copyright:: Copyright 2017 Dick Davis
# License::   GNU Public License 3
#
# This is a class that is something and does something.
```

Example method comment:

```
##
# This is a method that does something
```

Documentation should be regenerated prior to merging any branches into master. The latest
[documentation](https://d3d1rty.github.io/gbud/) auto-sources off the `docs/` folder on
the master branch. For more information on RDoc, go
[here](https://rdoc.github.io/rdoc/index.html).

```
# Run custom rake task to regenerate RDoc documentation
rake rdoc
```

### Testing
Integration tests should be written for all classes and methods. The test suite
can be run manually or automatically with the command `bundle exec rake test`.

## TODO
* Decouple template and project builder logic
* Write tests for `FileTemplate` (to be implemented) and `ProjectBuilder` classes
* Implement `--cli` and `--no-cli` options
* Implement `--lgpl` option for generating LGPL protected code
