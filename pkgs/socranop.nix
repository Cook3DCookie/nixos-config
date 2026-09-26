{ lib
, python3Packages
, fetchPypi
, wrapGAppsHook3
, gobject-introspection
, gtk3
, libgudev
}:

let
  setuptools_81 = python3Packages.setuptools.overridePythonAttrs (old: rec {
    version = "81.0.0";
    src = old.src.override {
      inherit version;
      hash = "sha256-MJbWp6C0Em+trBDgLxufrQ5cAaKxSNly0D6IZvGm+mc=";
    };
  });
in
python3Packages.buildPythonApplication rec {
  pname = "socranop";
  version = "0.4.92a5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-U5KIV+Ff1J/W0/olx0jpafNEnWf8algDWUmwTn0OW+g=";
  };

  pyproject = true;
  build-system = [ python3Packages.setuptools ];

  nativeBuildInputs = [
    wrapGAppsHook3
    gobject-introspection
  ];

  propagatedBuildInputs = with python3Packages; [
    pygobject3
    pydbus
    pyusb
  ] ++ [
    setuptools_81
    gtk3
    libgudev
  ];

  postInstall = ''
    export PYTHONPATH=$out/lib/python${python3Packages.python.pythonVersion}/site-packages:$PYTHONPATH
    DIRS=$out/lib/python${python3Packages.python.pythonVersion}/site-packages/socranop/dirs.py

    # 1. Inject a Nix-aware Dirs subclass just before the module-level singleton.
    substituteInPlace $DIRS --replace-fail \
      '# The one instance of an AbstractDirs descendant class' \
      'class NixDirs(GlobalDirs):
      """Global install for Nix store paths"""

      PREFIX = Path("/")

      @property
      def prefix(self):
          return Path(sys.argv[0]).resolve().parent.parent

      @property
      def udev_rulesdir(self):
          return self.prefix / "lib/udev/rules.d"

      def _AbstractDirs__detect(self):
          pass


    # The one instance of an AbstractDirs descendant class'

    # 2. Prefer NixDirs in the detection loop.
    substituteInPlace $DIRS --replace-fail \
      'for cls in [UsrLocalDirs, UsrDirs, HomeDirs]:' \
      'for cls in [NixDirs, UsrLocalDirs, UsrDirs, HomeDirs]:'

    substituteInPlace $out/lib/python${python3Packages.python.pythonVersion}/site-packages/socranop/installtool.py \
      --replace-fail 'raise ValueError("No USB devices found")' 'pass'

    # 3. Now the installtool will actually run.
    $out/bin/socranop-installtool --post-install --no-launch

    mkdir -p $udev/lib/udev/rules.d
    cp $out/lib/udev/rules.d/70-socranop.rules $udev/lib/udev/rules.d/
  '';

  outputs = [ "out" "udev" ];

  postFixup = ''
    rm -f $out/bin/socranop-installtool
  '';

  meta = with lib; {
    description = "Soundcraft Notepad mixer control utilities for Linux";
    homepage = "https://github.com/socratools/socranop";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
