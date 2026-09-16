# WGU_D498_Project_R
 
## Instructions:

There are two methods to setup and run the project. 

1. Automated - Powershell. 

To perform the automated setup and launch method, please run the "LaunchVenvAndLabServer" powershell file from within the "WGU_D498_Project_R" folder to setup and launch the project. 

The powershell file will perform the following: 
- Update PIP if necessary
- Install VirtualEnvironment Python Package
- Navigate to this project's parent directory
- Create the Virtual Environment directory, if it does not exist
- Create a Python Virtual Environment.
- Perform the PIP install requirements to install all needed modules/packages. 
- Activate the Virtual Environment
- Navigate back into the project directory
- Launch a new powershell window for this virtual environment
- Launch a JupyterLab Server, starting on the "D498_Project_R_Code_DDCook" notebook.
    NOTE: If launching the server does not launch the "D498_Project_R_Code_DDCook.ipynb" notebook. 


2. Manually - Command Line Interface. 

To perform the manual setup and launch of the project. Please follow the steps below: 

1. Starting from this folder, the "D498" parent directory. Hold the shift key and right click in the window space.
2. This will open an exanded context menu, please locate and select "Open PowerShell Window Here". 
3. A new PowerShell instance should open with the prompt flashing waiting for input, the command line navigation path reading something similar to "PS ...\D498>" 
    (NOTE: In the example above, the '...' would be replaced with your system's navigation path to this current folder, an example: "C:\Users\Udacity_Windows_Station_1\Desktop\D498>")

4. We will begin by making sure Python's package installer manager, PIP is fully updated. Please type in the following command to the PowerShell prompt: 
    ```
        python -m pip install --upgrade pip
    ```

5. Verify and press the enter key to perform an upgrade on PIP. Whether or not an update is performed, the prompt will check and install if necesary. 

6. On the new the PowerShell prompt line, we will now install a virtual environment python package using the following command:
    ```
        python -m pip install virtualenv"
    ```
    
5. Once you have input this, please hit enter to begin the install of the Virtual Environment package using Python's built in Package Installer/Manager, PIP.

6. Once the install has completed, we will now create a new python virtual environment to install our package dependencies to. The virtual environment files will be saved into the "virtaul_envs" folder located in this directory, "D498". To setup the new virtual envirnoment please enter the following into the PowerShell Prompt: 
    ```
        python -m venv virtual_envs/D498_Project_R_venv
    ```

    NOTE: If virtual_envs folder does not exist for some reason, you can easily create the subfolder by running the following command in the PowerShell instance
        ```
            New-Item -ItemType Directory -Force -Path virtual_envs" and hit enter to create it
        ```

7. Verify the command and press enter to begin creating the new virtual envirnoment. 
8. Next,  we will now activate the virtual environment we just created by typing the following into the PowerShell prompt: 
    ```
        .\\virtual_envs\D498_Project_1_venv\Scripts\Activate.ps1
    ```

9. Verify and press enter to run the command, activating the virtual environment. 

If successful, you should now see the name of the newly created virtual envirnment in paranthesis and different color font (typically green) before the previous prompt path (PS: C:\....\D498>)

10. Now that we are inside the virtual environment, we will now install the project dependencies using the following command line:
    ```
        python -m pip install -r requirements.txt
    ```

11. Press enter to run the command and begin the package installation. Please verify that all the packages installed correctly, and troubleshoot any failed installs. 
12. Once the package requirements have been installed, we will now navigated into the project's core directory, using the command: 
    ``` 
        cd "WGU_D498_Project_R"
    ```

13. Verify the entry and press the enter key to perform the directory change. You should received a fresh prompt line, but the working directory path (The path between the PS and ">" ) should now have the main project folder on the ends, "PS C:\....\D497\WGU_D498_Project_R>"

14. Finally, we can now launch JupyterLab server and load the project's landing page notebook, "D498_Project_R_Code_DDCook_final". To make the use easier, please use the following command to launch the server. This command should launch the server to the correct notebook, as well as set the project's working directory to the current location. 
    ```
        python -m jupyterlab D498_Project_R_Code_DDCook_final.ipynb --notebook-dir=.
    ``` 

    > NOTE: If for some reason the server does not launch to the correct notebook, please navigate to the open the notebook page, "D498_Project_R_Code_DDCook_final.ipynb" notebook file from the files panel in Jupyter. 




# R Kernel
1. I launched the "R Console" (Not R studio), and ran the following commands: 
        ```
            install.packages("devtools")
        ```  
        - Once installation is successful.
        ```
            devtools::install_github("IRkernel/IRkernel")
        ```
        - Once installed, and new command waiting run the following: 
        ```
            system.file('kernelspec', package = 'IRkernel')
        ```

        This will give you the address of your R exectuable, for me it was 
        ```
            "C:/Users/{USERPROFILE}/AppData/Local/R/win-library/4.4/IRkernel/kernelspec"    (USERPROFILE being my user profile)
        ```

2. Once I had this path, I used windows explore to navigate to that folder. There should be a .json file there called "kernel.json". 

3. Next, we will run the following in our active python virtual environment's terminal 
        ```
            jupyter kernelspec list 
        ```

    This will show us the available kernels to jupyter. 

4. Next we will install the R kernel into our jupyter kernels with the following command: 
        ```
            jupyter kernelspec install C:\Users\{USERPROFILE}\AppData\Local\R\win-library\4.4\IRkernel\kernelspec --name 'R' --user 
        ```    
            > {USERPROFILE} Being your profile. 
                > If your path was different then mine, then please make sure to put the correct path as the 3rd arguement in the command, between the install and -name arguements. 

5. One the command finishes, rerun the kernelspec list command to verify the installation was successful. 
        ```
            jupyter kernelspec list
        ```

6. To be on the safe side, you can also navigate to the R jupyter kernel path listed in this kernel spec list and ensure that the executable path has been added. 
        When I navigated to the C:\Users\{USERPROFILE}\AppData\Roaming\jupyter\kernels\r folder and then opened the kernel.json in Visual Studio code. 

            I had to add the path to my R exectuable to the json file. I simply placed it above the "--slave" argument in the argv brackets. Here is what my json  file looks like:
            ```
                {
                    "argv": [
                        "C:/Program Files/R/R-4.4.2/bin/R.exe",
                        "--slave", 
                        "-e", 
                        "IRkernel::main()", 
                        "--args", "{connection_file}"],
                    "display_name":"R",
                    "language":"R"
                }
            ```

7. After this I restarted jupyter and verifeid it was working. 

> NOTE: It may be necessary to add the R excecutable path to your windows path environment variables as well. 


# Google Maps API Key

The map-dependent cells (anything using `ggmap::register_google()`) require a Google Maps API key supplied via an environment variable — no key is hardcoded in the notebook or scripts.

1. Copy `.env.example` to `.env` (or otherwise set the variable in your shell/session) and fill in your own key:
    ```
        GOOGLE_MAPS_API_KEY=your-key-here
    ```
2. Set it as a system/session environment variable before launching R or JupyterLab, for example in PowerShell:
    ```
        $env:GOOGLE_MAPS_API_KEY = "your-key-here"
    ```
3. The R code reads it with `Sys.getenv("GOOGLE_MAPS_API_KEY")` and will stop with an error if it is not set. Get your own key from the [Google Cloud Console](https://console.cloud.google.com/google/maps-apis).

