#!/bin/bash

# Clear the screen
clear;
# Get the number of tasks already stored to set the counter
if [ -e tasks.txt ]; then
    count=$(wc -l < tasks.txt)
else
    count=0
fi

while true; do
    # Prompt the user for input
    echo "Enter a sentence or a task:"
    read user_input

    # Check if the input starts with "task"
    if [[ $user_input == task* ]]; then
        # Increment the task counter
        ((count++))

        # Extract the task from the input
        task_content="${user_input#task }"

        # Add the task to tasks.txt
        echo "$count. $task_content" >> tasks.txt

        # Notify the user
        say "I've added the task $task_content"
    else
        # Check if the input contains the word "hate"
        if [[ $user_input == *hate* ]]; then
            say "I feel pain"
        else
            say "I am happy"
        fi
    fi
done

