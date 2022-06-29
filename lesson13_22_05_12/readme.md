
# <center>**Backup script moderation**</center>

## 1. Было принято решение выделить 2 блока скрипта: первый блок - сценарий ручного запуска, второй блок - запуск скрипта cron'ом.<p>
  
## 2. Сравним проверку наличия параметров скрипта в обоих блоках.

    # check script parameters
    if [[ $# -ne 1 ]]; then
        echo "Формат ручного запуска: $0 <path>"
        echo "$(date) \033[1;31mERROR:\033[0m Script started manually by $user with wrong parameter" >> "$log"
        exit $err
    fi  
---
    # check cron task script parameters
    if [[ $# -ne 2 ]]; then
        echo "Формат автоматического запуска: $0 <path> <mode>. Перенастройте таску, запустив её вручную"
        echo "$(date) \033[1;31mERROR:\033[0m Script started by crontask from $user with wrong parameters" >> "$log"
        exit $err
    else
        mode=$2
    fi

## 3. Проверка существования указанной директории продублирована в оба блока.

    # check dir
    if [[ ! -d "$1" ]]; then
        echo "Каталог \"$1\" не существует" | tee -a "$log"
        exit $err
    else
        dir=$1
    fi

## 4. Select mode выделен отдельно при запуске вручную и используется для объявления переменных при запуске cron'ом.

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
---
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

## 5. В остальном добавлено минимум визуализации, прописана запись сообщений скрипта в лог.