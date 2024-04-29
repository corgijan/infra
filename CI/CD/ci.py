
import os
import subprocess
from dataclasses import dataclass

@dataclass
class Project:
    name: str
    path: str
    docker_compose_file: str

# Define projects as instances of the Project class
PROJECTS = [
    Project(
        name="blog",
        path="/root/blog",
        docker_compose_file="compose.yml"
    ),
]

# Function to find the default branch of the Git repository
def find_default_branch(project):
    project_dir = project.path
    os.chdir(project_dir)
    default_branch = subprocess.check_output("git remote show origin | grep 'HEAD branch' | cut -d ':' -f 2", shell=True).decode().strip()
    return default_branch

# Function to check if remote has changed for a project
def check_remote_changes(project):
    project_dir = project.path
    os.chdir(project_dir)
    default_branch = find_default_branch(project)
    subprocess.run(f"git fetch origin", shell=True)
    local_hash = subprocess.check_output("git rev-parse HEAD", shell=True).strip()
    remote_hash = subprocess.check_output(f"git rev-parse origin/{default_branch}", shell=True).strip()
    if local_hash != remote_hash:
        print(f"Remote has changes for {project.name}. Updating...")
        subprocess.run(f"git pull origin {default_branch}", shell=True)
        return True
    else:
        print(f"No changes in remote for {project.name}.")
        return False

# Function to restart Docker Compose services
def restart_docker_compose(project):
    docker_compose_file = project.path + "/" + project.docker_compose_file
    print(f"Restarting Docker Compose services for {project.name}...")
    subprocess.run(f"docker-compose -f {docker_compose_file} restart", shell=True)

# Main
for project in PROJECTS:
    if check_remote_changes(project):
        restart_docker_compose(project)
