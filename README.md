## This is configuration for tmux to automatically run devilbox as a background session and open a project with file watcher already running in the background 

This configuration is set up to use window 0 for terminal windows that are ment to be run, upon detachting from this session,
every process in first window gets stopped by tmux(it runs Control + c on every pane). Upon re-attaching to the session,
each pane from the first window gets it original command re run (for example if 'npm run dev' was used in that pane,
that command will be fired for that pane on session attach).

Devilbox is run in separate session, in the background. The session is called: devilbox.

## Symlink 'work' script to '/usr/local/bin/' to make work script awailable globally for the user

then run command work and the repository you want to open ( script is set up to look for projects inside ~/devilbox/data/www/).
There is an auto-complete configured, for any directory available in the folder: '~/devilbox/data/www/', just press <tab> as you type.
This command only look for projects inside specyfied folder! directories outside are not available, you will have to start tmux manually in that case.
