#!/bin/bash
# script version
ver=1.0
# password capture
psw=$(whiptail --title "PowerShell Core Install | Sudo Password Capture" --passwordbox "Sudo is required to install PowerShell Core. Please enter your sudo password to proceed with the install." 10 60 3>&1 1>&2 2>&3)
exitstatus=$?
    if [ $exitstatus = 0 ]; then
        whiptail --title "PowerShell Core Installation" --msgbox "Sudo password captured successfully!" 8 78
    else
        #Password if cancelled
        whiptail --title "PowerShell Core Installation" --msgbox "Sudo password not captured, install cancelled." 10 60
    fi
function envSelection {
    choice=$(whiptail --title "Environment Selection" --menu "Please choose your environment" 16 78 5 \
    "ubuntu14" "14.04" \
    "ubuntu16" "16.04" \
    "ubuntu17" "17.04" \
    "debian8" "Debian 8" \
    "debian9" "Debian 9" \
    "centos7" "CentOS 7" \
    "rhel7" "RHEL 7" 3>&2 2>&1 1>&3) 
    # Change to lower case and remove spaces.
    option=$(echo $choice | tr '[:upper:]' '[:lower:]' | sed 's/ //g')
    case "${option}" in
        ubuntu14) installPSCore14
        ;;
        ubuntu16) installPSCore16
        ;;
        ubuntu17) installPSCore17
        ;;
        debian8) installDebian8
        ;;
        debian9) installDebian9
        ;;
        centos7) installCentos7
        ;;
        rhel7) installrhel7
        ;;
        *) whiptail --title "PowerShell Core Installer" --msgbox "You have chosen to cancel this installation." 8 78
            status=1
            exit
        ;;
    esac
}
function envSelectazrm {
    envSelection
    installAzureRM
    end
    exit 0
}
function envselctall {
    envSelection
    installAzureRM
    installAzCli
    end
    exit 0
}
function installDebian8 {
    {
        # Install system components
        sudo -s <<< $psw apt-get update
        sudo -s <<< $psw apt-get install curl apt-transport-https

        # Import the public repository GPG keys
        curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

        # Register the Microsoft Product feed
        sudo -s <<< $psw sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-jessie-prod jessie main" > /etc/apt/sources.list.d/microsoft.list'

        # Update the list of products
        sudo -s <<< $psw apt-get update

        # Install PowerShell
        sudo -s <<< $psw apt-get install -y powershell
        sleep 1
        for ((i=0; i<=100; i+=20)); do
            sleep 1
            echo $i
        done
    } | whiptail --title "PowerShell Core Installer" --gauge "Installing PowerShell Core for Ubuntu 14.04" 6 60 0
    end
    exit 0
} 
function installDebian9 {
    {
        # Install system components
        sudo -s <<< $psw apt-get update
        sudo -s <<< $psw apt-get install curl gnupg apt-transport-https

        # Import the public repository GPG keys
        curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

        # Register the Microsoft Product feed
        sudo -s <<< $psw sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list'

        # Update the list of products
        sudo -s <<< $psw apt-get update

        # Install PowerShell
        sudo -s <<< $psw apt-get install -y powershell
        sleep 1
        for ((i=0; i<=100; i+=20)); do
            sleep 1
            echo $i
        done
    } | whiptail --title "PowerShell Core Installer" --gauge "Installing PowerShell Core for Ubuntu 14.04" 6 60 0
    end
    exit 0
} 
function installCentos7 {
    {
        # Import the public repository GPG keys
        # Register the Microsoft RedHat repository
        curl -s https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

        # Install PowerShell
        sudo -s <<< $psw yum install -y powershell
        sleep 1
        for ((i=0; i<=100; i+=20)); do
            sleep 1
            echo $i
        done
    } | whiptail --title "PowerShell Core Installer" --gauge "Installing PowerShell Core for CentOS 7" 6 60 0
    end
    exit 0
}
function installrhel7 {
    {
        # Register the Microsoft RedHat repository
        curl -s shttps://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

        # Install PowerShell
        sudo -s <<< $psw yum install -y powershell
        sleep 1
        for ((i=0; i<=100; i+=20)); do
            sleep 1
            echo $i
        done
    } | whiptail --title "PowerShell Core Installer" --gauge "Installing PowerShell Core for RHEL 7" 6 60 0
    end
    exit 0
} 
function installPSCore14 {
    {
        # Import the public repository GPG keys
        curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
        # Register the Microsoft Ubuntu repository
        curl -s https://packages.microsoft.com/config/ubuntu/14.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
        # Update apt-get
        sudo -s <<< $psw apt-get update
        # Install PowerShell
        sudo -s <<< $psw apt-get install -y powershell
        sleep 1
        for ((i=0; i<=100; i+=20)); do
            sleep 1
            echo $i
        done
    } | whiptail --title "PowerShell Core Installer" --gauge "Installing PowerShell Core for Ubuntu 14.04" 6 60 0
    end
    exit 0
} 
function installPSCore16 {
    {
        # Import the public repository GPG keys
        curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
        # Register the Microsoft Ubuntu repository
        curl -s https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
        # Update apt-get
        sudo -S <<< $psw apt-get update
        # Install PowerShell
        sudo -S <<< $psw apt-get install -y powershell
        sleep 1
        for ((i=0; i<=100; i+=20)); do
            sleep 1
            echo $i
        done
    }   | whiptail --title "PowerShell Core Installer" --gauge "Installing PowerShell Core for Ubuntu 16.04" 6 60 0
    end
    exit 0
} 
function installPSCore17 {
   {
        # Import the public repository GPG keys
        curl -s https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
        # Register the Microsoft Ubuntu repository
        curl -s https://packages.microsoft.com/config/ubuntu/17.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list
        # Update apt-get
        sudo -s <<< $psw apt-get update
        # Install PowerShell
        sudo -s <<< $psw apt-get install -y powershell
        sleep 1
        for ((i=0; i<=100; i+=20)); do
            sleep 1
            echo $i
        done
    }   | whiptail --title "PowerShell Core Installer" --gauge "Installing PowerShell Core for Ubuntu 17.04" 6 60 0
    end
    exit 0
} 
function installAzureRM {
    {
        #Azure RM NetCore Preview Module Install
        sudo -s <<< $psw pwsh -Command Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
        sudo -s <<< $psw pwsh -Command Install-Module -Name AzureRM.Netcore
        sudo -s <<< $psw pwsh -Command Import-Module -Name AzureRM.Netcore

        if [[ $? -eq 0 ]]
            then
                echo "Successfully installed PowerShell Core with AzureRM NetCore Module."
            else
                echo "PowerShell Core with AzureRM NetCore Module did not install successfully." >&2
        fi
        sleep 1
        for ((i=0; i<=100; i+=20)); do
        sleep 1
        echo $i
        done
    } | whiptail --title "PowerShell Core Installer" --gauge "Installing Azure RM Modules" 8 78 0
} 
function installAzCli {
    {
        echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
        sudo tee /etc/apt/sources.list.d/azure-cli.list
        sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893 > /dev/null 2>&1
        sudo apt-get install apt-transport-https
        sudo apt-get update && sudo apt-get install azure-cli
        if [[ $? -eq 0 ]]
        then
            echo "Successfully installed Azure CLI 2.0"
        else
            echo "Azure CLI 2.0 not installed successfully" >&2
        fi
        sleep 1
        for ((i=0; i<=100; i+=20)); do
            sleep 1
            echo $i
        done
    }   | whiptail --title "PowerShell Core Installer" --gauge "Installing Azure CLI 2.0" 6 60 0  
}         
function about {
  whiptail --title "About" --msgbox " \
                PowerShell Core Install Menu Assist
                  Written by Jessica Deen
    This menu will help install the latest version of PowerShell 
    Core and optional components if desired.
    For Additional Details See https://github.com/jldeen/pwshcore
    " 35 70 35
}
function end {
    whiptail --title "PowerShell Core Installation" --msgbox "PowerShell Core Installer has completed successfully." 8 78
}
#------------------------------------------------------------------------------
function do_main_menu ()
    {
    SELECTION=$(whiptail --title "PowerShell Core Install Assist $ver" --menu "Arrow/Enter Selects or Tab Key" 20 70 10 --cancel-button Quit --ok-button Select \
    "a " "PowerShell Core Install Only" \
    "b " "PowerShell Core Install + AzureRM Modules" \
    "c " "PowerShell Core Install + AzureRM Modules and Azure CLI 2.0" \
    "f " "About" \
    "q " "Quit Menu Back to Console"  3>&1 1>&2 2>&3)

    RET=$?
    if [ $RET -eq 1 ]; then
        exit 0
    elif [ $RET -eq 0 ]; then
        case "$SELECTION" in
        a\ *) envSelection ;;
        b\ *) envSelectazrm ;;
        c\ *) envselctall ;;
        f\ *) about ;;
        q\ *) exit 0 ;;
            *) whiptail --msgbox "Programmer error: unrecognized option" 20 60 1 ;;
        esac || whiptail --msgbox "There was an error running selection $SELECTION" 20 60 1
    fi
    }
while true; do
   do_main_menu
done