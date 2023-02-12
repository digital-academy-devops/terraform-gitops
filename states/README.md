# Инструкции

## Общие положения
- Вся инфраструктура создаётся в едином [облаке](https://cloud.yandex.ru/docs/resource-manager/concepts/resources-hierarchy#cloud) - [states/system/setup.tf](https://github.com/digital-academy-devops/terraform-gitops/blob/readme/states/system/setup.tf#L44)
- Каждый участник добавляет инфраструктуру в отдельном [каталоге](https://cloud.yandex.ru/docs/resource-manager/concepts/resources-hierarchy#folder) внутри облака.
- В качестве имени каталога используйте свои имя и фамилию, например `mostashkin`.
- Применение любых изменений требует ручного подтверждения администратора.
- Каждый PR может содержать изменения только для **одной** директории состояний.

## Создание инфраструктуры

### Создание каталога

1. [Добавьте ресурс](https://github.com/digital-academy-devops/terraform-gitops/blob/readme/states/system/folder.tf#L1) для создания каталога в системном состоянии - [states/system/folder.tf](states/system/folder.tf)
1. [Добавьте output](https://github.com/digital-academy-devops/terraform-gitops/blob/readme/states/system/folder.tf#L9) с id каталога для последующего использования в конфигурации провайдера.
1. [Создайте PR](https://github.com/digital-academy-devops/terraform-gitops/pull/17) и объедените его, убедитесь что изменения применены без ошибок.

> Пример PR: https://github.com/digital-academy-devops/terraform-gitops/pull/17

### Создание директории для каталога

1. Добавьте директорию в [states](states)
1. В конфигцрации провайдера, [используйте](https://github.com/digital-academy-devops/terraform-gitops/blob/readme/states/mostashkin/setup.tf#L42) output c id каталога, созданный ранее.
1. [В конфигурации состояния](https://github.com/digital-academy-devops/terraform-gitops/blob/readme/states/system/folder.tf#L9), установите имя вашего каталога/директории для корректного хранения его состояния внутри [бакета с состояниями](https://github.com/digital-academy-devops/terraform-gitops/blob/readme/states/mostashkin/setup.tf#L14).
1. Определите все необходимые ресурсы в [коде terraform внутри созданой директории](https://github.com/digital-academy-devops/terraform-gitops/tree/readme/states/mostashkin).
1. [Определите TTL каталога](https://github.com/digital-academy-devops/terraform-gitops/blob/readme/states/mostashkin/.ttl) при помощи [файла метаданных](../README.md#метаданные) `.ttl`
1. [Добавьте себя в codeowners](https://github.com/digital-academy-devops/terraform-gitops/blob/readme/.github/CODEOWNERS#L6) для создаваемой директории. 
Главным образом это необходимо для добавления вас в автоматически создаваемые PR для удаления ресурсов по истечении срока жизни каталога.
1. [Создайте PR](https://github.com/digital-academy-devops/terraform-gitops/pull/18) и объедените его, убедитесь что изменения применены без ошибок. 

> Пример PR: https://github.com/digital-academy-devops/terraform-gitops/pull/18

### Применение изменений директории
- Осуществляется автоматически при объеденении изменений в `main`.
- Без изменения кода через ручной запуск [Run terraform](https://github.com/digital-academy-devops/terraform-gitops/actions/workflows/terraform.yaml)

### Удаление ресурсов для директории

- Осуществляется автоматически при объеденении изменений в `main` при наличии в директории [файла метаданных](../README.md#метаданные) `.destroy`.
- Через ручной запуск [Run terraform](https://github.com/digital-academy-devops/terraform-gitops/actions/workflows/terraform.yaml)