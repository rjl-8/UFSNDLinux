cat /etc/ssh/sshd_config | awk '{
    if ($1 == "#Port") {
        print "sudo vi /etc/ssh/sshd_config and uncomment Port and set to 2200"
        print "sudo service ssh restart"
    }
    if ($1 == "Port" && $2 != 2200) {
        print "sudo vi /etc/ssh/sshd_config and set Port to 2200"
        print "sudo service ssh restart"
    {
    if ($1 == "#PasswordAuthentication") {
        print "sudo vi /etc/ssh/sshd_config and uncomment PasswordAuthentication and set to no"
        print "sudo service ssh restart"
    {
    if ($1 == "PasswordAuthentication" && $2 != "no") {
        print "sudo vi /etc/ssh/sshd_config and set PasswordAuthentication to no"
        print "sudo service ssh restart"
    {
}'
