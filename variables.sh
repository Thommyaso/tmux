REPO_DIR="/home/thomas/devilbox/data/www" # Path to repositories 
DOCKER_DIR="/home/thomas/devilbox/" # Docker configuration directory (devilbox in this example)
START_DOCKER="./up.sh" # Script that starts docker -- LOCATION OF THIS SCRIPT HAS TO BE WITHIN DOCKER_DIR!!(adjust in open-project.sh if needed)
SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")") # Don't change -- paths checks for this projects' location to correctly execute scripts
