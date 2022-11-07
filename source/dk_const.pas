unit DK_Const;

{$mode objfpc}{$H+}

interface

{uses
  Classes, SysUtils;  }

const
  SYMBOL_BREAK         = LineEnding;
  SYMBOL_EMPTY        = '';
  SYMBOL_COMMA        = ',';
  SYMBOL_OPENBRACKET  = '(';
  SYMBOL_CLOSEBRACKET = ')';
  SYMBOL_SPACE        = ' ';                      //пробел
  SYMBOL_CARRY        = '-';                      //символ переноса слова
  SYMBOLS_SEPARATOR   = SYMBOL_SPACE;             //символы разделения слов
  SYMBOLS_PUNCTUATION = '-,;:.?!/\()"«»';         //пунктуация, разделители
  SYMBOLS_VOWEL       = 'АЕЁИОУЭЫЮЯ';             //гласные буквы
  SYMBOLS_CONSONANT   = 'БВГДЖЙЗКЛМНПРСТФЧЦХШЩ';  //согласные буквы
  SYMBOLS_SPECIAL     = 'ЬЪ';

  STR_TRUE     = 'да';
  STR_FALSE    = 'нет';

  NULDATE{: TDate} = 36526;  //01.01.2000
  INFDATE{: TDate} = 401768; //31.12.2999
  MONTHSNOM: array [1..12] of String =
    ('январь', 'февраль', 'март', 'апрель', 'май', 'июнь', 'июль',
     'август', 'сентябрь', 'октябрь', 'ноябрь', 'декабрь');
  MONTHSGEN: array [1..12] of String =
    ('января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля',
     'августа', 'сентября', 'октября', 'ноября', 'декабря');
  MONTHSPREP: array [1..12] of String =
    ('январе', 'феврале', 'марте', 'апреле', 'мае', 'июне', 'июле',
     'августе', 'сентябре', 'октябре', 'ноябре', 'декабре');
  WEEKDAYSSHORT: array [1..7] of String =
    ('Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс');
  WEEKDAYSLONG: array [1..7] of String =
    ('Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье');

  VECTOR_INT_DEFAULT_VALUE   = 0;
  VECTOR_INT64_DEFAULT_VALUE = 0;
  VECTOR_STR_DEFAULT_VALUE   = '';
  VECTOR_DBL_DEFAULT_VALUE   = 0;
  VECTOR_BOOL_DEFAULT_VALUE  = False;
  VECTOR_COLOR_DEFAULT_VALUE = 0;

implementation

end.

