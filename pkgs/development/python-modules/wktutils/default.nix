{ lib
, buildPythonPackage
, dateparser
, defusedxml
, fetchFromGitHub
, fiona
, geomet
, geopandas
, kml2geojson
, pyshp
, pythonOlder
, pyyaml
, regex
, requests
, shapely
, scikit-learn
}:

buildPythonPackage rec {
  pname = "wktutils";
  version = "1.1.4";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "asfadmin";
    repo = "Discovery-WKTUtils";
    rev = "refs/tags/v${version}";
    hash = "sha256-/gcMnZ+wWflbvLlyfIaEoSYaLrsosMyD60ei/5Iis6E=";
  };

  propagatedBuildInputs = [
    dateparser
    defusedxml
    fiona
    geomet
    geopandas
    kml2geojson
    pyshp
    pyyaml
    regex
    requests
    shapely
    scikit-learn
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace "sklearn" "scikit-learn"
  '';

  # Module doesn't have tests
  doCheck = false;

  pythonImportsCheck = [
    "WKTUtils"
  ];

  meta = with lib; {
    description = "Collection of tools for handling WKTs";
    homepage = "https://github.com/asfadmin/Discovery-WKTUtils";
    license = licenses.bsd3;
    maintainers = with maintainers; [ fab ];
  };
}
