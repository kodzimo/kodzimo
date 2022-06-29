# Final log of lesson18.yml playbook

    (ansible) vagrant@ansible:~/ansible/infra_repo$ ansible-playbook ansible/playbooks/lesson18.yml

    PLAY [HW18 playbook] ********************************************************************************************************************************************************************************************

    TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
    ok: [centos]
    ok: [ubuntu]

    TASK [Print the environment of host] ****************************************************************************************************************************************************************************
    ok: [centos] => {
        "msg": "This host centos is in stage environment"
    }
    ok: [ubuntu] => {
        "msg": "This host ubuntu is in stage environment"
    }

    TASK [Include the common role] **********************************************************************************************************************************************************************************

    TASK [common : include_tasks] ***********************************************************************************************************************************************************************************
    skipping: [centos]
    included: /home/vagrant/ansible/infra_repo/roles/common/tasks/update_packages_deb.yml for ubuntu

    TASK [common : Upgrading all apt packages (removing old if needed)] *********************************************************************************************************************************************
    ok: [ubuntu]

    TASK [common : include_tasks] ***********************************************************************************************************************************************************************************
    skipping: [ubuntu]
    included: /home/vagrant/ansible/infra_repo/roles/common/tasks/update_packages_rh.yml for centos

    TASK [common : Yum update] **************************************************************************************************************************************************************************************
    ok: [centos]

    TASK [common : include_tasks] ***********************************************************************************************************************************************************************************
    included: /home/vagrant/ansible/infra_repo/roles/common/tasks/user_creation.yml for centos, ubuntu

    TASK [common : Create group "students"] *************************************************************************************************************************************************************************
    ok: [centos]
    ok: [ubuntu]

    TASK [common : Create user "student"] ***************************************************************************************************************************************************************************
    ok: [centos]
    ok: [ubuntu]

    TASK [common : opt/student directory creation] ******************************************************************************************************************************************************************
    ok: [centos]
    ok: [ubuntu]

    TASK [common : make student nopasswd sudoer] ********************************************************************************************************************************************************************
    ok: [centos]
    ok: [ubuntu]

    TASK [Include the jdauphant.nginx role] *************************************************************************************************************************************************************************

    TASK [jdauphant.nginx : include_vars] ***************************************************************************************************************************************************************************
    ok: [centos] => (item=/home/vagrant/ansible/infra_repo/.imported_roles/jdauphant.nginx/vars/../vars/RedHat.yml)
    ok: [ubuntu] => (item=/home/vagrant/ansible/infra_repo/.imported_roles/jdauphant.nginx/vars/../vars/Debian.yml)

    TASK [jdauphant.nginx : include_tasks] **************************************************************************************************************************************************************************
    skipping: [ubuntu]
    included: /home/vagrant/ansible/infra_repo/.imported_roles/jdauphant.nginx/tasks/selinux.yml for centos

    TASK [jdauphant.nginx : Install the selinux python module] ******************************************************************************************************************************************************
    changed: [centos]

    TASK [jdauphant.nginx : Set SELinux boolean to allow nginx to set rlimit] ***************************************************************************************************************************************
    changed: [centos]

    TASK [jdauphant.nginx : include_tasks] **************************************************************************************************************************************************************************
    skipping: [centos]
    skipping: [ubuntu]

    TASK [jdauphant.nginx : include_tasks] **************************************************************************************************************************************************************************
    included: /home/vagrant/ansible/infra_repo/.imported_roles/jdauphant.nginx/tasks/installation.packages.yml for centos, ubuntu

    TASK [jdauphant.nginx : Install the epel packages for EL distributions] *****************************************************************************************************************************************
    skipping: [ubuntu]
    ok: [centos]

    TASK [jdauphant.nginx : Install the nginx packages from official repo for EL distributions] *********************************************************************************************************************
    skipping: [centos]
    skipping: [ubuntu]

    TASK [jdauphant.nginx : Install the nginx packages for all other distributions] *********************************************************************************************************************************
    ok: [centos]
    ok: [ubuntu]

    TASK [jdauphant.nginx : Create the directories for site specific configurations] ********************************************************************************************************************************
    changed: [centos] => (item=sites-available)
    ok: [ubuntu] => (item=sites-available)
    changed: [centos] => (item=sites-enabled)
    ok: [ubuntu] => (item=sites-enabled)
    changed: [ubuntu] => (item=auth_basic)
    changed: [centos] => (item=auth_basic)
    ok: [ubuntu] => (item=conf.d)
    ok: [centos] => (item=conf.d)
    changed: [ubuntu] => (item=conf.d/stream)
    changed: [centos] => (item=conf.d/stream)
    ok: [ubuntu] => (item=snippets)
    changed: [centos] => (item=snippets)
    ok: [ubuntu] => (item=modules-available)
    changed: [centos] => (item=modules-available)
    ok: [ubuntu] => (item=modules-enabled)
    changed: [centos] => (item=modules-enabled)

    TASK [jdauphant.nginx : Ensure log directory exist] *************************************************************************************************************************************************************
    ok: [ubuntu]
    changed: [centos]

    TASK [jdauphant.nginx : include_tasks] **************************************************************************************************************************************************************************
    included: /home/vagrant/ansible/infra_repo/.imported_roles/jdauphant.nginx/tasks/remove-defaults.yml for centos, ubuntu

    TASK [jdauphant.nginx : Disable the default site] ***************************************************************************************************************************************************************
    changed: [ubuntu]
    ok: [centos]

    TASK [jdauphant.nginx : Disable the default site (on newer nginx versions)] *************************************************************************************************************************************
    skipping: [centos]
    skipping: [ubuntu]

    TASK [jdauphant.nginx : Remove the default configuration] *******************************************************************************************************************************************************
    ok: [centos]
    ok: [ubuntu]

    TASK [jdauphant.nginx : include_tasks] **************************************************************************************************************************************************************************
    skipping: [centos]
    skipping: [ubuntu]

    TASK [jdauphant.nginx : Remove unwanted sites] ******************************************************************************************************************************************************************

    TASK [jdauphant.nginx : Remove unwanted conf] *******************************************************************************************************************************************************************

    TASK [jdauphant.nginx : Remove unwanted snippets] ***************************************************************************************************************************************************************

    TASK [jdauphant.nginx : Remove unwanted auth_basic_files] *******************************************************************************************************************************************************

    TASK [jdauphant.nginx : Copy the nginx configuration file] ******************************************************************************************************************************************************
    changed: [centos]
    changed: [ubuntu]

    TASK [jdauphant.nginx : Ensure auth_basic files created] ********************************************************************************************************************************************************

    TASK [jdauphant.nginx : Create the configurations for sites] ****************************************************************************************************************************************************
    changed: [centos] => (item={'key': 'default', 'value': ['listen 80', 'location / { proxy_pass http://http.cat; }']})
    changed: [ubuntu] => (item={'key': 'default', 'value': ['listen 80', 'location / { proxy_pass http://http.cat; }']})

    TASK [jdauphant.nginx : Create links for sites-enabled] *********************************************************************************************************************************************************
    changed: [centos] => (item={'key': 'default', 'value': ['listen 80', 'location / { proxy_pass http://http.cat; }']})
    changed: [ubuntu] => (item={'key': 'default', 'value': ['listen 80', 'location / { proxy_pass http://http.cat; }']})

    TASK [jdauphant.nginx : Create the configurations for independent config file] **********************************************************************************************************************************

    TASK [jdauphant.nginx : Create configuration snippets] **********************************************************************************************************************************************************

    TASK [jdauphant.nginx : Create the configurations for independent config file for streams] **********************************************************************************************************************

    TASK [jdauphant.nginx : Create links for modules-enabled] *******************************************************************************************************************************************************

    TASK [jdauphant.nginx : include_tasks] **************************************************************************************************************************************************************************
    skipping: [centos]
    skipping: [ubuntu]

    TASK [jdauphant.nginx : include_tasks] **************************************************************************************************************************************************************************
    skipping: [centos]
    skipping: [ubuntu]

    TASK [jdauphant.nginx : Start the nginx service] ****************************************************************************************************************************************************************
    ok: [ubuntu]
    changed: [centos]

    RUNNING HANDLER [jdauphant.nginx : restart nginx] ***************************************************************************************************************************************************************
    changed: [centos] => {
        "msg": "checking config first"
    }
    changed: [ubuntu] => {
        "msg": "checking config first"
    }

    RUNNING HANDLER [jdauphant.nginx : reload nginx] ****************************************************************************************************************************************************************
    changed: [ubuntu] => {
        "msg": "checking config first"
    }
    changed: [centos] => {
        "msg": "checking config first"
    }

    RUNNING HANDLER [jdauphant.nginx : check nginx configuration] ***************************************************************************************************************************************************
    ok: [centos]
    ok: [ubuntu]

    RUNNING HANDLER [jdauphant.nginx : restart nginx - after config check] ******************************************************************************************************************************************
    changed: [centos]
    changed: [ubuntu]

    RUNNING HANDLER [jdauphant.nginx : reload nginx - after config check] *******************************************************************************************************************************************
    changed: [centos]
    changed: [ubuntu]

    PLAY RECAP ******************************************************************************************************************************************************************************************************
    centos                     : ok=30   changed=12   unreachable=0    failed=0    skipped=16   rescued=0    ignored=0
    ubuntu                     : ok=26   changed=9    unreachable=0    failed=0    skipped=18   rescued=0    ignored=0

    (ansible) vagrant@ansible:~/ansible/infra_repo$