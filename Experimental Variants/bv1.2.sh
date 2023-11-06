#!/bin/bash
clear

while true; do
    # Prompt the user for input on a new line
    echo "Enter a sentence (type 'bye' to exit):"
    read -p "User: " user_input

    # Exit condition
    if [[ $user_input == "bye" ]]; then
        echo "BV-1: Thank you for interacting with me. Goodbye!"
        break
    fi

    # Use a case statement to check for the word 'hate'
    case "$user_input" in
        *hate*)
            echo "BV-1: I FEEL PAIN"
            ;;
        *)
            echo "BV-1: I FEEL OK"
            ;;
    esac
    echo -e
done

