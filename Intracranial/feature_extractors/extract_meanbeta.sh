#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range = [1:12]; bandname = 'beta'; freqlimits = [13 30]; bins=[[13 18]; [19 24]; [25 30]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [13:24]; bandname = 'beta'; freqlimits = [13 30]; bins=[[13 18]; [19 24]; [25 30]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [25:36]; bandname = 'beta'; freqlimits = [13 30]; bins=[[13 18]; [19 24]; [25 30]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [37:48]; bandname = 'beta'; freqlimits = [13 30]; bins=[[13 18]; [19 24]; [25 30]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [49:60]; bandname = 'beta'; freqlimits = [13 30]; bins=[[13 18]; [19 24]; [25 30]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [61:72]; bandname = 'beta'; freqlimits = [13 30]; bins=[[13 18]; [19 24]; [25 30]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [73:84]; bandname = 'beta'; freqlimits = [13 30]; bins=[[13 18]; [19 24]; [25 30]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [85:100]; bandname = 'beta'; freqlimits = [13 30]; bins=[[13 18]; [19 24]; [25 30]]; extract_meanband; exit" < /dev/null > /dev/null &
