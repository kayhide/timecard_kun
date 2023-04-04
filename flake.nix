{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/5f4e07deb7c44f27d498f8df9c5f34750acf52d2";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    let
      overlay = final: prev: { };

      perSystem = system:
        let
          pkgs = import inputs.nixpkgs { inherit system; overlays = [ overlay ]; };

          dev-env = pkgs.buildEnv {
            name = "dev-env";
            paths = with pkgs; [
              docker-compose
              gnumake
              jq

              postgresql
              ruby_3_1
              nodejs
            ];
          };
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              dev-env
            ];
          };
        };
    in

    {
      inherit overlay;
    } // inputs.flake-utils.lib.eachDefaultSystem perSystem;
}
