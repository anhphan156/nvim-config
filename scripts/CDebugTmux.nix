{
  writeShellApplication,
  tmux,
  gdb,
  ...
}: let
  gdbx = writeShellApplication {
    name = "gdbx";
    runtimeInputs = [tmux gdb];
    text = ''
        reg="$(tmux split-pane -vPF "#D" -l 8 "tail -f /dev/null")"
        tmux last-pane
        memory="$(tmux split-pane -hPF "#D" -l 90 "tail -f /dev/null")"
        tmux last-pane
        asm="$(tmux split-pane -vPF "#D" -l 12 "tail -f /dev/null")"
        tmux last-pane

        memory_tty="$(tmux display-message -p -t "$memory" '#{pane_tty}')"
        asm_tty="$(tmux display-message -p -t "$asm" '#{pane_tty}')"
        reg_tty="$(tmux display-message -p -t "$reg" '#{pane_tty}')"

        gdb -ex "dashboard assembly -output $asm_tty" -ex "dashboard -output $memory_tty" -ex "dashboard registers -output $reg_tty" "$1"
        tmux kill-pane -t "$memory"
        tmux kill-pane -t "$asm"
        tmux kill-pane -t "$reg"

      if [[ -n "$2" ]]; then
      	tmux kill-window -t "$2"
      fi
    '';
  };
in
  writeShellApplication {
    name = "CDebugTmux";
    runtimeInputs = [tmux gdbx];
    text = ''
      window=$(tmux new-window -PF "#D")
      tmux send-keys -t "$window" " gdbx out $window" Enter
    '';
  }
