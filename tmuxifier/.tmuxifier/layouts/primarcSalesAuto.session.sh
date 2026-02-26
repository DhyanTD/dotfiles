# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Documents/Github/primarc-sales-gst-automation/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "primarcSalesAuto"; then
  new_window "PrmSalesAuto Editor"
  select_window 0
  select_pane 0
  run_cmd "nvim"

  split_h 30
  select_pane 1
  run_cmd "npm run dev"
  split_v 30
  select_pane 2
  run_cmd "npm run watch"
  select_pane 0

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
