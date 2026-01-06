# Tmux Configuration for Projects
Quick setup for running projects with tmux. Opens a repository from your configured directory with Docker running in the background, a file watcher, and Neovim ready to go.

## How It Works
- Window 0 is meant for all terminal processes, like file watcher etc. When you detach, everything stops (Ctrl+C sent to all panes).
- When you reattach, commands restart automatically. If you had `npm run dev` running, it starts again.
- Docker runs in a separate background session called devilbox.
- Tab completion works for selecting projects from your repo directory.
- Window 9 runs Claude Code.

## Setup
1. Link the script so you can run it from anywhere:
   ```bash
   sudo ln -s <your/path/to/work> /usr/local/bin/work
   ```

2. Add this line to your `.bashrc`:
   ```bash
   source </path/to/this/config-repository-dir>.bash_completion.sh
   ```

3. Reload your shell:
   ```bash
   source ~/.bashrc
   ```


## Custom Project Scripts
Add custom scripts for specific projects when you need extra setup or want to open multiple repos at once.

Put your scripts here:
```bash
custom_settings/<project-name>/<script-name>
```

Example for a project called `snake_game`:
```bash
custom_settings/snake_game/my-script
```

Run it with custom script:
```bash
work snake_game my-script
```
Or without:
```bash
work snake_game
```

Tab completion works for both project names and script names.

Make scripts executable if needed:
```bash
sudo chmod +x <script-name>
```


