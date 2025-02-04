#!/usr/bin/env bash
#!nix-shell -i bash -p jq curl
# Description: This script is used to display the current WaniKani review count in the tmux status bar.

# curl -s -H "Authorization: Bearer 2da24e4a-ba89-4c4a-9047-d08f21e9dd01" "https://api.wanikani.com/v2/assignments?immediately_available_for_review=true" | jq '.total_count'

# lets store the output of the above command in a variable

get_wanikani()
{
    wanikani_reviews=$(curl -s -H "Authorization: Bearer 2da24e4a-ba89-4c4a-9047-d08f21e9dd01" "https://api.wanikani.com/v2/assignments?immediately_available_for_review=true" | jq '.total_count')
    wanikani_lessons=$(curl -s -H "Authorization: Bearer 2da24e4a-ba89-4c4a-9047-d08f21e9dd01" "https://api.wanikani.com/v2/assignments?immediately_available_for_lessons=true" | jq '.total_count')

    echo "WaniKani: $wanikani_reviews reviews, $wanikani_lessons lessons"
}

main()
{
    get_wanikani
    # sleep for 30 minutes
    sleep 1800
}

main