# This is the configuration for tmux, to automatically run any repository from devilbox, with devilbox docker running as a background session and selected project opened together with file watcher already running in the background and nvim opend and focused

This configuration is set up to use window 0 for  any terminal pnes that are ment to be run, upon detachting from this session,
every process from that window gets stopped by tmux (it runs Control + c on every pane). Upon re-attaching to the session,
each pane from that window gets it original command re-run (for example if 'npm run dev' was used in that pane,
that command will be fired for that pane on session attach).

Devilbox is run in separate session, in the background. The session is called: devilbox.

### There is an auto-complete configured, just press ``` <tab> ``` as you type ( script is set up to look for projects inside ``` ~/devilbox/data/www/ ```, and only repositories from that folder are available ).

## Configuration:

1. Symlink 'work' script to '/usr/local/bin/' to make work script awailable globally for the user
2. Open bashrc config using ```nvim  ~/.bashrc ``` and add ``` source /path/to/the/repository/.bash_completion.sh ``` to make auto-complete permanently available for the ``` work ``` command.
3. Run ``` source ~/.bashrc ``` to apply changes
