# add postgresql
FROM postgresql:latest
RUN echo "create user"
# build all modules
RUN psql -v ON_ERROR_STOP=1 --username "sourcehut" <<-EOSQL
	    CREATE USER metasrht;
	    CREATE DATABASE metasrht;
	    GRANT ALL PRIVILEGES ON DATABASE metasrht TO metasrht;
EOSQL

# add redis
FROM redis:latest

FROM alpine:3.15
RUN sed -i '$a https://mirror.sr.ht/alpine/v3.15/sr.ht' /etc/apk/repositories
RUN wget -q -O /etc/apk/keys/alpine@sr.ht.rsa.pub https://mirror.sr.ht/alpine/alpine@sr.ht.rsa.pub
RUN apk update
# add all modules
RUN apk add meta.sr.ht git.sr.ht hg.sr.ht builds.sr.ht lists.sr.ht man.sr.ht paste.sr.ht todo.sr.ht
# END
COPY ./start.sh /
RUN chmod +x /start.sh
CMD ["/bin/sh", "start.sh","meta.sr.ht"]

FROM nginx:latest