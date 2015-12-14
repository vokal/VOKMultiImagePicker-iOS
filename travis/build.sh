#!/bin/bash

# Set up default arguments for xctool
echo "[" > .xctool-args
if [ -n "$XC_PROJECT" ]; then echo '"-project", "'"$XC_PROJECT"'",' >> .xctool-args; fi
if [ -n "$XC_WORKSPACE" ]; then echo '"-workspace", "'"$XC_WORKSPACE"'",' >> .xctool-args; fi
echo '"-sdk", "'"iphonesimulator$SDK_VERSION"'"' >> .xctool-args
echo "]" >> .xctool-args

# Unsigned build, suitable only for testing in the simulator, using the main scheme.
echo "======== TESTING WITH MAIN SCHEME ========"
xctool CONFIGURATION_BUILD_DIR='~/build/' -scheme "$XC_SCHEME" test
if [ "$?" -ne 0 ]; then
    exit 1
fi

# Also test the non UI tests scheme if it's not null.
if [ -n "$XC_NON_UI_TEST_SCHEME" ]; then
    echo "======== TESTING WITH NON-UI SCHEME ========"
    xctool CONFIGURATION_BUILD_DIR='~/build/' -scheme "$XC_NON_UI_TEST_SCHEME" test
    if [ "$?" -ne 0 ]; then
        exit 1
    fi
else
    echo "Non UI test scheme not set!"
fi



