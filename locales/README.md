# Локализация / Localization

## Поддържани езици / Supported Languages
- 🇧🇬 Български (bg) - По подразбиране / Default
- 🇬🇧 English (en)

## Как да сменя езика / How to Change Language

Отвори `shared/config.lua` и промени:
```lua
Config.Locale = 'bg'  -- За български / For Bulgarian
Config.Locale = 'en'  -- За английски / For English
```

## Как да добавя нов превод / How to Add New Translation

1. Създай нов файл в `locales/` папката (например `locales/de.lua`)
2. Копирай структурата от `locales/en.lua`
3. Преведи всички текстове
4. Добави файла в `fxmanifest.lua`:
```lua
shared_scripts {
    'locales/locale.lua',
    'locales/bg.lua',
    'locales/en.lua',
    'locales/de.lua',  -- Нов език / New language
    'shared/config.lua'
}
```

## Използване в код / Usage in Code

```lua
-- Прост текст / Simple text
local message = _('no_water')

-- С параметри / With parameters
local message = _('catch_success', fishName, rarity)
local message = _('sell_success', count, category, price)
```

## Налични ключове / Available Keys

Виж `locales/bg.lua` или `locales/en.lua` за пълен списък на наличните ключове.
