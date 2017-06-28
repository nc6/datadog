{ghc}:
with (import <nixpkgs> {});

haskell.lib.buildStackProject {
  inherit ghc;
  name = "datadog";
  buildInputs = [ zlib ];
}
