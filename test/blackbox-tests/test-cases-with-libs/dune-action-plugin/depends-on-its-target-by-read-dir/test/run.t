  $ echo "(lang dune 2.0)" > dune-project

  $ cat > dune << EOF
  > (rule
  >  (target some_file)
  >  (action
  >   (dynamic-run ./foo.exe)))
  > EOF

  $ cp ../bin/foo.exe ./

  $ dune build some_file --display short
           foo some_file
  Error: Dependency cycle between the following files:
     _build/default/some_file
  [1]

^ This is not great. There is no actual dependency cycle, dune is just
interpreting glob dependency too coarsely (it builds all files instead
of just bringing the directory listing up to date).