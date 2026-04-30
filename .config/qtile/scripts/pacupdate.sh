#!/bin/bash

#!/bin/bash

updates() {
    if ! apt_updates=$(sudo apt-get update && apt list --upgradable 2>/dev/null | grep -c /); then
        apt_updates=0
    fi

    available=$apt_updates
    

    if [ "$available" -eq 0 ]; then
        echo "  0"
    else
        echo "  $available"
    fi
}

echo "$(updates)"

