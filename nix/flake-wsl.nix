{
  description = "armkeh NixOS";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Include basic WSL NixOS system setup
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	# Create symlink in /home/<user> to this file and ./configuration-wsl.nix (named configuration.nix)
        ./configuration-wsl.nix
      ];
    };
  };
}