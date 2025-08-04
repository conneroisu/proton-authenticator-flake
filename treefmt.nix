# treefmt configuration
{pkgs, ...}: {
  # Used to find the project root
  projectRootFile = "flake.nix";

  programs = {
    # Nix formatter
    alejandra.enable = true;
    # Markdown formatter
    mdformat.enable = true;
    # YAML formatter
    yamlfmt.enable = true;
  };

  settings.formatter = {
    alejandra = {
      excludes = ["*.md"];
    };
    mdformat = {
      includes = ["*.md"];
    };
    yamlfmt = {
      includes = ["*.yml" "*.yaml"];
    };
  };
}