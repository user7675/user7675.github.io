#!/bin/bash
▶ sshfs larina@grid0004:/home/larina/ ~/grid -o IdentityFile=~/.ssh/id_rsa


#(cd fpu_neg_d_test/; perl edit.pl);
дать права исполняемому файлу chmod +x script.sh 
for i in $(find -type f -name 'edit.pl'); do name=$(echo $i | sed -E "s/....._(.*?)_[sd].*/\1/"); sed -i -E "s/(^my .result_file = ')file.c(';)/\1${name}_test1.c\2/" $i; done
for i in $(find -type f -name 'edit.pl'); do name=$(echo $i | sed -E "s/....._(.*?)_[sd].*/\1/"); sed -i -E "s/(^my .result_file = ')file.c(';)/\1${name}_test1.c\2/" $i; done
for i in $(find -type f -name 'edit.pl'); do name=$(echo $i | sed -E "s/....._(.*?)_[sd].*/\1/"); sed -i -E "s/(^my .result_file = ')file.c(';)/\1${name}_test1.c\2/" $i; done
for i in $(find -type d -name '*_test'); do cp MY_TEST/edit.pl $i; done
for i in $(find -type d -name '*_test'); do echo "cp MY_TEST/edit.pl $i"; done

for i in $(find -type f -name 'edit.pl'); do (cd $(dirname $i) && perl $(basename $i)); done
for i in $(find -type f -name '*test.c'); do (cd $(dirname $i) && mv $(basename $i) "$(basename $i)0"); done
find -type f -name '*.c' | xargs code --add
for i in $(find -type f -name '*_test.c0'); do file=$(basename $i); (cd $(dirname $i) && mv "$file" "${file%%0}"); done  #удалить ноль в конце файла с названием mov_test.c0


perfix="test"
test_name=$(basename )
file="${prefix}_${test_name##*sdklj*}_tmp.c" // an example of the need for curly braces 
*Пример реализации возвратить 1 если есть совпадение и test
t="hello world hah" 
▶ [ -z "${t##*world*}" ] && echo world est   
▶ p="hello haha"           
▶ [ -z "${p##*world*}" ] && echo world est // эти 2 строчки равнозначны 
 test -z "${p##*world*}" && echo world est // с этой

1. Есть тесты, в каждой папке с которыми есть файл edit.pl и в нем есть слово, которое надо заменить. 
my $filename_read = 'mov_test.c';
my $result_file = 'mov_test1.c';
надо заменить на 

my $filename_read = 'abs_test.c';
my $result_file = 'abs_test1.c';

т.е. mov на abs (abs берется из названия файла)

#for i in $(find -type f -name '*edit.pl'); do file=$(basename $i); echo "sed -i -e "s/mov/${${file#*_}%_s*}\"" ; done 


for i in $(find -type f -name '*edit.pl'); do file=$(basename $i); a=$(dirname $i); a=${a#*_}; a=${a%%_*}; echo "sed -i s/mov/$a/ $i" ; done 
for i in $(find -type f -name 'edit.pl'); do file=$(basename $i); a=$(dirname $i); a=${a#*_}; a=${a%%_*}; sed -i s/mov/$a/ $i ; done


Задача получить из fpu_abs_d_test abs - ответ: a=${a#*_}; a=${a%%_*}; echo $a


ИТОГ:

- создать perl файл во временной папке MY_TEST, 
- скопировать этот edit.pl во все тесты $ for i in $(find -type d -name '*_test'); do cp MY_/edit.pl $i; done
- изменить название файлов в зависимости от называния теста - взять из названия папки 
    for i in $(find -type f -name 'edit.pl'); do file=$(basename $i); a=$(dirname $i); a=${a#*_}; a=${a%%_*}; sed -i s/mov/$a/ $i ; done
- выполнить все perl $ for i in $(find -type f -name 'edit.pl'); do (cd $(dirname $i) && perl $(basename $i)); done
- поскольку я не хотела затирать исходный файл, то измененный сишник назывался ***_test1.c, теперь в папке лежит 2 сишника 
  и я не могу запустить командой all, поэтому изменяем исходный на ***_test.c0 
    for i in $(find -type f -name '*test.c'); do (cd $(dirname $i) && mv $(basename $i) "$(basename $i)0"); done
- запуск - сборка, и проверка ошибок  
- изменяем временный c *_test1.c на *_test.c
    for i in $(find -type f -name '*_test1.c'); do file=$(basename $i); (cd $(dirname $i) && mv "$file" "${file%%1*}.c"); done
- все собираем, проверяем на наличие ошибок - можно kmd qrun
- *удалить вставленные нули (если надо откатиться обратно к исходной позиции)
  for i in $(find -type f -name '*_test.c0'); do file=$(basename $i); (cd $(dirname $i) && mv "$file" "${file%%0}"); done
- удалить исходный файл *_test.c0, который уже не нужен
    for i in $(find -type f -name '*_test.c0'); do rm $i; done
- удалить все edit.pl
    for i in $(find -type f -name 'edit.pl'); do rm $i; done



for i in $(find -type d -name '*_test'); do
    cp MY_/edit.pl $i
done
for i in $(find -type f -name 'edit.pl'); do
    file=$(basename $i)
    a=$(dirname $i)
    a=${a#*_}
    a=${a%%_*}
    sed -i s/mov/$a/ $i
done

for i in $(find -type f -name 'edit.pl'); do 
    (cd $(dirname $i) && perl $(basename $i))
done
for i in $(find -type f -name '*test.c'); do 
    (cd $(dirname $i) && mv $(basename $i) "$(basename $i)0")
done
for i in $(find -type f -name '*_test.c0'); do 
    file=$(basename $i); (cd $(dirname $i) && mv "$file" "${file%%0}")
done


*Как удалить пакет в CentOS, не удаляя связанные с ним зависимости
http://webdevil.ru/post/2016/440-remove-package-wihout-deps
Это странно, но такое иногда бывает нужно. Мне, например, потребовалось перейти с системной библиотеки libmysql на встроенную в PHP (MySQL Native Driver), т.е. ненадолго удалить одну из базовых библиотек PHP (php-mysql и php-mysqli), чего, конечно, испугались многие пакеты, имеющие PHP в зависимостях. Итак, похоже, yum не умеет удалять пакет без удаления его зависимостей, но мы обойдёмся и без yum.

Сначала опишу проблему более подробно на конкретном примере. Если в лоб попытаться установить новый нужный пакет (например, yum install php55w-mysqlnd), то менеджер пакетов yum будет ругаться на конфликт:

--> Processing Conflict: php55w-mysql-5.5.33-1.w6.x86_64 conflicts php55w-mysqlnd

Ок, а что если удалить сначала старый пакет? Сделаем yum remove php55w-mysql и увидим, что вслед за ним удалиться phpMyAdmin:

---> Package php55w-mysql.x86_64 0:5.5.33-1.w6 will be erased
--> Processing Dependency: php-mysqli for package: phpMyAdmin-4.0.10.14-1.el6.noarch
--> Processing Dependency: php-mysql >= 5.2.0 for package: phpMyAdmin-4.0.10.14-1.el6.noarch
--> Running transaction check
---> Package phpMyAdmin.noarch 0:4.0.10.14-1.el6 will be erased

Это нехорошо. Но пакет всё-таки можно удалить без удаления зависимостей.

Для этого сначала надо найти полное имя пакета: rpm -qa | grep "php55w-mysql"

В ответ получим что-то типа: php55w-mysql-5.5.33-1.w6.x86_64

Теперь, используя это имя, действуем: rpm -e --nodeps "php55w-mysql-5.5.33-1.w6.x86_64"

Никаких подтверждений у вас не спросят, пакет сразу и бесповоротно удалится.

Теперь снова попробуем установить новый пакет: yum install php55w-mysqlnd

Установка пойдёт нормально (конфликтовать-то новому пакету уже не с чем), разве что в процессе установки менеджер пакетов yum вам пожалуется, что без его ведома кто-то нехороший нарушил зависимости:

Warning: RPMDB altered outside of yum.
** Found 2 pre-existing rpmdb problem(s), 'yum check' output follows:
phpMyAdmin-4.0.10.14-1.el6.noarch has missing requires of php-mysql >= ('0', '5.2.0', None)
phpMyAdmin-4.0.10.14-1.el6.noarch has missing requires of php-mysqli

Однако работать всё будет. В том числе phpMyAdmin, который у нас НЕ удалялся.

*vscode
ctrl+tab - преключаться между вкладками


▶ find -exec printf %s\\0 '{}' + | xargs -0 printf %s\\n


