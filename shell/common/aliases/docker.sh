function dnames-fn {
	for ID in $(docker ps | awk '{print $1}' | grep -v 'CONTAINER')
	do
    	docker inspect "$ID" | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
	done
}

function dip-fn {
    echo "IP addresses of all named running containers"

    for DOC in $(dnames-fn)
    do
        IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' "$DOC")
        OUT+=$DOC'\t'$IP'\n'
    done
    echo -e "$OUT" | column -t
    unset OUT
}

function dent-fn {
	docker exec -it "$1" "${2:-bash}"
}

function drun-fn {
	docker run -it "$1" "$2"
}

function dsr-fn {
	docker stop "$1";docker rm "$1"
}

function drmc-fn {
  docker rm $(docker ps --all -q -f status=exited)
}

function drmid-fn {
  imgs=$(docker images -q -f dangling=true)
  [ ! -z "$imgs" ] && docker rmi "$imgs" || echo "no dangling images."
}

# in order to do things like dex $(dlab label) sh
function dlab {
  docker ps --filter="label=$1" --format="{{.ID}}"
}


alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcr="docker compose run"
alias dent=dex-fn  # execute a bash shell inside the RUNNING <container>
alias di="docker inspect"
alias dim="docker images"
alias dip=dip-fn  # IP addresses of all running containers
alias dl="docker logs"
alias dnames=dnames-fn  # Names of all running containers
alias dps="docker ps"
alias dpsa="docker ps -a"
alias drmc=drmc-fn  # remove all exited containers
alias drmid=drmid-fn  # remove all dangling images
alias drun=drun-fn  # execute a bash shell in NEW container from <image>
alias dsp="docker system prune --all"
alias dsr=dsr-fn  # Stop and remove <container>

# Launch a random container in interactive mode
function dbash() {
docker run --rm -i -t -e TERM=xterm $2 --entrypoint /bin/bash $1
}

# grep from docker logs
## Usage: dkgrep <container name/id> <grep string>
function dkgrep() {
  docker logs "$1" 2>&1 | grep "$2" | less
}

# set docker client to a different host
function dset() {
  unset DOCKER_HOST
  export DOCKER_HOST="$1:2375"
  # checktls $1
}

# set docker client to a different host
function dunset() {
  unset DOCKER_HOST
  export DOCKER_HOST="localhost:2375"
  # checktls `hostname`
}
