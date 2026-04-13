{
  description = "stakeholder-circus nim-stakeholder";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [ git jq nim python312 ];
          };
        });
      apps = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          mk = name: text: {
            type = "app";
            program = "${pkgs.writeShellScript name text}";
          };
        in {
          build = mk "build" ''nimble build -y'';
          test = mk "test" ''nimble test -y'';
          check = mk "check" ''nim check src/stakeholder.nim && nim check --path:src tests/test_stakeholder.nim'';
          format = mk "format" ''nimpretty src/stakeholder.nim src/stakeholder_runtime.nim tests/test_stakeholder.nim'';
        });
    };
}
