$PATH = $(Get-Location).Path
oh-my-posh init pwsh --config "C:\Users\Admin\Documents\WindowsPowerShell\posh_theme.omp.json" | Invoke-Expression

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

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function FolderSize {
    param (
        [string]$FolderPath
    )

    function Convert-BytesToHumanReadable {
        param (
            [long]$Bytes
        )
        if ($Bytes -lt 1KB) {
            return "$Bytes bytes"
        } elseif ($Bytes -lt 1MB) {
            return "{0:N2} KB" -f ($Bytes / 1KB)
        } elseif ($Bytes -lt 1GB) {
            return "{0:N2} MB" -f ($Bytes / 1MB)
        } else {
            return "{0:N2} GB" -f ($Bytes / 1GB)
        }
    }

    try {
        $sizeBytes = (Get-ChildItem -Recurse -File -Path $FolderPath -ErrorAction Stop | Measure-Object -Property Length -Sum).Sum
        $humanReadableSize = Convert-BytesToHumanReadable -Bytes $sizeBytes
        return $humanReadableSize
    } catch {
        Write-Warning "Could not access path: $FolderPath. Error: $_"
        return "0 bytes"
    }
}

function treepy {
    param (
        [string]$Path = ".",
        [int]$Depth = 2,
        [string]$IncludeRegex = "",
        [string]$ExcludeRegex = "",
        [switch]$FolderOnly,
        [switch]$Sort
    )

    function Get-FolderSize {
        param (
            [string]$FolderPath
        )
        try {
            return (Get-ChildItem -Recurse -File -Path $FolderPath -ErrorAction Stop | Measure-Object -Property Length -Sum).Sum
        } catch {
            Write-Warning "Could not access path: $FolderPath. Error: $_"
            return 0
        }
    }

    function Get-TreeHelper {
        param (
            [string]$CurrentPath,
            [int]$CurrentDepth,
            [string]$Prefix = ""
        )

        if ($CurrentDepth -le 0) {
            return
        }

        $items = Get-ChildItem -Path $CurrentPath
        $filteredItems = @()

        foreach ($item in $items) {
            if ($FolderOnly -and -not $item.PSIsContainer) {
                continue
            }
            if ($IncludeRegex -and -not ($item.Name -match $IncludeRegex)) {
                continue
            }
            if ($ExcludeRegex -and ($item.Name -match $ExcludeRegex)) {
                continue
            }
            $filteredItems += $item
        }

        # Sort folders by size if the -Sort flag is used
        if ($Sort) {
            $filteredItems = $filteredItems | Sort-Object { 
                if ($_.PSIsContainer) {
                    Get-FolderSize -FolderPath $_.FullName 
                } else { 
                    $_.Length 
                } 
            } -Descending
        }

        $count = $filteredItems.Count
        for ($i = 0; $i -lt $count; $i++) {
            $item = $filteredItems[$i]
            $isLast = ($i -eq $count - 1)
            $connector = if ($isLast) { "└──" } else { "├──" }

            $output = "$Prefix$connector $($item.Name)"
            if ($Sort -and $item.PSIsContainer) {
                $output += " - $((Get-FolderSize -FolderPath $item.FullName) / 1MB) MB"
            }
            Write-Output $output

            if ($item.PSIsContainer) {
                $newPrefix = if ($isLast) { "$Prefix    " } else { "$Prefix│   " }
                Get-TreeHelper -CurrentPath $item.FullName -CurrentDepth ($CurrentDepth - 1) -Prefix $newPrefix
            }
        }
    }

    Write-Output $Path
    Get-TreeHelper -CurrentPath $Path -CurrentDepth $Depth -Prefix ""
}


function Start-Uvicorn {
    param (
        [string]$appModule,
        [string]$serverHost,
        [int]$serverPort
    )

    Start-Process -WindowStyle Hidden -FilePath "uvicorn" -ArgumentList "$appModule --host $serverHost --port $serverPort" 
    Write-Output "Started FastAPI server with uvicorn $appModule on $serverHost :$serverPort"
}

function CacheServer {
    param (
        [int]$port = 80
    )

    $venvPath = "C:/Pro/venv"

    if (-Not (Test-Path $venvPath)) {
        Write-Error "Virtual environment not found at $venvPath"
        exit 1
    }

    npx kill-port $port
    Set-Location "C:/Pro"
    venv -venvPath $venvPath
    uvicorn main:app --port=$port
}


function RemoveFoldersByRegex {
    param (
        [string]$Path = ".",
        [string]$Pattern
    )

    try {
        $folders = Get-ChildItem -Path $Path -Recurse -Directory -ErrorAction Stop | Where-Object { $_.Name -match $Pattern }
    } catch {
        return
    }

    foreach ($folder in $folders) {
        try {
            Remove-Item -Path $folder.FullName -Recurse -Force
            Write-Output "Deleted: $($folder.FullName)"
        } catch {
            Write-Warning "Failed to delete: $($folder.FullName). Error: $_"
        }
    }
}

function RemovePythonCache {
    param (
        [string]$Path = ".",
        [string]$ExcludePattern = "\\node_modules\\"
    )

    # Collect all venv directories excluding those within the ExcludePattern
    $venvFolders = Get-ChildItem -Path $Path -Recurse -Directory -Force | 
                   Where-Object { $_.Name -eq "venv" -and $_.FullName -notmatch $ExcludePattern }

    foreach ($folder in $venvFolders) {
        try {
            Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction Stop
            Write-Output "Deleted: $($folder.FullName)"
        } catch {
            Write-Warning "Failed to delete: $($folder.FullName). Error: $_"
        }
    }
}



function RemoveNodeModules {
    param (
        [string]$Path = ".",
        [string]$ExcludePattern = "\\venv\\"
    )

    # Collect all node_modules directories excluding those within the ExcludePattern
    $nodeFolders = Get-ChildItem -Path $Path -Recurse -Directory -Force | 
                   Where-Object { $_.Name -eq "node_modules" -and $_.FullName -notmatch $ExcludePattern }

    foreach ($folder in $nodeFolders) {
        try {
            # Directly delete the node_modules directory without further recursion
            Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction Stop
            Write-Output "Deleted: $($folder.FullName)"
        } catch {
            Write-Warning "Failed to delete: $($folder.FullName). Error: $_"
        }
    }
}


function RemoveNextJsCache {
    param (
        [string]$Path = ".",
        [string]$ExcludePattern = ""
    )

    # Define the folder names to be deleted
    $foldersToDelete = @("node_modules", ".next", "build", "dist")

    # Function to recursively delete folders matching the specified names
    function Remove-Folders {
        param (
            [string]$BasePath,
            [string[]]$FolderNames,
            [string]$ExcludePattern
        )
        
        $folders = Get-ChildItem -Path $BasePath -Recurse -Directory -Force | Where-Object {
            $FolderNames -contains $_.Name -and $_.FullName -notmatch $ExcludePattern
        }

        foreach ($folder in $folders) {
            try {
                Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction Stop
                Write-Output "Deleted: $($folder.FullName)"
            } catch {
                Write-Warning "Failed to delete: $($folder.FullName). Error: $_"
            }
        }
    }

    Remove-Folders -BasePath $Path -FolderNames $foldersToDelete -ExcludePattern $ExcludePattern
}


function move-back {
    param (
        [string]$path
    )

    # Check if the path is empty
    if (-not $path) {
        Write-Error "No path provided. Please provide a valid path."
        return
    }

    # Resolve the full path to the directory to move
    try {
        $sourceDir = Resolve-Path -Path $path -ErrorAction Stop
    } catch {
        Write-Error "Cannot find path '$path'. Please provide a valid path."
        return
    }

    # Get the current directory
    $currentDir = Get-Location

    # Get the name of the directory to move
    $folderName = Split-Path -Path $sourceDir -Leaf

    # Construct the destination path
    $destinationDir = Join-Path -Path $currentDir -ChildPath $folderName

    # Check if the source directory exists
    if (-not (Test-Path -Path $sourceDir -PathType Container)) {
        Write-Error "Source directory does not exist: $sourceDir"
        return
    }

    # Check if a directory with the same name already exists at the destination
    if (Test-Path -Path $destinationDir) {
        Write-Error "A directory with the name '$folderName' already exists in the current directory: $destinationDir"
        return
    }

    # Move the directory to the current directory
    Move-Item -Path $sourceDir -Destination $currentDir -Force
    Write-Host "Moved '$sourceDir' to '$currentDir'"
}



