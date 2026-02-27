Locales = {}

-- Default locale
Config = Config or {}
Config.Locale = Config.Locale or 'bg'

-- Translation function
function _(str, ...)
    if Locales[Config.Locale] and Locales[Config.Locale][str] then
        if ... then
            return string.format(Locales[Config.Locale][str], ...)
        else
            return Locales[Config.Locale][str]
        end
    else
        -- Fallback to English if translation not found
        if Locales['en'] and Locales['en'][str] then
            if ... then
                return string.format(Locales['en'][str], ...)
            else
                return Locales['en'][str]
            end
        else
            return 'Translation [' .. str .. '] not found'
        end
    end
end

-- Alternative function name for compatibility
function _U(str, ...)
    return _(str, ...)
end
