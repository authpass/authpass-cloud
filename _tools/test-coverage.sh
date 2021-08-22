#!/bin/bash

set -xeu

cd "${0%/*}"/..

cd packages/authpass_cloud_backend

pub get

pub global activate coverage

fail=false
dart test --coverage coverage || fail=true
echo "fail=$fail"

jq -s '{coverage: [.[].coverage] | flatten}' $(find coverage -name '*.json' | xargs) > coverage/merged_json.cov
pub global run coverage:format_coverage --packages=.packages -i coverage/merged_json.cov -l --report-on lib --report-on test > coverage/lcov.info

bash <(curl -s https://codecov.io/bash) -f coverage/lcov.info

test "$fail" == "true" && exit 1

echo "Success 🎉️"

exit 0

