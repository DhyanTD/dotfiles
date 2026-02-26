# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Documents/Github/vente-erp"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "primarc"; then

  # Create a new window inline within session layout definition.
  new_window "primarc_editor"
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
  #run_cmd "sudo service apache2 start"
  #run_cmd "sudo /etc/init.d/mysql start"
  sleep 1
  run_cmd "tmux send-keys 'sudo mkdir -p /var/run/mysqld' C-m"
  sleep 2
  run_cmd "tmux send-keys 'sudo chown mysql:mysql /var/run/mysqld' C-m"
  sleep 2
  run_cmd "tmux send-keys 'sudo ln -s /tmp/mysql.sock /var/run/mysqld/mysqld.sock' C-m"
  sleep 2
  run_cmd "tmux send-keys 'sudo service apache2 start' C-m"
  # Load a defined window layout.
  #load_window "example"

  select_pane 0
  # Select the default active window on session creation.
  #select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
