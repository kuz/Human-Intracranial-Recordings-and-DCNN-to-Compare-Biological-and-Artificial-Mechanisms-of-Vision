#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range = [1:12]; bandname = 'alphabe'; freqlimits = [7 20]; bins=[[7 10]; [11 15]; [16 20]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [13:24]; bandname = 'alphabe'; freqlimits = [7 20]; bins=[[7 10]; [11 15]; [16 20]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [25:36]; bandname = 'alphabe'; freqlimits = [7 20]; bins=[[7 10]; [11 15]; [16 20]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [37:48]; bandname = 'alphabe'; freqlimits = [7 20]; bins=[[7 10]; [11 15]; [16 20]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [49:60]; bandname = 'alphabe'; freqlimits = [7 20]; bins=[[7 10]; [11 15]; [16 20]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [61:72]; bandname = 'alphabe'; freqlimits = [7 20]; bins=[[7 10]; [11 15]; [16 20]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [73:84]; bandname = 'alphabe'; freqlimits = [7 20]; bins=[[7 10]; [11 15]; [16 20]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [85:100]; bandname = 'alphabe'; freqlimits = [7 20]; bins=[[7 10]; [11 15]; [16 20]]; extract_meanband; exit" < /dev/null > /dev/null &
