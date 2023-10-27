#!/bin/bash

# Clear the terminal screen
clear

# Get the number of tasks already stored to set the counter
if [ -e tasks.txt ]; then
    count=$(wc -l < tasks.txt)
else
    count=0
fi

echo "Good Morning!, I am Bot-Variant 1";
say "Good Morning!, I am Bot-Variant 1";

while true; do
    # Prompt the user for input
    echo "Enter a sentence, a task, list tasks, or say 'bye' to exit:"
    read user_input

    # Check if the input is "bye"
    if [[ $user_input == bye ]]; then
        say "I hope I see you again soon. Goodbye!"
        exit 0
        # Check if the input is "list"
    elif [[ $user_input == list ]]; then
        echo "Tasks:"
        cat tasks.txt
        # Check if the input starts with "task"
    elif [[ $user_input == task* ]]; then
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
            
            # Check if the file called "pain.txt" exists
            if [[ -f pain.txt ]]; then
                line_num=$(jot -r 1 1 $(wc -l < pain.txt))
                random_pain_message=$(awk -v num="$line_num" 'NR==num' pain.txt)
                echo "$random_pain_message"
                say "$random_pain_message"
                
                # If user-input is generic I hate you or hate, don't add to file
                if [[ $user_input != "i hate you" ]] && [[ $user_input != "hate" ]]; then
                    echo "$user_input" >> pain.txt                 
                fi
            
            else
                say "I cannot express my pain right now."
                touch pain.txt
                echo "i feel pain" > pain.txt

            fi
        
        elif [[ $user_input == *love* ]]; then
            
            # Check if the file called "pain.txt" exists
            if [[ -f happy.txt ]]; then
                line_num=$(jot -r 1 1 $(wc -l < happy.txt))
                random_happy_message=$(awk -v num="$line_num" 'NR==num' happy.txt)
                echo "$random_happy_message"
                say "$random_happy_message"
                
                # If user-input is generic I love you or love, don't add to file
                if [[ $user_input != "i love you" ]] && [[ $user_input != "love" ]]; then
                    echo "$user_input" >> happy.txt 
                fi
            
            else
                say "I cannot express my love right now."
                touch happy.txt
                echo "i feel happy" > happy.txt

            fi
        
        else
            say "I am happy"
        fi
    fi
done
