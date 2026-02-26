# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Documents/Github/question-bank-admin"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "qbAdmin"; then

  # Create a new window inline within session layout definition.
  new_window "qbAdmin_editor"
  select_window 0 
  select_pane 0
  run_cmd "nvim"
  split_h 20
  #new_window "server"

  select_pane 1
  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  #select_window 1
  run_cmd "npm run dev"
  split_v 30
  select_pane 0
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
