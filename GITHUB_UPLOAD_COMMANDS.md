# Команды для загрузки на GitHub

После создания репозитория на GitHub, выполните эти команды:

## 1. Добавьте remote origin (замените YOUR_USERNAME на ваше имя пользователя):
```bash
git remote add origin https://github.com/YOUR_USERNAME/country_search.git
```

## 2. Переименуйте ветку в main (если нужно):
```bash
git branch -M main
```

## 3. Загрузите код на GitHub:
```bash
git push -u origin main
```

## 4. Проверьте, что всё загрузилось:
```bash
git remote -v
git status
```

## 5. Создайте релиз на GitHub:
1. Перейдите в раздел "Releases" на GitHub
2. Нажмите "Create a new release"
3. Заполните:
   - Tag version: `v2.0.2`
   - Release title: `Country Search v2.0.2`
   - Description: см. CHANGELOG.md
4. Опубликуйте релиз

## 6. Настройте GitHub Pages (опционально):
1. Перейдите в Settings → Pages
2. Source: Deploy from a branch
3. Branch: main, folder: / (root)
4. Save

## 7. Добавьте теги для поиска:
- `flutter`
- `dart`
- `country-picker`
- `country-search`
- `phone-codes`
- `localization`
- `widget`
- `ui`
- `mobile`
- `cross-platform` 