{ lib
, bleak
, bleak-retry-connector
, boto3
, buildPythonPackage
, cryptography
, fetchFromGitHub
, pythonOlder
, pytestCheckHook
, requests
}:

buildPythonPackage rec {
  pname = "pyswitchbot";
  version = "0.36.2";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "Danielhiversen";
    repo = "pySwitchbot";
    rev = "refs/tags/${version}";
    hash = "sha256-I+OnxSQ/984aoloe/1673JDaVzG6yKOSrDvGuupAnkc=";
  };

  propagatedBuildInputs = [
    bleak
    bleak-retry-connector
    boto3
    cryptography
    requests
  ];

  checkInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    # mismatch in expected data structure
    "test_parse_advertisement_data_curtain"
  ];

  pythonImportsCheck = [
    "switchbot"
  ];

  meta = with lib; {
    description = "Python library to control Switchbot IoT devices";
    homepage = "https://github.com/Danielhiversen/pySwitchbot";
    changelog = "https://github.com/Danielhiversen/pySwitchbot/releases/tag/${version}";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
    platforms = platforms.linux;
  };
}
