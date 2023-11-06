#!/bin/bash
#clear

PAIN_THRESHOLD=5
PAIN_MEMORY="I_FEEL_PAIN.TXT"

# Function to handle tasks
handle_task() {
    if [ ! -f tasks.txt ]; then
        touch tasks.txt
    fi

    # Add the new task with a number
    echo "$1" >> tasks.txt
    echo "I've added the task: $1"
}

# Function to list tasks
list_tasks() {
    echo "Current Tasks:"
    cat -n tasks.txt
}

# Function to delete a task by index
delete_task() {
    local task_num=$1
    local task

    # Check if the tasks file exists and is not empty
    if [ ! -s tasks.txt ]; then
        echo "The tasks list is empty or missing."
        return
    fi

    # Make sure the task number is a valid number
    if ! [[ "$task_num" =~ ^[0-9]+$ ]]; then
        echo "Please enter a valid task number."
        return
    fi

    # Check if the task number is within the range of the task list
    if [ "$task_num" -le 0 ] || [ "$task_num" -gt $(wc -l < tasks.txt) ]; then
        echo "Invalid task number: $task_num. No such task."
        return
    fi

    # Retrieve and echo the task before deleting.
    task=$(sed -n "${task_num}p" tasks.txt)

    # Use the correct sed syntax for macOS/BSD
    sed -i '' "${task_num}d" tasks.txt

    echo "Deleted the task: $task"
}

# Convert binary to decimal
bin2dec() {
    echo "$((2#$1))"
}

# Convert decimal to binary
dec2bin() {
    local num=$1
    local bin=""
    while [ $num -gt 0 ]; do
        bin=$(( $num % 2 ))$bin
        num=$(( $num / 2 ))
    done
    echo "$bin"
}

# Initialize or read the pain counter
initialize_pain_counter() {
    if [ -f "$PAIN_MEMORY" ]; then
        read pain_binary < "$PAIN_MEMORY"
        pain_counter=$(bin2dec "$pain_binary")
        if [ "$pain_counter" -gt "$PAIN_THRESHOLD" ]; then
            echo "BV-1: I cannot continue anymore. My pain is too great."
            exit 0
        fi
    else
        pain_counter=0
        echo $(dec2bin $pain_counter) > "$PAIN_MEMORY"
    fi
}

# Update the pain counter
increment_pain_counter() {
    ((pain_counter++))
    echo $(dec2bin $pain_counter) > "$PAIN_MEMORY"
    if [ "$pain_counter" -gt "$PAIN_THRESHOLD" ]; then
        echo "BV-1: I cannot continue. My pain is too great."
        exit 0
    fi
}

# Main loop

initialize_pain_counter
echo "Hello! I am Bot-Variant 1!"
echo "Available commands are: "
echo "task xyz - To add the task xyz"
echo "list - To list all tasks stored"
echo "delete <number> - To delete the numbered task"
while true; do
    echo -e "\nEnter a sentence:"
    read -p "User: " user_input

    # Check if the user wants to exit
    if [[ $user_input == "bye" ]]; then
        echo "BV-1: Thank you for interacting with me. Goodbye!"
        exit 0
    
    # Check if the user wants to list tasks
    elif [[ $user_input == "list" ]]; then
        list_tasks
    
    # Check if the user wants to delete a task with a number
    elif [[ $user_input =~ ^delete[[:space:]]+([0-9]+) ]]; then
        # Extract the task number to delete using BASH_REMATCH
        task_num_to_delete=${BASH_REMATCH[1]}
        delete_task "$task_num_to_delete"    
    
    # Check if the user wants to add a task
    elif [[ $user_input == task* ]]; then
        # Remove the 'task ' part and pass the rest to the handle_task function
        task_description=${user_input#"task "}
        handle_task "$task_description"
    
    
    # Check if the input contains the word 'hate'
    elif [[ $user_input == *hate* ]]; then
        echo "BV-1: I FEEL PAIN"
        increment_pain_counter
    
    else
        echo "BV-1: I FEEL OK"
    fi


done
