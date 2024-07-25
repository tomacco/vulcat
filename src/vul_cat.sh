#!/bin/bash

# VulCat: Your fluffy friend that looks for transitive dependencies.

cat << "EOF"
 /\_/\  
( o.o ) > "Let's track down those transitive dependencies!"
 > ^ <
EOF

print_banner() {
    local header=$1
    local banner_width=60
    local padding_length=$(( (banner_width - ${#header}) / 2 ))
    local padding=$(printf '%*s' $padding_length)
    printf '%*s\n' "$banner_width" '' | tr ' ' '-'
    printf '%s%s%s\n' "$padding" "$header" "$padding"
    if [ $(( (padding_length * 2 + header_length) % 2 )) -ne 0 ]; then
        printf ' '
    fi
    printf '%*s\n' "$banner_width" '' | tr ' ' '-'
}

# Function to run dependencyInsight on an array of configurations
run_dependency_insight() {
    local configurations=("$@")
    local dependency=$1
    for config in "${configurations[@]}"; do
        print_banner $config
        ./gradlew dependencyInsight --configuration $config --dependency $dependency
        echo "------------------------------------------------"
    done
}

# Main logic of the script
if [ "$1" == "--allConfigs" ]; then
    shift
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 --allConfigs <dependency-name>"
        exit 1
    fi
    DEPENDENCY=$1
    CONFIGURATIONS=($(./gradlew --console plain dependencies | grep ' - ' | cut -d ' ' -f1))
    run_dependency_insight "$DEPENDENCY" "${CONFIGURATIONS[@]}"
else
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <dependency-name>"
        echo "Or for all configurations: $0 --allConfigs <dependency-name>"
        exit 1
    fi
    DEPENDENCY=$1
    CONFIGURATIONS=("testCompileClasspath" "compileClasspath")
    run_dependency_insight "$DEPENDENCY" "${CONFIGURATIONS[@]}"
fi

cat << "EOF"
 /\_/\  
( -.o ) > "Finished! I hope you have found what you were looking for"
 > ^ <
EOF

