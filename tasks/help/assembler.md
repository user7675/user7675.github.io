# Help for assembler

## Links that help:

- [sdfslkdfjlskjf](https://sdfsdfsdfsdfs)


## At document

Unimplemented Operation, Invalid Operation, Division-by-zero, Inexact, Overflow, Underflow

## At assembler file

Cause(EVZOUI),En(VZOUI)

| Key |  Text |
| ------ | ------ |
|- E | Unimplemented Operation |
|- V | Invalid Operation - неправильная операция|
|- Z | Division-by-zero - деление на ноль |
|- O | Overflow - переполнение |
|- U | Underflow - антипереполнение|
|- I | Inexact - потеря точности|
|- V | Invalid Operation|



## 10.2 Исключения блока вещественной арифметики

### 10.2.1 Исключение Z

Исключение по делению на 0, Z – division by zero – может возникнуть только при выполнении команд вещественной арифметики DIV.fmt, RECIP.fmt и RSQRT.fmt когда делитель равен 0, а делимое не равно 0. При возникновении исключения Z поля Cause[Z] и Flags[Z] устанавливаются в “1” 
Если бит Enables[Z] = “1”, то возникает исключение FPU.
Если бит Enables[Z] = “0”, то исключения не возникает, и в качестве результата выдается бесконечность с соответствующим знаком.

### 10.2.2 Исключение I

Исключение по потере точности, I – inexact –  возникает при потере точности результата при выполнении вычислительных команд и команд преобразования, а также при возникновении исключений O и U. При возникновении исключения I поля Cause[I] и Flags[I] устанавливаются в «1».
Если бит Enables[I] = 1, возникает исключение FPU. Нужно отметить, что без лишней надобности не следует устанавливать этот бит, так как это повлечет значительное ухудшение производительности FPU (в этом случае отключается конвейерный режим работы FPU, так как необходимо обеспечить точность исключения I, а возможность возникновения этого исключения нельзя предсказать на ранних стадиях).
Если бит Enables[I] = 0, то исключения не возникает, и выдается округленный результат в соответствии с режимом округления.

### 10.2.3 Исключение O

Исключение по переполнению, О – overflow – возникает при выполнении вычислительной команды, если полученный результат превышает границу формата (сказанное не относится к командам преобразования – они в случае переполнения вызывают исключение V). При возникновении исключения O также возникает исключение I, поля Cause[O, I] и Flags[O, I] устанавливаются в “1”. Результат операции при запрещенном исключении Overflow приведен в таблице Таблица .85.
Если биты Enables[O] = 1 или Enables[I] = 1, то вырабатывается исключение FPU.
Если биты Enables[O] = 0 и Enables[I] = 0, то исключения не возникает, и вырабатывается результат, зависящий от режима округления.

Таблица .85 – Результат операции при запрещенном исключении Overflow
|RM|Результат переполнения|
| ------ | ------ |
00 |Бесконечность с соответствующим знаком|
01|Самое большое (по модулю) конечное число с соответствующим знаком|
10|Если отрицательное переполнение – самое большое (по модулю) конечное отрицательное число. Если положительное, то вырабатывается + ∞.|
11|Если положительное переполнение – самое большое (по модулю) конечное положительное число. Если отрицательное, то вырабатывается - ∞.|


### 10.2.4 Исключение U

При выполнении арифметических операций FPU, исключение U – underflow – не возникает. При возникновении ситуации потери значимости при FCSR[FS] = “0” возникает исключение E – unimplemented operation, а при FCSR[FS] = “1”результат обнуляется, исключение FPU не возникает.
### 10.2.5 Исключение V

Исключение по неправильной операции, V – invalid operation – возникает в следующих ситуациях:
сложение или вычитание, при котором невозможно предсказать результат, например, (+∞) - (+∞) или (-∞) + (+∞);
умножение, при котором невозможно предсказать результат, например, 0×∞;
деление 0 / 0 или ∞ / ∞ с любым знаком;
преобразование числа с плавающей запятой в целов число с переполнением, или когда операндом является бесконечная величина или не-число, и оно не может быть представлено в заданном формате;
сигнализирующая операция сравнения, если операнды неупорядочены, то есть хотя бы один из них является не-числом.
При возникновении исключения V поля Cause[V] и Flags[V] устанавливаются в «1».
Если бит Enables[V] = 1, то возникает исключение FPU.
Если бит Enables[V] = 0, то исключения не возникает, и в качестве результата выдается не-число.
### 10.2.6 Исключение E

Исключение по нереализованной операции, E – unimplemented operation – возникает в следующих случаях:
поступление денормализованных данных на вход при выполнении арифметической операции, если бит FCSR[FS] = “0”;
возникновение денормализованного результата или ситуации потери значимости результата при выполнении арифметической операции, если бит FCSR[FS] = “0”;
при выполнении инструкции DIV.D, RECIP.D или  RSQRT.D при установленном в “1” бите FCONFIG[DIVD];
при выполнении инструкции SQRT.D или  RSQRT.D при установленном в “1” бите FCONFIG[SQRTD].
Исключение E является немаскируемым.