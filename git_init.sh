# This script initialises a git repository from a local directory.
# Before running this script:
#	- Create a remote git repository;
#	- Do not initialise this repository with a README;
#	- Navigate to the local directory you'd like to connect to your remote git repository.
# Give the desired reposity name as the first positional parameter.
# To run this script:
#	- Give the name of the git user housing the repository with the -u flag;
# - Give the name of the remote git repository with the -n flag.
#
#!/bin/bash
DIR=$(pwd)
while getopts "u:n:" OPTION;
do
  case $OPTION in
  u) USER=$OPTARG ;;
  n) REPO=$OPTARG ;;
  *) echo "error" >$2
    exit 1
  esac
done

if [ "$USER" == "" ]; 
then
  echo "Git username missing. Please specify with the -u flag." >&2
  exit 1
fi

if [ "$REPO" == "" ]; 
then
  echo "Remote git repository name missing. Please specify with the -n flag." >&2
  exit 1
fi

echo "Initialising a git repository from an existing directory.
Directory = $DIR
Git user = $USER
Reposity name =  $REPO"
git init
git add .
git commit
git remote add origin git@github.com:$USER/$REPO
git push -u origin master

