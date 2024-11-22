# macOS Setup Script
This script automates the installation and setup of essential tools, utilities, and applications on macOS. It installs Homebrew, various Homebrew packages, Cask applications, and Mac App Store apps. Additionally, it applies some system settings and ensures that Oh My Zsh is set up for a better shell experience.

This script is highly customizable — feel free to modify the list of apps and packages to suit your needs.

## Features
-   Installs  **Homebrew**  (if not already installed).
-   Installs  **Homebrew packages**  like  `git`,  `htop`,  `python3`, etc.
-   Installs  **Cask applications**  such as  `adobe-acrobat-reader`,  `microsoft-office`,  `vlc`, and more.
-   Installs  **Mac App Store apps**  using their App IDs.
-   Configures macOS system settings, including mouse tracking speed and disabling  `.DS_Store`  files on network volumes.
-   Installs  **Oh My Zsh**  for an enhanced shell experience.

## Prerequisites

Before running the script, ensure that you meet the following prerequisites:

-   **macOS**: This script is designed for macOS users.
-   **Internet Access**: The script installs various packages from online sources like Homebrew and the Mac App Store.
-   **Command Line Tools**: The script assumes basic command-line tools like  `bash`,  `curl`, and  `git`  are available.

## How to Use

1.  **Download the Script**:
    
	- Clone or download the script from this repository. You can use  `git`  if you prefer:
		```bash
		git clone https://github.com/your-username/macos-setup-script.git
		cd macos-setup-script
		```     
	- Alternatively, download the script manually from the repository and navigate to the folder where it is saved.

2. **Make the Script Executable**:
	-   Ensure the script is executable by running:
		```bash
		chmod +x setup_macos.sh
		```

3.   **Edit the Script (Optional)**:   
	    -   Open  `setup_macos.sh`  in any text editor and modify the list of packages or apps you want to install.
	        -   **Homebrew packages**: Look for the  `homebrew_packages`  array and add/remove packages as needed.
	        -   **Cask packages**: Look for the  `cask_packages`  array to modify the list of GUI apps you want.
	        -   **Mac App Store apps**: Modify the  `mac_apps`  array to add or remove apps using their App IDs.
	
4.  **Run the Script**:
	- Open your terminal, navigate to the folder where the script is saved, and run:
		```bash
		./setup_macos.sh
		```

5.  **Follow the Prompts**: 
    -   The script will ask for your  `sudo`  password if it needs to install applications that require elevated privileges (such as Adobe Acrobat or Microsoft Office).
    -   The script will display a spinner while each package is being installed, allowing you to track progress.

 6.  **Enjoy a Fully Configured macOS Environment**:
	    - Once the script completes, your macOS will be equipped with essential tools and apps for development, productivity, and general use.


## License
This project is licensed under the MIT License - see the [LICENSE](https://www.mit.edu/~amini/LICENSE.md) file for details.

## Acknowledgements
- This script utilizes  **Homebrew**  for package management,  **Cask**  for GUI applications, and  **mas**  for installing Mac App Store apps.
- Special thanks to the creator of  **gh-zh** *[Gustavo Hellwig](https://github.com/gustavohellwig)*  for providing a fantastic shell environment.
