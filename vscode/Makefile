.PHONY: apply
foo:
 @for file in settings.json keybindings.json mcp.json; do \
 	echo "Coping $${file}"; \
	rm -rf ~/Library/Application\ Support/Code/Use${file}; \
	ln -s ~/.config/vscode/settings.json ~/Library/Application\ Support/Code/User/${file}; \
 	done
