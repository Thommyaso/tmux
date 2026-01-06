REPO_DIR="/home/thomas/devilbox/data/www" # Path to directory that holds all repositories 
DOCKER_DIR="/home/thomas/devilbox" # Docker configuration directory (devilbox in this example)
START_DOCKER="./up.sh" # Script that starts docker -- LOCATION OF THIS SCRIPT HAS TO BE WITHIN DOCKER_DIR!!(adjust in open-project.sh if needed)

SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")") # DON'T CHANGE -- PATHS CHECKS FOR THIS PROJECTS' LOCATION TO CORRECTLY EXECUTE SCRIPTS
