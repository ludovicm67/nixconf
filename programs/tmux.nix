{ ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    newSession = true;
    shortcut = "a";
    escapeTime = 10;
    keyMode = "vi";
    extraConfig = ''
      set -g mouse on
      set -g default-command "/bin/zsh"

      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'pbcopy'

      # panes
      set -g pane-border-style fg=black
      set -g pane-active-border-style fg=brightred

      ## status bar design
      # status line
      set -g status-justify left
      set -g status-style bg=default,fg=colour12
      set -g status-interval 2

      # messaging
      set -g message-style fg=black,bg=yellow
      set -g message-command-style fg=blue,bg=black

      # window mode
      setw -g mode-style bg=colour6,fg=colour0

      # window status
      setw -g window-status-format " #F#I:#W#F "
      setw -g window-status-current-format " #F#I:#W#F "
      setw -g window-status-format "#[fg=magenta]#[bg=black] #I #[bg=cyan]#[fg=colour8] #W "
      setw -g window-status-current-format "#[bg=brightmagenta]#[fg=colour8] #I #[fg=colour8]#[bg=colour14] #W "
      setw -g window-status-current-style bg=colour0,fg=colour11,dim
      setw -g window-status-style bg=green,fg=black,reverse

      # loud or quiet?
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-window-option -g monitor-activity off
      set-option -g bell-action none

      # modes
      setw -g clock-mode-colour colour135
      setw -g mode-style fg=colour196,bg=colour238,bold

      # panes
      set -g pane-border-style bg=colour235,fg=colour238
      set -g pane-active-border-style bg=colour236,fg=colour51

      # statusbar
      set -g status-position bottom
      set -g status-style bg=colour234,fg=colour137,dim
      set -g status-left ""
      set -g status-right '#[fg=colour233,bg=colour241,bold] %d/%m #[fg=colour233,bg=colour245,bold] %H:%M:%S '
      set -g status-right-length 50
      set -g status-left-length 20
      setw -g window-status-current-style fg=colour81,bg=colour238,bold
      setw -g window-status-current-format ' #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F '
      setw -g window-status-style fg=colour138,bg=colour235,none
      setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '
      setw -g window-status-bell-style fg=colour255,bg=colour1,bold

      # messages
      set -g message-style fg=colour232,bg=colour166,bold
    '';
  };
}
