#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range = [1:12]; bandname = 'gamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [13:24]; bandname = 'gamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [25:36]; bandname = 'gamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [37:48]; bandname = 'gamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [49:60]; bandname = 'gamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [61:72]; bandname = 'gamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [73:84]; bandname = 'gamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [85:100]; bandname = 'gamma'; freqlimits = [70 150]; bins=[[70 80]; [81 90]; [91 100]; [101 110]; [111 120]; [121 130]; [131 140]; [141 150]]; extract_meanband; exit" < /dev/null > /dev/null &
