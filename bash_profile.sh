#!/bin/bash

function treepy {
    local path="${1:-.}"
    local depth="${2:-2}"
    local include_regex="${3:-}"
    local exclude_regex="${4:-}"
    local folder_only="${5:-false}"

    function print_tree {
        local current_path="$1"
        local current_depth="$2"
        local prefix="$3"

        if (( current_depth <= 0 )); then
            return
        fi

        local items=()
        while IFS= read -r -d $'\0' item; do
            items+=("$item")
        done < <(find "$current_path" -mindepth 1 -maxdepth 1 -print0)

        local count=${#items[@]}
        for (( i=0; i<count; i++ )); do
            local item="${items[$i]}"
            local item_name=$(basename "$item")
            local is_last=$(( i == count - 1 ))
            local connector="├──"

            if (( is_last )); then
                connector="└──"
            fi

            if [[ "$folder_only" == "true" && ! -d "$item" ]]; then
                continue
            fi

            if [[ -n "$include_regex" && ! "$item_name" =~ $include_regex ]]; then
                continue
            fi

            if [[ -n "$exclude_regex" && "$item_name" =~ $exclude_regex ]]; then
                continue
            fi

            echo "$prefix$connector $item_name"

            if [[ -d "$item" ]]; then
                local new_prefix="$prefix│   "
                if (( is_last )); then
                    new_prefix="$prefix    "
                fi
                print_tree "$item" $((current_depth - 1)) "$new_prefix"
            fi
        done
    }

    echo "$path"
    print_tree "$path" "$depth" ""
}

