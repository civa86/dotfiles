# ALIAS
alias ll='ls -al'
alias gifify='docker run -v $(pwd):/data civa86/gifify-light'
alias dotnet-dev='docker run -it -v $(pwd):/app -p 5000:5000 civa86/dotnet-dev'

# MySQL
alias mysql-start='docker run -d --name mysql-local -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 mysql:8.0'
alias mysql-stop='docker stop mysql-local && docker rm mysql-local'
alias mysql-logs='docker logs -f mysql-local'
alias mysql-logs='docker logs -f mysql-local'
alias mysql-client='docker run -it mysql:5.7 mysql'

#MongoDB
alias mongo-start='docker run -d --name mongo-local -p 27017:27017 mongo:4.0'
alias mongo-stop='docker stop mongo-local && docker rm mongo-local'
