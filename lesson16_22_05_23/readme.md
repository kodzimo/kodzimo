# Flow projects comparison
|   |Git Flow   |GitHub Flow   |GitLab Flow   |Trunk Based Development   |
|-|-----|--------|----|---|
|Суть|Используется две ветки для записи истории проекта. main -  официальная история проекта,  в develop интегрируются новые функции. Feature Branch Workflow. Репозитории локально и на сервере.|Для работы над чем-либо создаётся одноименная ветвь из main. Репозитории локально и на сервере. Pull requests. После merge в main изменённый проект выходит на продакшн.|Для работы над чем-либо создаётся одноименная ветвь из main. Репозитории локально и на сервере. Pull requests. Отдельная ветка для каждого релиза, который не вливается в parent.|Branch By Abstraction: Вместо создания ветки для фич, создаётся ветка на изменение одной абстракции. Feature Flags. Continuous Code Review.|
|Используемые ветки|main release develop feature|main "any_current_work"|production pre-production main "any_current_work"|main "any_current_work"|
|Функции|В одноименной ветке на основе develop, вливается назад в develop.|В одноименной ветке на основе main, вливается назад в main|Последоватльно тестируется и сливается в main pre-production и production|Feature Flags. Шаринг кода между недоработанными фичами, за счет мержа всего кода в main.|
|Хотфиксы|В одноименной ветке на основе develop, вливается назад в develop.|так же|В одноименной ветке на основе production. Cливается с main. Попадает в production через слияние других веток. Создаётся tag с улучшениями. Либо cherry-pick.|main всегда готов к деплою, даже если в нем есть недоработанные фичи|
|Версии проекта|Когда в ветку develop уже слито достаточно нового кода для релиза, от ветки develop создается ветка release, которую шлифуют. release сливается в main|После merge в main изменённый проект выходит на продакшн|При слиянии с production в ней ставится tag|Адаптивно|
|Частота релизов|Через 4-5 недель|По мере выполнения работы|По мере выполнения работы|Как можно чаще|
|Примеры|не нашёл|не нашёл|не нашёл|не нашёл|


