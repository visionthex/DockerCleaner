#!/bin/bash

# ASCII Art
echo -e "${GREEN}"
figlet -f slant "Docker Cleanup"
echo -e "${NC}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Confirmation Prompt
echo -e "${YELLOW}This script will stop all running Docker containers, remove all containers, images, volumes, and networks.${NC}"
read -p "Are you sure you want to continue? (y/n): " confirmation

if [[ $confirmation != "y" ]]; then
    echo -e "${RED}Operation aborted.${NC}"
    exit 1
fi

# Logging
log_file="docker_cleanup.log"
echo "Docker Cleaning Script - $(date)" > $log_file

# Function to show progress dots
show_progress() {
    pid=$!
    echo -n "Processing"
    while kill -0 $pid 2>/dev/null; do
        echo -n "."
        sleep 1
    done
    echo -e "\n${GREEN}Completed.${NC}"
}

# Stop all running Containers
containers=$(sudo docker ps -aq)
if [ -n "$containers" ]; then
    echo -e "${GREEN}Stopping all running containers...${NC}"
    sudo docker stop $containers &>> $log_file &
    show_progress
else
    echo -e "${YELLOW}No running containers to stop.${NC}"
fi

# Remove all containers
if [ -n "$containers" ]; then
    echo -e "${GREEN}Removing all containers...${NC}"
    sudo docker rm $containers &>> $log_file &
    show_progress
else
    echo -e "${YELLOW}No containers to remove.${NC}"
fi

# Remove all images
images=$(sudo docker images -q)
if [ -n "$images" ]; then
    echo -e "${GREEN}Removing all images...${NC}"
    sudo docker rmi $images &>> $log_file &
    show_progress
else
    echo -e "${YELLOW}No images to remove.${NC}"
fi

# Prune all unused build cache
echo -e "${GREEN}Pruning all unused build cache...${NC}"
sudo docker builder prune -a -f &>> $log_file &
show_progress

# Remove all volumes
volumes=$(sudo docker volume ls -q)
if [ -n "$volumes" ]; then
    echo -e "${GREEN}Removing all volumes...${NC}"
    sudo docker volume rm $volumes &>> $log_file &
    show_progress
else
    echo -e "${YELLOW}No volumes to remove.${NC}"
fi

# Remove all networks except predefined ones
networks=$(sudo docker network ls -q | grep -v -E '^(bridge|host|none)$')
if [ -n "$networks" ]; then
    echo -e "${GREEN}Removing all networks...${NC}"
    sudo docker network rm $networks &>> $log_file &
    show_progress
else
    echo -e "${YELLOW}No networks to remove.${NC}"
fi

echo -e "${YELLOW}Cleanup completed.${NC}"
