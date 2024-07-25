#!/bin/bash
echo -e "${GREEN}Docker Cleaner ${NC}"

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

# Logging: Can be removed if not needed: Logs output into a file
log_file="docker_cleanup.log"
echo "Docker Cleaning Script - $(date)" > $log_file

# Stop all running Containers
echo -e "${GREEN}Stopping all running containers...${NC}"
sudo docker stop $(sudo docker ps -aq) &>> $log_file

# Remove all containers
echo -e "${GREEN}Removing all containers...${NC}"
sudo docker rm $(sudo docker ps -aq) &>> $log_file

# Remove all images
echo -e "${GREEN}Removing all images...${NC}"
sudo docker rmi $(sudo docker images -q) &>> $log_file

# Remove all volumes
echo -e "${GREEN}Removing all volumes...${NC}"
sudo docker volume rm $(sudo docker volume ls -q) &>> $log_file

# Remove all networks
echo -e "${GREEN}Removing all networks...${NC}"
sudo docker network rm $(sudo docker network ls -q) &>> $log_file
echo -e "${YELLOW}Cleanup completed.${NC}"
