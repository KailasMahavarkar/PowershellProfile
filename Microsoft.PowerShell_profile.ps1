$PATH = $(Get-Location).Path


function aliases(){
    echo "Name         Value"
    echo "-----        ------------------------------------"
    echo "ys           yarn start"
    echo "sf           yarn start | frontend"
    echo "sb           yarn start | backend"
    echo "rs           python manage.py runserver"
    echo "m            Django migrate"
    echo "mm           Django makemigrations"
    echo "mmm          Django migrate & makemigrations"
    echo "ping         Ping -n 10000 -w 500 8.8.8.8"
    echo "venv         Check and start python venv"
    echo "devenv       Check and stop python venv"
    echo "-----        ------------------------------------"
    echo "..           cd .."
    echo "...          cd .. >> cd .."
    echo "....         cd .. >> cd .. >> cd .."
    echo "..ls         cd .. >> ls"
}

function ys(){
    yarn start;
}

function sf(){
    cd frontend;
    yarn start;
}
function sb(){
    cd backend;
    yarn start;
}


function ..(){
    cd ..
}

function ..ls(){
    cd ..
    ls
}


function ...(){
    cd ..
    cd ..
}

function ...ls(){
    cd ..
    cd ..
    ls
}


function ....(){
    cd ..
    cd ..
    cd ..
}

function ....ls(){
    cd ..
    cd ..
    cd ..
    ls
}

function ~(){
    cd ~
}


function rs(){
    python manage.py runserver
}

function mm(){
    python manage.py makemigrations
}

function m(){
    python manage.py migrate
}

function mmm(){
    python manage.py migrate
    python manage.py makemigrations
}

function pinger(){
    ping -n 10000 -w 500 8.8.8.8
}


function venv(){

    $x = Join-Path -Path $PATH -ChildPath "venv"
    $status = Test-Path "venv"

    if ($status -eq $false){
        return "not venvable"
    }
    if ($status -eq $true){
       try{
            cd "venv\Scripts"
            .\activate
            echo "activated venv $x";
            cd ..
            cd ..
       }catch{
            echo "error venv"
       }
    }
}



function devenv(){

    $x = Join-Path -Path $PATH -ChildPath "venv"
    $status = Test-Path "venv"

    if ($status -eq $false){
        return "not venvable"
    }
    if ($status -eq $true){
       try{
            cd "venv\Scripts" 
            deactivate
            echo "deactivated venv $x";
            cd ..
            cd ..
       }catch{
            echo "error venv"
       }
    }
}