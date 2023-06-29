#!/usr/bin/env fish
#
# Вот сложный пример, который проверяет, установлены ли пакеты ruby-dev и
# ruby-bundler. Если они есть, то запускается jekyll, а если нет, то эти пакеты
# устанавливаются.

# Вернуть "true", если $packageName установлен, и "false" в противном случае.
# Используйте его в операторе if следующим образом:
#
# if string match -q "false" (isPackageInstalled my-package-name)
#   echo "my-package-name не установлен"
# else
#   echo "my-package-name установлен"
# end
function isPackageInstalled -a packageName
  set packageIsInstalled (dpkg -l "$packageName")
  if test -z "$packageIsInstalled"
    set packageIsInstalled false
  else
    set packageIsInstalled true
  end
  echo $packageIsInstalled
end

# Дополнительная информация, чтобы узнать, установлен ли пакет: https://askubuntu.com/a/823630/872482
if test (uname) = "Linux"

  echo "🐒isPackageInstalled does-not-exist:" (isPackageInstalled does-not-exist)

  if string match -q "false" (isPackageInstalled ruby-dev) ;
    or string match -q "false" (isPackageInstalled ruby-bundler)
    # Install ruby
    echo "ruby-bundler or ruby-dev are not installed; installing now..."
    echo sudo apt install -y ruby-bundler ruby-dev
  else
    bundle install
    bundle update
    bundle exec jekyll serve
  end

end




