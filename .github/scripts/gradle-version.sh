#!/usr/bin/env bash
# Single source for the Gradle version used by every job in this repository's CI.
#
# gradle-wrapper.properties is the source of truth because that is the file Dependabot
# bumps. Hard-coding the version in a workflow would make those bumps a no-op: setup-gradle
# would install the old version and the wrapper regeneration would rewrite the properties
# file back, so CI would go green without ever building against the new Gradle.
#
# Writes `version=<x>` to $GITHUB_OUTPUT. Validation rejects shell metacharacters, which
# matters because on a pull request from a fork the properties file is attacker-controlled.
set -euo pipefail

distribution_url=$(sed -n 's/^distributionUrl=//p' gradle/wrapper/gradle-wrapper.properties | head -n 1 | tr -d '\r')
version=${distribution_url##*gradle-}
version=${version%-bin.zip}
version=${version%-all.zip}

if [[ "$distribution_url" != *-bin.zip && "$distribution_url" != *-all.zip ]] || \
  [ "$version" = "$distribution_url" ] || [[ ! "$version" =~ ^[0-9][A-Za-z0-9.-]*$ ]]; then
  echo "::error::could not parse a Gradle version out of gradle-wrapper.properties"
  exit 1
fi

echo "version=$version" >> "$GITHUB_OUTPUT"
