{ pkgs ? import ./nix/pkgs.nix }:

let
  opencv-type-stub = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/bschnurr/python-type-stubs/add-opencv/cv2/__init__.pyi";
    sha256 = "sha256-IkE/b5/bZe7oC95xTwxrlH3iZYnK3pNCarz8QYxVecY=";
  };
  mypy-stubs = pkgs.runCommand "mypy-stubs" {} ''
    mkdir -p $out/stubs
    cp ${opencv-type-stub} $out/stubs/cv2.pyi
  '';
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nixpkgs-fmt
    actionlint
    python311
    python311Packages.opencv4
    python311Packages.black
    python311Packages.mypy
    python311Packages.pytest
  ];
  # shellHook = ''
  #   export MYPYPATH=${mypy-stubs}/stubs:$MYPYPATH
  # '';
}
