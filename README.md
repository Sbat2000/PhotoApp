# PhotoAppTest

## Описание

**PhotoAppTest** — это мобильное приложение для редактирования фотографий с использованием инструментов рисования и наложения текста. Приложение позволяет пользователю выбирать изображения из галереи или камеры, редактировать их с помощью различных фильтров и инструментов, а также сохранять результаты в галерею устройства.

## Функциональные возможности

- **Выбор изображения**: Возможность выбрать изображение из галереи или сделать фотографию с камеры.
- **Редактирование изображений**: Использование PencilKit для рисования, добавления текста и применения фильтров к изображениям.
- **Масштабирование**: Масштабирование изображения с сохранением качества и возможностью отмены/повтора изменений.
- **Аутентификация**: Возможность аутентификации пользователей с использованием Firebase Authentication.
- **Профиль пользователя**: Просмотр и редактирование профиля пользователя.

### Установка

1. Откройте проект в Xcode, запустив `PhotoAppTest.xcodeproj`.

2. Убедитесь, что все зависимости установлены с помощью Swift Package Manager (SPM).

### Запуск

- Запустите проект на симуляторе или реальном устройстве через Xcode.

### Настройки

- Включено объеденение учетных записей Firebase: если вы зарегистрируетесь через почту, а потом, не подтвердив ее зайдете через аккаунт Google - через почту вы зайти больше не сможете. Если адреc будет подтвержден перед входом через аккаунт Google - можно бует войти и через почту, и через аккаунт Google
- Доступна только светлая тема
- Если захотите привезать к своему проекту FireBase - надо заменить GoogleService-Info и поменять в Info.plist: URL Schemes (взять из REVERSED_CLIENT_ID в GoogleService-Info)


### Интерфейс

- **AuthenticationView**: Экран аутентификации, где пользователи могут войти в систему или зарегистрироваться. Также доступна кнопка для перехода к редактированию без регистрации.
- **EditorView**: Основной экран для редактирования фотографий. Пользователь может добавлять текст, рисовать и применять фильтры к выбранным изображениям.
- **ProfileView**: Экран профиля, где отображается информация о пользователе и доступна функция выхода из аккаунта.

## Архитектура

Приложение построено с использованием **MVVM** (Model-View-ViewModel) архитектуры. Основные компоненты включают:

- **ViewModel**: Управляет состоянием представлений, обрабатывает логику бизнес-процессов и взаимодействие с сервисами.
- **Views**: SwiftUI-представления, которые отвечают за отображение данных и взаимодействие с пользователем.
- **Models**: Содержат структуры данных, используемые в приложении.
- **Controller**: `AuthController` отвечает за управление аутентификацией пользователей и поддерживает их состояние.

### Навигация

Навигация в приложении осуществляется с использованием SwiftUI `NavigationView` и `NavigationLink`. Однако, в будущем хотелось бы реализовать отдельный слой навигации, чтобы лучше контролировать переходы между экранами и упростить поддержку приложения.

### Протоколы

Мы стремимся закрыть все основные компоненты протоколами для улучшения тестируемости и расширяемости кода. В текущей версии этого не реализовано из-за ограничений по времени, но это остается важной частью плана по улучшению архитектуры проекта.

## Будущие улучшения

### Планируемые доработки

- **Слой навигации**: В будущем будет реализован отдельный слой навигации, который упростит управление переходами между экранами и позволит легко изменять навигационную логику без необходимости вносить изменения в представления.
- **Протоколы для основных компонентов**: Закрытие всех основных компонентов (ViewModel, Controller) протоколами для улучшения тестируемости и поддерживаемости приложения.
- **Темная тема**.
