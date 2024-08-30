#!/bin/bash

#############
#Author: Arunadevi
#Date: 2024/08/30
#Version : v1
#About: Lsit the user access in particular repository
################

helper()  # checking the users are passing the arguments correctly first and then execute the below comments

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token take the values from teminal
USERNAME=$username
TOKEN=$token

# User and Repository information using command line arguments we will use that in command
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository if we remove jq output will be injson format
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}
function helper {
 expected_cmd_args =2
 if [$# -ne $expected_cmd_args]; then
 echo " please eexecute thescript with reuired one args"
 echo"asd"
 }
# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
