# Tmux Configuration for Devilbox Projects

## This tmux configuration allows you to seamlessly run any repository from chosen directory. By default it is setup for projects inside Devilbox, but it can be adjusted if needed. 
## It integrates Docker session running in the background with a selected project environment, a file watcher, and an opened and focused Neovim editor.

### Key Features:
- Utilizes tmux window 0 for all terminal processes. When detached, all running processes in this window are automatically stopped by tmux (Ctrl+C is sent to every pane).
- Upon reattaching to the session, each pane resumes its original command. For example, if npm run dev was running in a pane, it will automatically restart upon reattaching.
- Devilbox runs in a separate background session named devilbox. (This can be configured to run any other Docker setup, or be compleatly disabled)
- Includes auto-complete functionality for project selection, scanning repositories in ~/devilbox/data/www/. Only repositories from this directory are available for use.

### Configuration Steps:
1. Create a Symlink
    - Link the work script to /usr/local/bin/ to make it globally accessible:
        ``` sudo ln -s /path/to/work /usr/local/bin/work ```

2. Update .bashrc
    - Add the following line to your .bashrc file using Neovim or any other editor:
        ``` source /path/to/the/repository/.bash_completion.sh ```
    This enables auto-completion for the work command.

3. Apply Changes
    - Reload the .bashrc configuration:
        ``` source ~/.bashrc ```


## Setting Up Custom Scripts for Projects
    
You can define custom scripts for specific projects to run alongside their configurations. This is particularly useful for additional commands or settings unique to a project.

### How to Configure:
1. Place your custom scripts in:
    ``` custom_settings/<project-directory-name>/<custom-script> ```
    - Example:
        If your project is named snake_game, and it requires additional configurations:

        Create a directory:
            ``` custom_settings/snake_game/ ```
        Add your script inside this directory.

2. Run the work command with the custom script:
    ``` work snake_game <custom-script-name> ```

### The command automatically detects and runs the selected project with the specified custom script. Auto-complete is also supported for both project directories and custom scripts.

### You may need to run command ```sudo chmod +x <script-name> ``` to make scripts executable.


