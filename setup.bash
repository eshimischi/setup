#!/usr/bin/env bash

set -e

dotfiles_dir=`cd "$(dirname "$0")" && pwd`

# Colors
source ${dotfiles_dir}/colors.bash

echo "${YELLOW}Configuring brew...${NC}"
if [[ $OSTYPE =~ darwin ]]; then
    echo "macOS detected"
    if [ -z "`which brew`" ]; then
        echo "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "Homebrew is already installed"
    fi

    echo "Updating brew bundles..."
    brew bundle --file="${dotfiles_dir}/Brewfile"

    brew cleanup
fi

CONFIGS=(
    ".bash_aliases" \
	".bash_functions" \
	".bash_profile" \
    ".editorconfig" \
	".gitignore" \
	".inputrc" \
    ".wgetrc"
)

echo
echo "${YELLOW}Backup configs...${NC}"
for file in ${CONFIGS[@]}; do
	if [ -f ~/$file ]; then
		mkdir -p ~/configs-backup && cp ~/$file ~/configs-backup/$file

		if [ $? -eq 0 ]; then
			echo "~/$file (${GREEN}backuped${NC})"
		fi
	fi
done
unset file

echo
echo "${YELLOW}Configuring git...${NC}"
CURRENT_GIT_USER=`git config --global --get user.name || echo`
CURRENT_GIT_EMAIL=`git config --global --get user.email || echo`
CURRENT_GH_HOST=${GITHUB_HOST:-github.com}

read -p "Enter your full name (${YELLOW}$CURRENT_GIT_USER${NC}): " GIT_USER
read -p "Enter your e-mail (${YELLOW}$CURRENT_GIT_EMAIL${NC}): " GIT_EMAIL
read -p "Enter your GitHub host (${YELLOW}$CURRENT_GH_HOST${NC}): " GH_HOST

GIT_USER=${GIT_USER:-$CURRENT_GIT_USER}
GIT_EMAIL=${GIT_EMAIL:-$CURRENT_GIT_EMAIL}
GH_HOST=${GH_HOST:-$CURRENT_GH_HOST}

echo
echo "${YELLOW}Copying configs...${NC}"
for file in ${CONFIGS[@]}; do
	cp ${dotfiles_dir}/$file ~/$file

	if [ $? -eq 0 ]; then
		echo "~/$file (${GREEN}copied${NC})"
	fi
done
unset file

cp -f "${dotfiles_dir}/gitconfig.template" "${HOME}/.gitconfig"

git config --global user.name "${GIT_USER}"
git config --global user.email "${GIT_EMAIL}"

echo
echo "${YELLOW}Install some installers...${NC}"
for file in $(ls ~/dotfiles/packages); do
	source "${dotfiles_dir}/packages/$file"
done
unset file

cat >~/.extra <<EOL
export GITHUB_HOST="${GH_HOST}"
EOL

# Reload Bash profile
source ~/.bash_profile

echo
echo "${GREEN}Done. Good job!${NC}"
echo