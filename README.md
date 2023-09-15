## Criação de um servidor PostgreSQL 9.6.24 dockado

### Instalar o PostgreSQL 9.6.24 a partir do código fonte
```bash
apt install wget gcc zlib1g-dev libreadline6-dev docbook-dsssl docbook libreadline-dev libperl-dev libedit-dev libpam0g-dev libpam-dev libkrb5-dev libldap2-dev libxslt1-dev libossp-uuid-dev bison flex opensp tcl-dev xsltproc linux-headers-amd64 linux-headers-$(uname -r) -y

wget --continue https://ftp.postgresql.org/pub/source/v9.6.24/postgresql-9.6.24.tar.gz
tar -xzf postgresql-9.6.24.tar.gz

cd postgresql-9.6.24/
./configure --prefix=/home/user/usr/postgresql96
make
make install
```

### Criar o diretório de dados e inicializa-lo
```bash
mkdir -p /home/user/data
cd /home/user/usr/postgresql96/bin
./initdb -D ~/data/ -U postgres

### Alterar o password padrão do PostgreSQL

#### No SO do host
```bash
docker run -v /home/user/data/:/var/lib/postgresql/data/ --rm -it --entrypoint bash postgres96
```

#### No SO do container
```bash
pg_ctl -D /var/lib/postgresql/data -l /var/lib/postgresql/pglog.log start
psql
```

#### No `psql`
```
\password

\quit
```

