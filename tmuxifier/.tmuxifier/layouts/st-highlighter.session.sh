# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Documents/Github/html-text-highlight/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "st-highlighter"; then
  new_window "st-highlighter_editor"
  select_window 0 
  select_pane 0
  run_cmd "nvim"


  # Create a new window inline within session layout definition.
  #new_window "misc"

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  #select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
