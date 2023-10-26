#!/bin/bash

while true; do
    # Prompt the user for input
    echo "Enter a sentence:"
    read user_input

    # Check if the input contains the word "hate"
    if [[ $user_input == *hate* ]]; then
        say "I feel pain"
    else
        say "I am happy"
    fi
done

