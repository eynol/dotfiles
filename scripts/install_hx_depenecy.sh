#!/bin/bash
#

# bash
echo bash lsp: bash-language-server, shfmt shellcheck
# feat: Diagnostics(shellcheck) Formatting(shfmt)
# 
npm i -g bash-language-server


#  css vscode-langservers-extracted lsp: vscode-css-language-server
echo css lsp : vscode-css-language-server
npm i -g vscode-langservers-extracted


# docer and docker compose
echo docker and docker compose
npm install -g dockerfile-language-server-nodejs @microsoft/compose-language-service

# html
echo html lsp：vscode-langservers-extracted

# json
echo json lsp: vscode-json-language-server vscode-langservers-extracted


# rust
echo rust lsp: rust-analyzer
rustup component add rust-analyzer

# tailwindcss
echo tailwindcss lsp:@tailwindcss/language-server
npm i -g @tailwindcss/language-server

# typescript
echo typescript lsp : typescript-language-server depends typescript
npm install -g typescript typescript-language-server


