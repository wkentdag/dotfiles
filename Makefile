backup:
	# -e misses dangling symlinks; -L catches those (from a moved repo path).
	if [ -e ~/.profile ] || [ -L ~/.profile ]; then mv ~/.profile ~/.profile.bak; fi
	if [ -e ~/.bash_profile ] || [ -L ~/.bash_profile ]; then mv ~/.bash_profile ~/.bash_profile.bak; fi
	if [ -e ~/.bashrc ] || [ -L ~/.bashrc ]; then mv ~/.bashrc ~/.bashrc.bak; fi
	if [ -e ~/.git-completion.sh ] || [ -L ~/.git-completion.sh ]; then mv ~/.git-completion.sh ~/.git-completion.sh.bak; fi
	if [ -e ~/.git-prompt.sh ] || [ -L ~/.git-prompt.sh ]; then mv ~/.git-prompt.sh ~/.git-prompt.sh.bak; fi
	if [ -e ~/.hushlogin ] || [ -L ~/.hushlogin ]; then mv ~/.hushlogin ~/.hushlogin.bak; fi
	if [ -e ~/.vimrc ] || [ -L ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc.bak; fi
	if [ -e ~/.vim ] || [ -L ~/.vim ]; then mv ~/.vim ~/.vim.bak; fi
	if [ -e ~/.tmux.conf ] || [ -L ~/.tmux.conf ]; then mv ~/.tmux.conf ~/.tmux.conf.bak; fi
	if [ -e ~/.zshrc ] || [ -L ~/.zshrc ]; then mv ~/.zshrc ~/.zshrc.bak; fi
	if [ -e ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty ] || [ -L ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty ]; then mv ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty.bak; fi
	if [ -e ~/.config/ghostty/config.ghostty ] || [ -L ~/.config/ghostty/config.ghostty ]; then mv ~/.config/ghostty/config.ghostty ~/.config/ghostty/config.ghostty.bak; fi
	if [ -e ~/.config/ghostty/config ] || [ -L ~/.config/ghostty/config ]; then mv ~/.config/ghostty/config ~/.config/ghostty/config.bak; fi

remove_backup:
	if [ -e ~/.profile.bak ] || [ -L ~/.profile.bak ]; then rm ~/.profile.bak; fi
	if [ -e ~/.bash_profile.bak ] || [ -L ~/.bash_profile.bak ]; then rm ~/.bash_profile.bak; fi
	if [ -e ~/.bashrc.bak ] || [ -L ~/.bashrc.bak ]; then rm ~/.bashrc.bak; fi
	if [ -e ~/.git-completion.sh.bak ] || [ -L ~/.git-completion.sh.bak ]; then rm ~/.git-completion.sh.bak; fi
	if [ -e ~/.git-prompt.sh.bak ] || [ -L ~/.git-prompt.sh.bak ]; then rm ~/.git-prompt.sh.bak; fi
	if [ -e ~/.hushlogin.bak ] || [ -L ~/.hushlogin.bak ]; then rm ~/.hushlogin.bak; fi
	if [ -e ~/.vimrc.bak ] || [ -L ~/.vimrc.bak ]; then rm ~/.vimrc.bak; fi
	if [ -e ~/.vim.bak ] || [ -L ~/.vim.bak ]; then rm ~/.vim.bak; fi
	if [ -e ~/.tmux.conf.bak ] || [ -L ~/.tmux.conf.bak ]; then rm ~/.tmux.conf.bak; fi
	if [ -e ~/.zshrc.bak ] || [ -L ~/.zshrc.bak ]; then rm ~/.zshrc.bak; fi
	if [ -e ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty.bak ] || [ -L ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty.bak ]; then rm ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty.bak; fi
	if [ -e ~/.config/ghostty/config.ghostty.bak ] || [ -L ~/.config/ghostty/config.ghostty.bak ]; then rm ~/.config/ghostty/config.ghostty.bak; fi
	if [ -e ~/.config/ghostty/config.bak ] || [ -L ~/.config/ghostty/config.bak ]; then rm ~/.config/ghostty/config.bak; fi


install:
	ln -sf `pwd`/.profile ~/.profile
	ln -sf `pwd`/.bash_profile ~/.bash_profile
	ln -sf `pwd`/.bashrc ~/.bashrc
	ln -sf `pwd`/.git-completion.sh ~/.git-completion.sh
	ln -sf `pwd`/.git-prompt.sh ~/.git-prompt.sh
	ln -sf `pwd`/.hushlogin ~/.hushlogin
	ln -sf `pwd`/.vimrc ~/.vimrc
	ln -sf `pwd`/.vim ~/.vim
	ln -sf `pwd`/.tmux.conf ~/.tmux.conf
	ln -sf `pwd`/.zshrc ~/.zshrc

	# Ghostty 1.2.3+ prefers config.ghostty; on macOS App Support is the
	# preferred location and overrides ~/.config/ghostty when both exist.
	mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
	ln -sf `pwd`/config.ghostty ~/Library/Application\ Support/com.mitchellh.ghostty/config.ghostty
	# Remove empty/legacy XDG configs so they don't confuse tooling.
	rm -f ~/.config/ghostty/config ~/.config/ghostty/config.ghostty
