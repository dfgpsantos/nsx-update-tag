Instructions:

This script updates multiple NSX VM tags at once.
When using it replace the "select.list" by a VM name list containing the VMs that should be tagged.
This script is case sensitive, so please use the exactly names on that.

The template.json file will be used to tag the VMs, modify that using the desired tags.
Delete or add tag lines as you need.
It's possible to add multiple tags at once, as per version NSX-T 2.5.1 up to 25 tags per VM.

Finally, the tag-update.sh script needs to be changed in order to work in your environment, so replace the credentials in the beggining of the file with your info.

To run the script do "sh tag-update" in your bash.
2 files will be generated "before.list" and äfter.list".
Do a cat in those files if you want to check what has been changed.

Happy tagging :)

Author: David Santos
e-mail: dfgpsantos@gmail.com


