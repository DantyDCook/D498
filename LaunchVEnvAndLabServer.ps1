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

python -m jupyterlab --notebook-dir=.