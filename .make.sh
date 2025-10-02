#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
ignore_files=". .. .git .make.sh README.md .DS_Store"           # list of files/folders to ignore, and not symlink

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# getting all the dotfiles
files=$(ls -a)

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo ""
    # check to see if this file is in the list of files to ignore
    ignore=false
    for ignore_file in $ignore_files; do
      if [ "$file" == "$ignore_file" ]; then
        ignore=true
        break
      fi
    done
    if $ignore ; then
      echo "Ignoring file: $file"
      continue
    fi

    echo "Moving any existing $file from ~ to $olddir"
    mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done