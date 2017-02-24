# ansible_roles_template
Sets up Ansible Playbook directory structure following roles pattern.

## Creating a new project from the template
* Involves using the `git archive` command to export a copy of the `ansible_roles_template` repo.
* Steps:
  1. `mkdir -p $PATH_TO_LOCATION_OF_NEW_PROJECT_ON_FILE_SYSTEM`
  1. `cd $PATH_TO_TEMPLATE && git archive master | tar -x -C $PATH_TO_LOCATION_OF_NEW_PROJECT_ON_FILE_SYSTEM`
  1. `cd $PATH_TO_LOCATION_OF_NEW_PROJECT_ON_FILE_SYSTEM`
  1. `./configure_playbook.sh $APP_NAME $PLAYBOOK_NAME $ROLE_NAME`
    * If satisfied, remove any directories or files called `playbook1`, `role1`, `*.BAK`
  1. `git init` -- to initialise a new repo.
  1. `git add .` -- to add current directory.
  1. `git commit -a -m "Initial import."`
  1. `git remote add origin $URL_TO_REMOTE`
  1. `git push origin master`
  1. `git branch --set-upstream-to=origin/master master`
  1. `git pull`


* Example of creating a new project called "backup_rpm_database":

```
$ pwd
/home/502001339
$ cd mq/mq_wkspc/ansible_roles_template
$ mkdir -p ../backup_rpm_database
$ git archive master | tar -x -C ../backup_rpm_database
$ cd ../backup_rpm_database/playbooks
$ ./configure_playbook.sh backup_rpm_database backup_rpm_database backup
```
* Example of output from `configure_playbook.sh`:

```
$ ./configure_playbook.sh backup_rpm_database backup_rpm_database backup
Found myself (configure_playbook.sh)...continuing...
'./playbook1.sh' -> './backup_rpm_database.sh'
ansible-playbook -i hosts playbook1.yml
'./playbook1.yml' -> './backup_rpm_database.yml'
    - role1
export APP_NAME=@@APP_NAME
'./roles/role1/files/setenv.sh' -> './roles/role1/files/setenv.sh.BAK'
    app_name: "@@APP_NAME"
'./roles/role1/tasks/main.yml' -> './roles/role1/tasks/main.yml.BAK'
'roles/role1' -> 'roles/backup'
'roles/role1/files' -> 'roles/backup/files'
'roles/role1/files/clean.sh' -> 'roles/backup/files/clean.sh'
'roles/role1/files/setenv.sh.BAK' -> 'roles/backup/files/setenv.sh.BAK'
'roles/role1/files/template.sh' -> 'roles/backup/files/template.sh'
'roles/role1/files/setenv.sh' -> 'roles/backup/files/setenv.sh'
'roles/role1/tasks' -> 'roles/backup/tasks'
'roles/role1/tasks/main.yml.BAK' -> 'roles/backup/tasks/main.yml.BAK'
'roles/role1/tasks/main.yml' -> 'roles/backup/tasks/main.yml'
```
