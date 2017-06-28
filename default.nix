{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aeson, auto-update, base, buffer-builder
      , bytestring, Cabal, dlist, http-client, http-client-tls
      , http-types, lens, lifted-base, monad-control, network, old-locale
      , stdenv, text, time, transformers-base, unordered-containers
      , vector
      }:
      mkDerivation {
        pname = "datadog";
        version = "0.2.0.0";
        sha256 = "0";
        doCheck = false;
        libraryHaskellDepends = [
          aeson auto-update base buffer-builder bytestring dlist http-client
          http-client-tls http-types lens lifted-base monad-control network
          old-locale text time transformers-base unordered-containers vector
        ];
        testHaskellDepends = [ base Cabal lens network time ];
        homepage = "https://github.com/iand675/datadog";
        description = "Datadog client for Haskell. Supports both the HTTP API and StatsD.";
        license = stdenv.lib.licenses.mit;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskellPackages
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
