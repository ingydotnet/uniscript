# UniScript language specification

This is the document that contains the ideas we want to put into UniScript.

## Implementation Details

- BootStrap with CoffeeScript as both UniScript (syntax) and C'Dent (compiler)
- UniScript should be migrated to Pegex parser instead of the Jison + helpers
  dance that Coffee uses.
- Use Makefiles for eveything. Generate Makefile from package.yaml when
  possible.

## General Language Ideas

- global replaced by symbol

    maybe %

- %('name') replaces require('name')

`require` is tied to JS, but needed by nearly every module

- No keywords. All [\w\$]+ can be identifier

    var = 1
    if = 2
    while = 3
    class = 4

- Defaults for destructuring

    {x, y=default}

This would allow

    foo = ({a, b=false}) ->

- Indentation can extend any line

    x = 1
      if foo? or
          bar == 3

CoffeeScript doesn't support this, and it makes for long lines.

== Bad Coffee - Things to avoid that CoffeeScript does poorly

- Compile error messages need to be more friendly




