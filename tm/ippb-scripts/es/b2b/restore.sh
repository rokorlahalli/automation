host=<host-ip>

if [ -x "$(command -v docker)" ]; then
    echo "Docker installed"
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

mkdir -p /home/ubuntu/ippb-es/b2b

cd /home/ubuntu/ippb-es/b2b

aws s3 cp --recursive s3://ippb-migration-dump/elastic/b2b .


for index in ippb_policydetails ippb_lead ippb_prod_partner ippb_mis ippb_issuance1 
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2b:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/"$index"_analyzer.json \
    --output="http://$host:9200/$index" \
    --type=analyzer
done

curl -X POST "$host:9200/_all/_open?pretty"

for index in ippb_policydetails ippb_lead ippb_prod_partner ippb_mis ippb_issuance1
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2b:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/"$index"_mapping.json \
    --output="http://$host:9200/$index" \
    --type=mapping
done

for index in ippb_policydetails ippb_lead ippb_prod_partner ippb_mis ippb_issuance1
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2b:/tmp elasticdump/elasticsearch-dump \
    --input=/tmp/"$index"_data.json \
    --output="http://$host:9200/$index" \
    --type=data --limit=10000
done

