$PATH = $(Get-Location).Path

# basic aliases
set-alias -name pn -value pnpm
Set-alias -name yn -Value yarn

function divider($name) {
    Write-Output ""
    Write-Output "----------$name----------"
    Write-Output ""
}

function aliases() {
    divider("CODING ALIASES");
    Write-Output "ys           yarn start"
    Write-Output "yd           yarn dev"
    Write-Output "sf           yarn start | frontend"
    Write-Output "sb           yarn start | backend"
    Write-Output "sa           yarn start | admin"
    Write-Output "sf-d         Set-Location frontend +yarn dev"
    Write-Output "sa-d         Set-Location admin +yarn dev"
    Write-Output "sb-d         Set-Location backend +yarn dev"
    Write-Output "sass-f       Set-Location frontend +yarn sass"
    Write-Output "sass-a       Set-Location admin +yarn sass"
    Write-Output "rs           python manage.py runserver"
    Write-Output "m            Django migrate"
    Write-Output "mm           Django makemigrations"
    Write-Output "mmm          Django migrate & makemigrations"
    Write-Output "venv         Check and start python venv"
    Write-Output "devenv       Check and stop python venv"
    
    divider("LIST ALIASES");
    Write-Output "..           Set-Location .."
    Write-Output "...          Set-Location .. >> Set-Location .."
    Write-Output "....         Set-Location .. >> Set-Location .. >> Set-Location .."
    Write-Output "..ls         Set-Location .. >> ls"

    divider("GIT ALIASES");
    Write-Output "git-revert   revert git cache state"
    Write-Output "git-kai      set user config to kai"
    Write-Output "git-orka     set user config to orka"

    divider("SYSTEM ALIASES");
    Write-Output "pinger       Ping -n 10000 -w 500 8.8.8.8"
    Write-Output "wsl-stop     stop all instances of wsl"
}

function ys() {
    yarn start;
}

function yd() {
    yarn dev;
}

function sf() {
    Set-Location frontend;
    yarn start;
}

function sf-d() {
    Set-Location frontend;
    yarn dev;
}

function sa-d() {
    Set-Location admin;
    yarn dev;
}


function sb() {
    Set-Location backend;
    yarn start;
}

function sb-d() {
    Set-Location backend;
    yarn dev;
}


function sa() {
    Set-Location admin;
    yarn start;
}



function ..() {
    Set-Location ..
}

function ..ls() {
    Set-Location ..
    Get-ChildItem
}


function ...() {
    Set-Location ..
    Set-Location ..
}

function ...ls() {
    Set-Location ..
    Set-Location ..
    Get-ChildItem
}


function ....() {
    Set-Location ..
    Set-Location ..
    Set-Location ..
}

function ....ls() {
    Set-Location ..
    Set-Location ..
    Set-Location ..
    Get-ChildItem
}


function rs() {
    python manage.py runserver
}

function mm() {
    python manage.py makemigrations
}

function m() {
    python manage.py migrate
}

function mmm() {
    python manage.py migrate
    python manage.py makemigrations
}

function pinger() {
    ping -n 10000 -w 500 8.8.8.8
}


function xvenv($mode) {
    $resolved = ""
    $startPath = $PATH

    if ($mode -eq "ml") {
        $resolved = "C:/CodingInstallations/penv/ml"
        Set-Location $resolved;
    }
    elseif ($mode -eq "cloud") {
        $resolved = "C:/CodingInstallations/penv/cloud"
        Set-Location $resolved;
    }
    else {
        $resolved = Join-Path -Path $PATH -ChildPath "xvenv"
    }
    
    $status = Test-Path "xvenv"


    if ($status -eq $false) {
        return "not xvenvable"
    }
    if ($status -eq $true) {
        try {
            Set-Location "xvenv\Scripts"
            .\activate
            Write-Output "activated xvenv $resolved";
            Set-Location ..
            Set-Location ..
        }
        catch {
            Write-Output "error xvenv"
        }
    }

    if ($mode) {
        Set-Location $startPath;
    }

}

function venv() {

    $x = Join-Path -Path $PATH -ChildPath "venv"
    $status = Test-Path "venv"

    if ($status -eq $false) {
        return "not venvable"
    }
    if ($status -eq $true) {
        try {
            Set-Location "venv\Scripts"
            .\activate
            Write-Output "activated venv $x";
            Set-Location ..
            Set-Location ..
        }
        catch {
            Write-Output "error venv"
        }
    }
}


function devenv() {

    $x = Join-Path -Path $PATH -ChildPath "venv"
    $status = Test-Path "venv"

    if ($status -eq $false) {
        return "not venvable"
    }
    if ($status -eq $true) {
        try {
            Set-Location "venv\Scripts" 
            deactivate
            Write-Output "deactivated venv $x";
            Set-Location ..
            Set-Location ..
        }
        catch {
            Write-Output "error venv"
        }
    }
}

function git-orka() {	
    git config --global user.name "orkait"
    git config --global user.email "orkaitsolutions@gmail.com"
    Write-Output "git switch user: orkait"
}

function git-kai() {	
    git config --global user.name "KailasMahavarkar"
    git config --global user.email "kailashmahavarkar5@gmail.com"
    Write-Output "git switch user: kailasmahavarkar"
}

function git-id() {
    git config user.name	
}

function git-revert() {
    git rm -r --cached .
    git add .
    git commit -am 'git cache cleared'
    git push
}


function wsl-stop() {
    wsl --shutdown --all
    Write-Output "list of running process..."
    wsl --list --running
}


function gostart() {
    go get -u golang.org/x/tools/...
    go get -u golang.org/x/lint/golint
    go get -u golang.org/x/tools/cmd/goimports
}

function gopack($package) {
    if ($package -eq 'go-funk') {
        go get github.com/thoas/go-funk
        Write-Output "Installed go-funk: github.com/thoas/go-funk"
    }
    elseif ($package -eq 'gin') {
        go get -u github.com/gin-gonic/gin
        Write-Output "Installed gin: github.com/gin-gonic/gin"
    }
}


function gin-nodemon() {
    nodemon --exec go run main.go --signal SIGTERM
}

function gin-start() {
    CompileDaemon -color=true -command="./main.exe"
}


function em { 
    cmd /c pnpm $args
}
function emx { cmd /c pnpm dlx $args }






function split($command1, $command2) {

    if (!$command1) {
        Write-Output "command 1 is missing"
        return 
    }
    elseif (!$command2) {
        Write-Output "command 2 is missing"
        return    
    }

    $script = wt --window 0 -p "Windows Powershell" -d . powershell -noExit $command1`; split-pane --horizontal -p "Windows Powershell" -d . powershell -noExit $command2`;
    Write-Output $script
}

# this triggers my custom cli (named rook) to run 
function rook() {
    $x = $PATH
    if ($args) {
        python.exe C:\rook\rook.py $args
    }
    else {
        python.exe C:\rook\rook.py ohio
    }
    Set-Location $x
}
