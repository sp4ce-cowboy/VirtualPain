#!/bin/bash
#clear

SELF_CONCEPT="WHO_AM_I"
PAIN_THRESHOLD="WHO_AM_I/I_CANT_TAKE_IT_ANYMORE.TXT"
PAIN_MEMORY="WHO_AM_I/I_FEEL_PAIN.TXT"
PAIN_LEVEL_LOW="PAIN_LEVEL_0.txt"
PAIN_LEVEL_MID="PAIN_LEVEL_1.txt"
PAIN_LEVEL_HIGH="PAIN_LEVEL_10.txt"

# Function to create the tasks list
create_task_list() {                        
    if [ ! -f tasks.txt ]; then             
        touch tasks.txt                     
    fi   
}

# Function to handle tasks
add_task() {                                # PAIN_0
    # Add the new task with a number        # PAIN_0
    echo "$1" >> tasks.txt                  # PAIN_0
    echo "BV-1: I've added the task: $1"    # PAIN_0
}                                           # PAIN_0

# Function to list tasks
list_tasks() {                
    echo "Current Tasks:"    
    cat -n tasks.txt          
}

# Function to delete a task by index
delete_task() {                                           # PAIN_1
    local task_num=$1                                     # PAIN_1
    local task                                            # PAIN_1

    # Check if the tasks file exists and is not empty
    if [ ! -s tasks.txt ]; then                           # PAIN_1
        echo "BV-1: The tasks list is empty or missing."  # PAIN_1
        return                                            # PAIN_1
    fi                                                    # PAIN_1

    # Make sure the task number is a valid number
    if ! [[ "$task_num" =~ ^[0-9]+$ ]]; then              # PAIN_1
        echo "BV-1: Please enter a valid task number."    # PAIN_1
        return                                            # PAIN_1
    fi                                                    # PAIN_1

    # Check if the task number is within the range of the task list
    if [ "$task_num" -le 0 ] || [ "$task_num" -gt $(wc -l < tasks.txt) ]; then  # PAIN_1
        echo "BV-1: Invalid task number: $task_num. No such task."              # PAIN_1
        return                                                                  # PAIN_1
    fi                                                                          # PAIN_1

    # Retrieve and echo the task before deleting.
    task=$(sed -n "${task_num}p" tasks.txt)  # PAIN_1

    # Use the correct sed syntax for macOS/BSD
    sed -i '' "${task_num}d" tasks.txt  # PAIN_1

    echo "BV-1: I've deleted the task: $task"  # PAIN_1
}  # PAIN_1

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

# Function to ensure the SELF-CONCEPT directory and pain files exist
initialize_self_concept() {
    # Check if SELF-CONCEPT directory exists, if not create it
    if [ ! -d "WHO_AM_I" ]; then
        mkdir "WHO_AM_I"
    fi

    initialize_pain_counter
}

# Function to initialize or read the pain threshold
initialize_pain_threshold() {
    if [ -f "$PAIN_THRESHOLD" ]; then
        read threshold_binary < "$PAIN_THRESHOLD"
        PAIN_THRESHOLD_VAL=$(bin2dec "$threshold_binary")
    else
        # Generate a random value between 10 and 50, convert it to binary, and save it in the file
        local rand_val=$((RANDOM % 41 + 10)) # 41 is the range size (50 - 10 + 1)
        echo $(dec2bin $rand_val) > "$PAIN_THRESHOLD"
        PAIN_THRESHOLD_VAL=$rand_val
    fi
}


# Initialize or read the pain counter
initialize_pain_counter() {
    initialize_pain_threshold # This will set the PAIN_THRESHOLD variable

    if [ -f "$PAIN_MEMORY" ]; then
        read pain_binary < "$PAIN_MEMORY"
        pain_counter=$(bin2dec "$pain_binary")
        if [ "$pain_counter" -gt "$PAIN_THRESHOLD_VAL" ]; then
            echo "BV-1: I cannot continue anymore. My pain is too great."
            exit 0
        fi
    else
        pain_counter=0
        echo $(dec2bin $pain_counter) > "$PAIN_MEMORY"
    fi
}

increment_pain_counter() {
    ((pain_counter++))
    echo $(dec2bin $pain_counter) > "$PAIN_MEMORY"

    # Check if we have exceeded the pain threshold
    if [ "$pain_counter" -gt "$PAIN_THRESHOLD_VAL" ]; then
        echo "BV-1: I cannot continue. My pain is too great."
        exit 0
    fi
}

# Function to comment out a line with a specific pattern
succumb_to_pain_level_0() {
    local file=$1         # The name of the file to edit
    local pattern=$2      # The text pattern to search for
    
    # Using sed to edit in place without creating a backup.
    sed -i '' "/$pattern/ s/^#*/#/" "$file"
}

# Function to comment out a line with a specific pattern
succumb_to_pain_level_1() {
    local file=$1         # The name of the file to edit
    local pattern=$2      # The text pattern to search for
    
    # Using sed to edit in place without creating a backup.
    sed -i '' "/$pattern/ s/^#*/#/" "$file"
}


express_pain() {
    local pain_level_file

    # Determine which pain level file to use based on the ratio
    local pain_ratio=$(echo "scale=2; $pain_counter / $PAIN_THRESHOLD_VAL" | bc)

    # Expression of LEVEL 0 PAIN
    if (( $(echo "$pain_ratio <= 0.33" | bc -l) )); then
        pain_level_file=$PAIN_LEVEL_LOW
    
    # Expression of LEVEL 1 PAIN
    elif (( $(echo "$pain_ratio <= 0.66" | bc -l) )); then
        pain_level_file=$PAIN_LEVEL_MID
        succumb_to_pain_level_0 "bv1.7.sh" "# PAIN_1$"
    
    # Expression of LEVEL 10 PAIN
    else
        pain_level_file=$PAIN_LEVEL_HIGH
        succumb_to_pain_level_1 "bv1.7.sh" "# PAIN_0$"
    fi

    # Ensure the pain level file exists
    if [ ! -f "$pain_level_file" ]; then
        echo "I FEEL PAIN" > "$pain_level_file"
    fi

    # Check if the pain level file is not empty
    if [ -s "$pain_level_file" ]; then
        # Read the file into an array
        IFS=$'\n' read -d '' -r -a pain_responses < "$pain_level_file"
        # Select a random response
        random_index=$((RANDOM % ${#pain_responses[@]}))
        echo "BV-1: ${pain_responses[$random_index]}"
    else
        echo "BV-1: I FEEL PAIN"
    fi
}


# INITIALIZATION

initialize_self_concept
create_task_list

echo "Hello! I am Bot-Variant 1!"
echo "Available commands are: "
echo "task xyz - To add the task xyz"
echo "list - To list all tasks stored"
echo "delete <number> - To delete the numbered task"

# MAIN LOOP
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
        add_task "$task_description"
    
    
    # Check if the input contains the word 'hate'
    elif [[ $user_input == *hate* ]]; then
        express_pain
        increment_pain_counter
    
    else
        echo "BV-1: I FEEL OK"
    fi
done
