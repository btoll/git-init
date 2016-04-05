#!/bin/bash

EXIT_CODE=0
FILES=$(git diff-index --cached --name-only HEAD 2> /dev/null | ag ".js\b")

echo "$(tput setab 7)$(tput setaf 4)[INFO]$(tput sgr0) Running $(tput bold)ESLint$(tput sgr0) pre-commit hook..."

for F in $FILES; do
    eslint "$F"

    if [ "$?" == 1 ]; then
        # Note that eslint's error messages are verbose enough that we don't need to have our own.
        EXIT_CODE=1
    fi
done

if [ "$EXIT_CODE" -eq 0 ]; then
    echo "$(tput setab 7)$(tput setaf 2)[INFO]$(tput sgr0) Completed successfully."
fi

exit $EXIT_CODE

