# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Documents/Github/primarc-crm-frontend/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "primarcCrmFrontend"; then

  new_window "PrimarcCrmFrontend_editor"
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

  select_pane 0
fi
# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
