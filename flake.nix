{
  description = "estante-text — four batteries: json (jq), yaml (yq), csv (qsv/xsv), text (awk/sort)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: (import "${inputs.substrate}/lib/build/estante/flake.nix" {
    inherit (inputs) nixpkgs flake-utils;
  }) {
    name = "estante-text";
    version = "0.1.0";
    src = inputs.self;
    description = "Structured-data + plaintext wrangling — jq / yq / qsv / awk shortcuts.";
    exports = [ "alias" "function" "kind:library"
                "battery:json" "battery:yaml" "battery:csv" "battery:text" ];
  };
}
