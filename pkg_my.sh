function pkgi
  if string match -q "false" (pkg install wget2)
echo "wget2 не установлен"
else
echo "wget2 установлен"
end
end
