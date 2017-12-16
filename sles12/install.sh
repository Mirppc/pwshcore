#!/bin/bash
echo "This script will install the latest version of PowerShell Core on your SLES 12 system...."
echo .

# Import the public repository GPG keys  
#not needed on suse?  add via yast?#
#curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Register the Microsoft Suse repository
zypper ar https://packages.microsoft.com/config/sles/12/prod.repo microsoft

# Update zypper
sudo zypper --gpg-auto-import-keys ref

# Install PowerShell
sudo zypper install --non-interactive powershell && echo "The latest version of Powershell Core has been installed..."
echo .

echo "This script will now install the AzureRM Modules..."
echo .

#Azure RM NetCore Preview Module Install
sudo pwsh -Command Install-Module -Name AzureRM.Netcore
sudo pwsh -Command Import-Module -Name AzureRM.Netcore

if [[ $? -eq 0 ]]
    then
        echo "Successfully installed PowerShell Core with AzureRM NetCore Module."
    else
        echo "PowerShell Core with AzureRM NetCore Module did not install successfully." >&2
fi

#Install Azure CLI 2.0
#Address https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
#Github https://github.com/Azure/azure-cli/releases

read -p "Would you also like to install Azure CLI? y/n" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
        for ((i=0; i<=100; i+=20)); do
            # sudo -S - auth sudo in advance
            sudo -S <<< $psw ls > /dev/null 2>&1
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypper/repos.d/azure-cli.repo'
            zypper ref > /dev/null 2>&1
            sudo zypper in --non-interactive azure-cli 
            sleep 1
            echo $i
        done
        } | whiptail --title "PowerShell Core Installer" --gauge "Installing Azure CLI 2.0 for RPM" 6 60 0

    then
        echo "Successfully installed Azure CLI 2.0"
    else
        echo "Azure CLI 2.0 not installed successfully" >&2
fi
else 
    echo "You chose not to install Azure CLI 2.0... Exiting now."
fi
