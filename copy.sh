# simple utility script to backup current config and copy project into ~/.config/nvim


# backup
if [[ -e ~/.config/nvim ]]; then
    mv ~/.config/nvim ~/.config/nvim.bak
fi

# move
cp -R . ~/.config/nvim/
