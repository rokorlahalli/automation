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

mkdir -p /home/ubuntu/ippb-es/b2b

for index in ippb_issuance1 tataaig_mis dbs_mis hdfcbank_mis axisbank_mis bandhanbank_mis aviva_mis ippb_prod_partner idfcfirstbank_mis ippb_mis unisure_mis federal_mis mashreq_mis master_mis turtlemint_mis bajajcapitalinsurance_mis ippb_policydetails ippb_lead 
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2b:/tmp elasticdump/elasticsearch-dump \
    --input="http://$host:9200/$index" \
    --output=/tmp/"$index"_analyzer.json \
    --type=analyzer
done

for index in ippb_issuance1 tataaig_mis dbs_mis hdfcbank_mis axisbank_mis bandhanbank_mis aviva_mis ippb_prod_partner idfcfirstbank_mis ippb_mis unisure_mis federal_mis mashreq_mis master_mis turtlemint_mis bajajcapitalinsurance_mis ippb_policydetails ippb_lead
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2b:/tmp elasticdump/elasticsearch-dump \
    --input="http://$host:9200/$index" \
    --output=/tmp/"$index"_mapping.json \
    --type=mapping
done

for index in ippb_issuance1 tataaig_mis dbs_mis hdfcbank_mis axisbank_mis bandhanbank_mis aviva_mis ippb_prod_partner idfcfirstbank_mis ippb_mis unisure_mis federal_mis mashreq_mis master_mis turtlemint_mis bajajcapitalinsurance_mis ippb_policydetails ippb_lead
do
  sudo docker run --net=host --rm -ti -v /home/ubuntu/ippb-es/b2b:/tmp elasticdump/elasticsearch-dump \
    --input="http://$host:9200/$index" \
    --output=/tmp/"$index"_data.json \
    --type=data
done


aws s3 cp --recursive /home/ubuntu/ippb-es/b2b s3://ippb-migration-dump/elastic/b2b/
