#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range = [1:12]; bandname = 'alpha'; freqlimits = [8 13]; bins=[[8 10]; [11 13]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [13:24]; bandname = 'alpha'; freqlimits = [8 13]; bins=[[8 10]; [11 13]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [25:36]; bandname = 'alpha'; freqlimits = [8 13]; bins=[[8 10]; [11 13]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [37:48]; bandname = 'alpha'; freqlimits = [8 13]; bins=[[8 10]; [11 13]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [49:60]; bandname = 'alpha'; freqlimits = [8 13]; bins=[[8 10]; [11 13]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [61:72]; bandname = 'alpha'; freqlimits = [8 13]; bins=[[8 10]; [11 13]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [73:84]; bandname = 'alpha'; freqlimits = [8 13]; bins=[[8 10]; [11 13]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [85:100]; bandname = 'alpha'; freqlimits = [8 13]; bins=[[8 10]; [11 13]]; extract_meanband; exit" < /dev/null > /dev/null &
