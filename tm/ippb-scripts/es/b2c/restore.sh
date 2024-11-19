host=<host-ip>

if [ -x "$(command -v docker)" ]; then
    echo "Docker installed"
    exit
else
    echo "Installing docker"
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
fi

mkdir -p /home/ubuntu/ippb-es/b2c

cd /home/ubuntu/ippb-es/b2c

aws s3 cp --recursive s3://ippb-migration-dump/elastic/b2c .


for index in master turtlemint
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2c:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/"$index"_analyzer.json \
    --output="http://$host:9200/$index" \
    --type=analyzer
done

curl -X POST "$host:9200/_all/_open?pretty"

for index in master turtlemint
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2c:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/"$index"_mapping.json \
    --output="http://$host:9200/$index" \
    --type=mapping
done

for index in master turtlemint
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2c:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/"$index"_data.json \
    --output="http://$host:9200/$index" \
    --type=data --limit=10000
done

