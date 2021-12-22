#!/bin/bash

cd ${PATH_FOR_SAVING_CSV} #задается папка сохранения CSV-файла со ссылками
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1EfRc2RLVdwWlXWz3nDIBEv_EvvOMd9ip' -O importedFile.csv #скачивается CSV-файл

columnNumber= head -1 ${importedFile.csv} | tr ';' '\n' | nl | grep -w ${LINK_COLUMN} | tr -d " " | awk -F " " '{print $1}' #извлекается 1 строка csv-файла с заголовками, делится на строки, извлекается номер столбца со ссылками
awk -F "\"*;\"*" "{print ${columnNumber}}" $PATH_TO_CSV | parallel -j ${NUMBER_OF_THREADS} --progress wget -q {} -P ${PATH_TO_SAVE} #извлекаеся столбец со ссылками, из него скачиваются статьи
