# initialize docker system
# check if configuration, which is config.ini, is existed
if [ ! -f "config.ini" ]; then
  echo "config.ini not found!"
  exit -1
fi

# iterate over array which are metasrht, gitsrht, buildsrht, and so on
databases=("metasrht" "gitsrht" "buildsrht")
for db in ${databases[@]}; do
  # connect to postgresql at localhost and check if database has table metasrht
  if [ `psql -U postgres -lqt | cut -d \| -f 1 | grep -w $db | wc -l` -eq 0 ]; then
    echo "$db not found!"
    exit -1
  fi
done