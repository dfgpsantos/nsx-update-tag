USER=admin
PASSWORD=VMware1!VMware1!
NSX=nsxapp-01a.corp.local

curl -k --user $USER:$PASSWORD https://$NSX/api/v1/fabric/virtual-machines | grep '"display_name"\|"scope"\|"tag"' > before.list

BEFORE="before.list"
echo `cat $BEFORE`

curl -k --user $USER:$PASSWORD https://$NSX/api/v1/fabric/virtual-machines | grep -w "external_id" > external.txt

curl -k --user $USER:$PASSWORD https://$NSX/api/v1/fabric/virtual-machines | grep -w "display_name" > name.txt

sed -i 's/ //g' external.txt
sed -i 's/ //g' name.txt

paste -d "" external.txt name.txt > lista.list
sed -i 's/"//g' lista.list
sed -i 's/:/,/g' lista.list

SELECT="select.list"

rm -rf filtro.list

for VM in `cat $SELECT`

do 

cat lista.list | grep $VM >> filtro.list &

done


VMLIST="filtro.list"

echo "{" > final.json

for LINE in `cat $VMLIST`

do

VMID=`echo $LINE | cut -f2 -d","`

sed s/trocar/$VMID/ template.json >> final.json & 

done

sed -i '$d' final.json

echo "}" >> final.json

curl -k --user $USER:$PASSWORD -H "Content-Type: application/json" -X POST --data @final.json https://$NSX/api/v1/fabric/virtual-machines?action=update_tags

curl -k --user $USER:$PASSWORD https://$NSX/api/v1/fabric/virtual-machines | grep '"display_name"\|"scope"\|"tag"' > after.list

AFTER="after.list"
echo `cat $AFTER`

