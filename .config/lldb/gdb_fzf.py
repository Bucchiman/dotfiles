import gdb
import os
import subprocess

class FzfSelectFileCommand(gdb.Command):
    """fzf を使ってファイルを選択し、内容を表示する"""

    def __init__(self):
        super(FzfSelectFileCommand, self).__init__("fzf_select", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        try:
            # fzfでファイル選択
            command = (
                "cd ~/dotfiles/.config/lldb/docs; "
                "find . -type f | "
                "fzf --height=100% "
                "--preview 'bat --style=numbers --color=always --line-range=:100 {}' "
                "--preview-window=right:70%"
            )
            fzf_process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            output, error = fzf_process.communicate()

            if fzf_process.returncode == 0:
                selected_file = output.decode("utf-8").strip()
                if selected_file:
                    file_path = os.path.expanduser(f"~/dotfiles/.config/lldb/docs/{selected_file}")
                    with open(file_path, 'r', encoding='utf-8') as f:
                        content = f.read()
                    print(f"Loaded file: {selected_file}\n{content}")
                else:
                    print("No file selected.")
            else:
                print(f"fzf failed: {error.decode('utf-8')}")
        except Exception as e:
            print(f"Error: {e}")

# GDBにコマンド登録
FzfSelectFileCommand()
