# <center>Homework 9 walkthrough</center>
# Task 1
## Step 1. Preparing server and client VM's
### Vagrantfile 
    Vagrant.configure("2") do |config|
        config.vm.provision "file", source: "~/.ssh/id_ed25519", destination: "~/.ssh/id_ed25519"
        config.vm.provision "shell", :inline =>
        "mkdir /root/.ssh"
        config.vm.provision "file", source: "~/.ssh/id_ed25519", destination: "/root/.ssh/id_ed25519"
        config.vm.provision "file", source: "~/.ssh/id_ed25519.pub", destination: "~/.ssh/id_ed25519.pub"
        config.vm.provision "file", source: "~/.ssh/id_ed25519.pub", destination: "root/.ssh/id_ed25519.pub"
        config.vm.provision "shell", :inline => 
        "cat /home/vagrant/.ssh/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys && chown -R vagrant:vagrant ~/.ssh
        cat /root/.ssh/id_ed25519.pub >> /root/.ssh/authorized_keys"
    
        config.vm.define "cent-serv" do |serv|
            serv.vm.box = "centos/7"
            serv.vm.hostname = "hw9-server"
            serv.vm.network "private_network", ip: "192.168.82.20", bridge: "en0: Wi-Fi"
            serv.vm.provision "shell", :inline =>
            "sudo yum install -y epel-release
            sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
            sudo yum update -y
            sudo yum install -y nano
            sudo yum install -y nginx
            sudo yum install -y rsync
            sudo yum install -y lsyncd
            mkdir /home/vagrant/backup" 
            serv.vm.provider "virtualbox" do |v|
                v.memory = 512
                v.cpus = 1
                v.name = "hw9-server"
            end
        end

        config.vm.define "cent-cli" do |cli|
            cli.vm.box = "centos/7"
            cli.vm.hostname = "hw9-client"
            cli.vm.network "private_network", ip: "192.168.82.2", bridge: "en0: Wi-Fi"
            cli.vm.provision "shell", path: "script.sh"
            cli.vm.provision "shell", :inline =>
            "sudo yum install -y epel-release
            sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
            sudo yum update -y
            sudo yum install -y nano
            sudo yum install -y rsync
            sudo yum install -y lsyncd" 
            cli.vm.provider "virtualbox" do |v|
                v.memory = 512
                v.cpus = 1
                v.name = "hw9-client"
            end
        end
    end

### script for client  
    mkdir /home/vagrant/data
    mkdir /home/vagrant/data/dir{1..5}
    dirs=(dir1 dir2 dir3 dir4 dir5)
    for i in "${dirs[@]}"; do
        sudo touch /home/vagrant/data/"$i"/file{1..3}
    done
    sudo chown -R vagrant:vagrant ~/data

# Step 2. rsyncd.conf for client
    [data_backup]
        path = /home/vagrant/data
        comment = data-folder backup for hw9
        log file = /var/log/rsyncd.log
        pid file = /var/run/rsyncd.pid
        syslog facility = daemon
        read only = false
        uid = nobody
        gid = nobody
        adress = 192.168.82.20

# Step 3. rsyncd.conf for server
    [data_backup]
        path = /home/vagrant/data
        comment = data-folder backup for hw9
        log file = /var/log/rsyncd.log
        pid file = /var/run/rsyncd.pid
        syslog facility = daemon
        read only = false
        uid = nobody
        gid = nobody
        adress = 192.168.82.2

# Step 4. rsync client to server data buckup log and setting crontab 
    [vagrant@hw9-server ~]$ rsync -av hw9-client:/home/vagrant/data/ /home/vagrant/backup
    Enter passphrase for key '/home/vagrant/.ssh/id_ed25519': 
    receiving incremental file list
    ./
    dir1/
    dir1/file1
    dir1/file2
    dir1/file3
    dir2/
    dir2/file1
    dir2/file2
    dir2/file3
    dir3/
    dir3/file1
    dir3/file2
    dir3/file3
    dir4/
    dir4/file1
    dir4/file2
    dir4/file3
    dir5/
    dir5/file1
    dir5/file2
    dir5/file3

    sent 336 bytes  received 954 bytes  368.57 bytes/sec
    total size is 0  speedup is 0.00
    [vagrant@hw9-server ~]$ ls ~/backup
    dir1  dir2  dir3  dir4  dir5
    [vagrant@hw9-server ~]$ crontab -e
    no crontab for vagrant - using an empty one
    crontab: installing new crontab
    [vagrant@hw9-server ~]$ crontab -l
    */5 * * * * rsync -av hw9-client:/home/vagrant/data/ /home/vagrant/backup
    [vagrant@hw9-server ~]$

# Task 2. Setting up lsyncd.conf server's file

    settings  {
        logfile = "/var/log/lsyncd/lsyncd.log",
        statusFile = "/var/log/lsyncd/lsyncd.status"
    }
    sync {
        default.rsyncssh,
        source = "/home/vagrant/data",
        host = "hw9-server",
        targetdir = "/home/vagrant/backup",
        delay = 5,
        rsync = {
        owner = true,
        group = true,
        perms = true
        }     
    }

# Task 3. /etc/logrotate.d/nginx editing

    /var/log/nginx/*.log {
        create 0640 nginx root
        weekly
        rotate 10
        missingok
        notifempty
        compress
        compresscmd /bin/bzip2
        compressext .bz2
        delaycompress
        sharedscripts
        size 1024k
        copytruncate
        create 700 vagrant vagrant
        datext
        rotate 15
        maxage 100
        postrotate
            /bin/kill -USR1 `cat /run/nginx.pid 2>/dev/null` 2>/dev/null || true
        endscript
    }