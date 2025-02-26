# Verify PIP Is fully updated
python -m pip install --upgrade pip

# Verify Virtual Env module is installed 
python -m pip install virtualenv

# Backup One Directory For Virtual Env
cd ".."

# Test If Virtual Env directory exists
if (-Not (Test-Path -Path "\virtual_envs\")) {

    Write-Host "Directory does not exist."
    Write-Host "Running First Time Initialization" 

    # Creating Virtual Environment Folder
    New-Item -ItemType Directory -Force -Path virtual_envs
    #New-Item -ItemType Directory -Force -Path Test
}

if (-Not (Test-Path -Path "\virtual_envs\D498_Project_R_venv\")) {
    #Create a Virtual Env
    python -m venv virtual_envs/D498_Project_R_venv
    #python -m venv Test/D498_Project_R_Test_venv
}

# Activate the virtual environment
.\\virtual_envs\D498_Project_R_venv\Scripts\Activate.ps1
#.\\Test\D498_Project_R_Test_venv\Scripts\Activate.ps1

# Install Python Requirements
python -m pip install -r requirements.txt

#python -m ipython kernel install --user --name=D498_Project_R_venv
python -m ipython kernel install --user --name=D498_Project_R_venv

# You will need to have R configured to work from within the python virtual envirnoment
# For my system, I had to perform several steps: 
# 1. 
#    I launched the "R Console" (Not R studio), and ran the following commands: 
#        > install.packages("devtools")
#            - Once installation is successful.
#        > devtools::install_github("IRkernel/IRkernel")
#            - Once installed, and new command waiting run the following: 
#        > system.file('kernelspec', package = 'IRkernel')
#
#        This will give you the address of your R exectuable, for me it was 
#            > "C:/Users/{USERPROFILE}/AppData/Local/R/win-library/4.4/IRkernel/kernelspec"    (USERPROFILE being my user profile)
#
# 2. 
#    Once I had this path, I used windows explore to navigate to that folder. There should be a .json file there called "kernel.json". 
#
# 3. 
#    Next, we will run the following in our active python virtual environment's terminal 
#        > jupyter kernelspec list 
#
#    This will show us the available kernels to jupyter. 
#
# 4. 
#    Next we will install the R kernel into our jupyter kernels with the following command: 
#        > jupyter kernelspec install C:\Users\{USERPROFILE}\AppData\Local\R\win-library\4.4\IRkernel\kernelspec --name 'R' --user 
#            {USERPROFILE} Being your profile. 
#                If your path was different then mine, then please make sure to put the correct path as the 3rd arguement in the command, between the install and --name arguements. 
#
# 5. 
#    One the command finishes, rerun the kernelspec list command to verify the installation was successful. 
#        > jupyter kernelspec list
#
# 6. 
#    To be on the safe side, you can also navigate to the R jupyter kernel path listed in this kernel spec list and ensure that the executable path has been added. 
#        When I navigated to the C:\Users\{USERPROFILE}\AppData\Roaming\jupyter\kernels\r folder and then opened the kernel.json in Visual Studio code. 
#
#        I had to add the path to my R exectuable to the json file. I simply placed it above the "--slave" argument in the argv brackets. Here is what my json file looks like:
#            {
#                "argv": [
#                    "C:/Program Files/R/R-4.4.2/bin/R.exe",
#                    "--slave", 
#                    "-e", 
#                    "IRkernel::main()", 
#                    "--args", "{connection_file}"],
#                "display_name":"R",
#                "language":"R"
#            }
#
# 7. After this I restarted jupyter and verifeid it was working. 
#
# NOTE: It may be necessary to add the R excecutable path to your windows path environment variables as well. 





# Change Directories.
cd "D498"

# Launch a new powershell window and run the Launch Virtual Environment Script and keep window open. 
Start-Process powershell -ArgumentList "-NoExit", "-File", "launchvenv.ps1"

# Check if VS Code is installed, If true, launch VS Code from current directory, if false, do not launch vs code
#if ((Get-Process -Name code) -ne $null) { 
#
#    Write-Output "VS Code is installed" 
#
#    Write-Output "Launching VS Code in working directory"
#    
#    code . 
#    
#} else {
#    Write-Output "VS Code is not installed" 
#
#    Write-Output "Skipping VS Code Launch"
#
#}


# Get Computer's IP Address and save to a variable 
#$IpAddress = (Get-NetIPAddress |
#  Where-Object {
#    $_.AddressState -eq 'Preferred' -and 
#    $_.ValidLifetime -lt '24:00:00'
#  }
#).IPAddress

# Creating an expression to be involved to launch the juptyerlab to a specific page with ip, port, and notebook directory parameters set. 
#$expression = "python -m jupyterlab notebooks/order_of_operations_landing.ipynb --ip $($IpAddress[1]) --port 8888 --notebook-dir=."
#$expression = "python -m jupyterlab notebooks/order_of_operations_landing.ipynb --notebook-dir=."

# Invoking expression above. 
#Invoke-Expression $expression

#python -m jupyterlab notebooks/order_of_operations_landing.ipynb --ip $($IpAddress[1]) --port 8888 --notebook-dir=.

#python -m jupyterlab --notebook-dir=.

python -m jupyterlab D498_Project_R_Code_DDCook_final.ipynb --notebook-dir=. 