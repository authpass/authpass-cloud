#!/bin/bash

set -xeu

cd "${0%/*}"/..

cd packages/authpass_cloud_backend

pub get

pub global activate test_coverage

fail=false
pub global run test_coverage || fail=true
echo "fail=$fail"
bash <(curl -s https://codecov.io/bash) -f coverage/lcov.info

test "$fail" == "true" && exit 1

echo "Success 🎉️"

exit 0

