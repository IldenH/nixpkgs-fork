{ configuration ? import ./lib/from-env.nix "NIXOS_CONFIG" <nixos-config>
, system ? builtins.currentSystem
}:

let

  eval = import ./lib/eval-config.nix {
    inherit system;
    modules = [ configuration ];
  };

in

{
  inherit (eval) pkgs config options;

  system = eval.config.system.build.toplevel;

  vm = eval.config.virtualisation.vmVariant.system.build.vm;

  vmWithBootLoader = eval.config.virtualisation.vmVariantWithBootLoader.system.build.vm;
}
