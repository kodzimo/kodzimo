#!/bin/bash

# Скрипт бэкапа папки с данными.
# Папка передается скрипту в качестве параметра при запуске.
# Скрипт работает в трех в различных режимах:
# - ежеминутный бэкап, формат выходного файла YYYY-MM-DD-HH:MM:SS.ms.zip (с указанием миллисекунд в имени)
# - ежечасный бэкап, формат выходного файла YYYY-MM-DD-HH:MM.zip
# - ежедневный бекап, формат выходного файла YYYY-MM-DD.zip
# Скрипт включает метафайл с информацией:
# - кто и когда запустил скрипт,
# - список всех файлов в архиве.
# 
# При запуске вручную скрипт ТОЛЬКО инсталлирует себя и все необходимые компоненты в систему и добавляет задание в crontab.
# Запуск бекапирования запускается только из cron.
# Скрипт выполняет логирование своей работы.

err=1
ext=0
packages=(zip unzip cronie)
user=$(whoami)
log="/tmp/backup.log"

# -t - True if file descriptor FD is open and refers to a terminal.
if [[ -t 1 ]] ; then
    # check script parameters
    if [[ $# -ne 1 ]]; then
        echo "Формат ручного запуска: $0 <path>"
        echo "$(date) \033[1;31mERROR:\033[0m Script started manually by $user with wrong parameter" >> "$log"
        exit $err
    fi

    echo "$(date) Script started manually from terminal by $user" >> "$log"    
    
    # check dir
    if [[ ! -d "$1" ]]; then
        echo "Каталог \"$1\" не существует" | tee -a "$log"
        exit $err
    else
        dir=$1
    fi

    # select mode
    echo -e "Select backup mode (1 - minutely, 2 - hourly, 3 - daily)"
    read -r mode
    case $mode in
        1 | minutely)
            echo -en "\033[1;32mBackup mode is $mode\033[0m" | tee -a "$log"
            arch_name=$(date +%Y-%d-%m-%T.%N)
            cron_time="* * * * *"
        ;;
        2 | hourly)
            echo -en "\033[1;32mBackup mode is $mode\033[0m" | tee -a "$log"
            arch_name=$(date +%Y-%d-%m-%T)
            cron_time="0 * * * *"
        ;;
        3 | daily)
            echo -en "\033[1;32mBackup mode is $mode\033[0m" | tee -a "$log"
            arch_name=$(date +%Y-%d-%m)
            cron_time="0 0 * * *"
        ;;
        *)
            echo -en "\033[1;31mERROR.\033[0m Please restart script and select proper mode" | tee -a "$log"
            exit $err
        ;;
    esac

    # install component
    for package in "${packages[@]}"; do
        if yum info "$package" | grep -q Repo; then
            echo "$package presents in system" | tee -a "$log"
        else
           sudo yum makecache && sudo yum install -y "$package"
           echo "$package was absent and now is installed" | tee -a "$log"
        fi
    done

    script_path="/tmp/${0##*/}"
    cp "$0" "$script_path"
    echo "Scrypt path is $script_path" | tee -a "$log" 
    crontab -l | { cat; echo "$cron_time $script_path $dir"; } | crontab -
    echo "Cron task is $cron_time $script_path $dir in mode $mode" | tee -a "$log"

else
    # check cron task script parameters
    if [[ $# -ne 2 ]]; then
        echo "Формат автоматического запуска: $0 <path> <mode>. Перенастройте таску, запустив её вручную"
        echo "$(date) \033[1;31mERROR:\033[0m Script started by crontask from $user with wrong parameters" >> "$log"
        exit $err
    else
        mode=$2
    fi

    # check cron task directory existence
    if [[ ! -d "$dir" ]]; then
        echo "Каталог \"$dir\" не существует" | tee -a "$log"
        exit $err
    else
        dir=$1
    fi

    echo "$(date) Script started automatically in mode \"$mode\" by cron" | tee -a "$log"

    # peviously selected mode
    case $mode in
        1 | minutely)
            echo -en "\033[1;32mBackup mode is $mode\033[0m" | tee -a "$log"
            arch_name=$(date +%Y-%d-%m-%T.%N)
            cron_time="* * * * *"
        ;;
        2 | hourly)
            echo -en "\033[1;32mBackup mode is $mode\033[0m" | tee -a "$log"
            arch_name=$(date +%Y-%d-%m-%T)
            cron_time="0 * * * *"
        ;;
        3 | daily)
            echo -en "\033[1;32mBackup mode is $mode\033[0m" | tee -a "$log"
            arch_name=$(date +%Y-%d-%m)
            cron_time="0 0 * * *"
        ;;
        *)
            echo -en "\033[1;31mERROR.\033[0m Please restart script and select proper mode" | tee -a "$log"
            exit $err
        ;;
    esac

    # create metafile
    echo "Started by $user" > "$dir/info"
    date >> "$dir/info"
    find "$dir" -type f | sort -h >> "$dir/info"

    # create archive
    zip -r "$arch_name".zip "$dir"
    echo "Archive created"
fi

exit $ext