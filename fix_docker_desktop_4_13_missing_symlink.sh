# See: https://stackoverflow.com/a/74148162

# symlink from (real) docker desktop internal socket to socket linux uses
sudo ln -s ~/Library/Containers/com.docker.docker/Data/docker.raw.sock /var/run/docker.sock

# test that it works using linked socket file
# if this commands lists your container it works, if it throws an error it does not
DOCKER_HOST=unix:///var/run/docker.sock docker ps
