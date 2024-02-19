Дмитриченко Евгений Александрович
<br /> Когорта: 10
<br /> Группа: 4
<br /> Эпик: Профиль
<br /> Ссылка: https://github.com/users/s4fonovoleg/projects/1/views/1

<hr>

# Profile Flow Decomposition


## Module 1 - Профиль:

### Экран профиля

#### Вёрстка

1. Добавление цветов и изображений в Assets-репозиторий (est: 120 min, fact: x min)
2. Кнопка редактирования профиля, UIBarButtonItem (est: 20 min, fact: x min).
3. Фото пользователя, UIImageView (est: 30 min, fact: x min)
4. Имя пользователя, UILabel (est: 20 min, fact: x min)
5. Описание пользователя, UITextView (est: 30 min, fact: x min)
6. Ссылка на сайт пользователя, UILabel (est: 20 min, fact: x min)
7. Таблица с пунктами моих, избранных NFT, ссылкой на страницу пользователя, UITableView (est: 20 min, fact: x min)

#### Логика

1. Получение JSON-данных о профиле пользователя. Model (est: 40 min, fact: x min)
2. Преобразование данных в модель профиля пользователя. ViewModel (est: 20 min, fact: x min)
3. Обновление данных пользователя: фото, имя, описание пользователя, ссылки на сайт. ViewModel (est: 10 min, fact: x min)
4. Отображение обновлённых данных пользователя на экране профиля. View (est: 25 min, fact: x min)
5. Настройка перехода при нажатии на адрес сайта пользователя. View (est: 15 min, fact: x min)
6. Настройка переходов при нажатии на ячейки таблицы (didSelectRowAt). View (est: 30 min, fact: x min)
7. Настройка DataSource-методов TableView. View (est: 30 min, fact: x min)


### Экран редактирования профиля

#### Вёрстка

1. Кнопка закрытия экрана редактирования. UIButton (est: 20min, fact: x min)
2. Фото пользователя. UIImageView (est: 30min, fact: x min)
3. Надпись "Имя", UILabel (est: 15min, fact: x min)
4. Поле ввода имени пользователя. UITextField (est: 20min, fact: x min)
5. Надпись "Описание", UILabel (est: 15min, fact: x min)
6. Поле ввода Описани пользователя. UITextView (est: 30min, fact: x min)
7. Надпись "Сайт", UILabel (est: 15min, fact: x min)
8. Поле ввода сайта пользователя. UITextField (est: 20min, fact: x min)

#### Логика

1. Нажатие кнопки закрытия экрана. View (est: 20 min, fact: x min)
2. Нажатие кнопки "return" на клавиатуре. View. (est: 20 min, fact: x min)
3. Сохранение обновлённых данных пользователя. ViewModel, Model (est: 40 min, fact: x min)

### Экран сайта пользователя

#### Вёрстка

1. Представление WebView. WKWebView (est: 20 min, fact: x min)

#### Логика

1. Настрайка загрузки сайта пользователя. View (est: 10 min, fact: x min)

`Total:` 11 hr 45 min, fact: x min


## Module 2 - Мои NFT:

#### Вёрстка Экрана

1. Кнопка сортировки. UIBarButtonItem (est: 20 min, fact x min)
2. Меню сортировки. UIAlertController (est: 30 min, fact x min)
3. Заголовок экрана. Title (est: 5 min, fact x min)
4. Представление - заглушка для таблицы. UIView, UILabel (est: 25 min, fact x min)
5. Таблица с приобретенными NFT. UITableView (est: 20 min, fact x min)

#### Логика

1. Получение JSON-данных об NFT. Model (est: 40 min, fact x min)
2. Преобразование данных в модель NFT. ViewModel (est: 20 min, fact x min)
3. Обновление данных NFT. ViewModel (est: 20 min, fact x min)
4. Настройка DataSource-методов TableView. View (est: 30 min, fact x min)
5. Обновление содержимого таблицы. View (est: 10 min, fact x min)
6. Сортировка NFT. View, ViewModel (est: 40 min, fact x min)

#### Вёрстка ячейки таблицы

1. Иконка NFT. UIImageView (est: 10 min, fact x min)
2. Наименование NFT. UILabel (est: 10 min, fact x min)
3. Рейтинг NFT. UIStackView/UIImage (est: 30 min, fact x min)
4. Автор NFT. UITextView (est: 20 min, fact x min)
5. Надпись "Цена". UILabel (est: 10 min, fact x min)
6. Цена NFT. UILabel (est: 10 min, fact x min)

#### Логика

1. Заполнение элементов ячейки данными об NFT. View (est: 20 min, fact x min)

`Total:` 6 hr 10 min, fact: x min


## Module 3 - Избранные:

#### Вёрстка экрана

1. Заголовок экрана. Title (est 5 min, fact x min)
2. Представление-заглушка для коллекции. UIView, UILabel (est 25 min, fact x min)
3. Коллекция с избранными NFT. UICollectionView (est 20 min, fact x min)

#### Логика

1. Получение JSON-данных об NFT. Model (est: 40 min, fact x min)
2. Преобразование данных в модель NFT. ViewModel (est: 20 min, fact x min)
3. Обновление данных NFT. ViewModel (est: 20 min, fact x min)
4. Настройка DataSource-методов CollectionView. View (est: 30 min, fact x min)
5. Обновление содержимого таблицы. View (est: 10 min, fact x min)

#### Вёрстка ячейки коллекции

1. Иконка NFT. UIImageView (est: 10 min, fact x min)
2. Наименование NFT. UILabel (est: 10 min, fact x min)
3. Рейтинг NFT. UIStackView/UIImage (est: 30 min, fact x min)
4. Цена NFT. UILabel (est: 10 min, fact x min)
5. Лайк-кнопка. UIButton (est: 10 min, fact x min)


#### Логика

1. Заполнение элементов ячейки данными об NFT. View (est: 20 min, fact x min)
2. Обработка нажатия на лайк-кнопке. ViewModel, Model (est: 40 min, fact x min)
3. Обновление коллекции. ViewModel, View (est: 30 min, fact x min)

`Total:` 5 hr 30 min, fact: x min
