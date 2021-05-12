#!/bin/bash

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

set -o pipefail

# Get the last commit message - change to all lower case
CMT_MSG=$(git log --oneline --format=%B -n 1 HEAD | head -n 1 | tr '[:upper:]' '[:lower:]')

echo -e "\n## Commit msg: $CMT_MSG"
CMT_MSG_LOWER=$(echo "$CMT_MSG" | tr '[:upper:]' '[:lower:]')

case $CMT_MSG_LOWER in 
  *patch*) 
    CMT_TYPE="patch"
    echo -e "\n## Found fix in commit msg. Setting commit type to patch\n"
    ;;
  *minor*)
    CMT_TYPE="minor"
    echo -e "\n## Found minor in commit msg. Setting commit type to minor\n"
    ;;
  *major*)
    CMT_TYPE="major"
    echo -e "\n## Found major in commit msg. Setting commit type to major\n"
    ;;
  *fix*)
    CMT_TYPE="patch"
    echo -e "\n## Found patch in commit msg. Setting commit type to patch\n"
    ;;
  *feat*)
    CMT_TYPE="minor"
    echo -e "\n## Found feat in commit msg. Setting commit type to minor\n"
    ;;
  *break*)
    CMT_TYPE="major"
    echo -e "\n## Found break in commit msg. Setting commit type to major\n"
    ;;
  *)
    CMT_TYPE="minor"
    echo -e "\n## No commit type found in commit msg. Setting commit type to minor\n"
    ;;
esac

UPDATE_CMT_MSG=${CMT_MSG//"$CMT_TYPE"/}

# Run Semver
echo -e "\n## Running semversioner\n"
previous_version=$(semversioner current-version)
echo "Current version: v$previous_version"
if [[ $previous_version == "0.0.0" ]]; then
  echo -e "\n## First version must be at least minor version"
  echo -e "\n## Resetting commit type to minor\n"
  CMT_TYPE="minor"
fi

semversioner add-change --type $CMT_TYPE --description "$UPDATE_CMT_MSG"

semversioner release

new_version=$(semversioner current-version)
echo "New version: v$new_version"

echo "Generating CHANGELOG.md file..."
semversioner changelog > CHANGELOG.md

# Use new version in the README.md examples
echo "Replace version 'v$previous_version' to 'v$new_version' in README.md ..."
sed -i "s/v$previous_version/v$new_version/g" README.md

# Git config
git config user.email "${GIT_EMAIL}"
git config user.name "CircleCI Job"
git checkout master

# Commit
git add .semversioner/*.json
git add .semversioner/next-release/*.json
git add README.md
git add CHANGELOG.md


echo -e "\nGit status before commit"
git status

git commit -m "Update files for new version 'v${new_version}' [skip ci]"
git push origin master

echo -e "\nGit status after commit and push"
git status

# Tag
echo "Add version tag ${new_version} to repo"
git tag -a -m "Tagging for release v${new_version}" "v${new_version}"
git push origin "v${new_version}"