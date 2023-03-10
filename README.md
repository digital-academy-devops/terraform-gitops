# terraform-gitops

Репозиторий для автоматизации управления учебной инфраструктурой в Yandex Cloud через GitHub Actions и Terraform.

## Инструкции 
- [Создание и удаление ресурсов инфрастуктуры](states/README.md)

## Структура

- `.github` - workflows и actions для автоматизации процессов 
- `states` - директория для хранения состояний
- `states/system` - состояние для системных сервисов - облака, сервисных аккаунтов, git репозитория и т.п.

## Workflows

- [Run terraform](https://github.com/digital-academy-devops/terraform-gitops/actions/workflows/terraform.yaml) 
  
  Осуществляет проверку изменившихся состояний, планирования изменений (`terraform plan`) и их применение (`terraform apply|destroy`).
  Запускается:
  - Автоматически для всех Pull request-ов. Выполнение plan является обязательной проверкой для объединения PR.
  - Вручную, принимая в качестве аргументов:
    - Путь до директории с состоянием, `states/<name>`
    - Тип операции - `apply` | `destroy`
  - Автоматически при объединении изменений в ветку `main`. 
    Выполнение `apply` осуществляется на данном этапе и **требует ручного подтверждения администратора**.
- [Expire states](https://github.com/digital-academy-devops/terraform-gitops/actions/workflows/expire.yaml)
  
  На основании метаданных, для директорий состояний с истекшим Time to live (TTL) создаёт PR для удаления созданной в нём инфраструктуры.
  Код остаётся в репозитории и инфраструктура может быть пересоздана при необходимости.

  Запускается по расписанию.  
  
- [Label PR](https://github.com/digital-academy-devops/terraform-gitops/actions/workflows/label.yaml)

  Осуществляет пре-валидацию метаданных и маркировку PR.

## Метаданные 
Жизненный цикл директорий состояний контролируется набором файлов метаданных:
- `.ttl`
    
    Содержит конфигурацию срока жизни ресурсов в формате принимаемым `date -d`. Определяется при добавлении директории состояния, используется для определения `.expires_at`. 

    По умолчанию `4 hours`.
- `.destroy`

    При автоматическом выполнении [Run terraform](#workflows) наличие этого файла определяет операцию как `destroy`, а не `apply`. 
    Содержимое может быть пустым. Используется [Expire states](#workflows), в этом случае внутрь файлы добавляется время маркировки для удаления.

- `.expires_at`
    
  Содержит дату в формате Epoch, после которой истекает TTL директории. 
  
  Создаётся автоматически в [Run terraform](#workflows) после выполнения операции `apply` на основании `.ttl`.

  Добавляется [Expire states](#workflows).
