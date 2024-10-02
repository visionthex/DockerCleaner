### DockerCleaner

#### Setting up a Script to Clean Up Docker

**Install figlet**
```sh
sudo apt install figlet
```

1. **Create Your Script:**
   - Open a terminal and create your script file using:
     ```sh
     nano cleanup.sh
     ```

2. **Make the Script Executable:**
   - Make the script executable by running:
     ```sh
     chmod +x cleanup.sh
     ```

3. **Run Your Script:**
   - Execute your script with the following command:
     ```sh
     ./cleanup.sh
     ```

#### Optional Setup for a Single Command

1. **Move the Script to a Directory in Your PATH:**
   - To run the script using a single command, move it to a directory that is in your system's PATH:
     ```sh
     sudo mv cleanup.sh /usr/local/bin/cleanup
     ```
   - Alternatively, you can move it to `~/bin`:
     ```sh
     mv cleanup.sh ~/bin/cleanup
     ```

2. **Verify and Configure Your PATH:**
   - Ensure that the directory where you moved the script is in your PATH. Check your PATH with:
     ```sh
     echo $PATH
     ```
   - If `~/bin` is not in your PATH, add it by modifying your shell configuration file (e.g., `~/.bashrc`, `~/.bash_profile`, or `~/.zshrc`). Add the following line:
     ```sh
     export PATH="$HOME/bin:$PATH"
     ```
   - Reload your shell configuration file to apply the changes:
     ```sh
     source ~/.bashrc
     ```

3. **Run Your Script:**
   - Now you can run your script simply by typing:
     ```sh
     cleanup
     ```
