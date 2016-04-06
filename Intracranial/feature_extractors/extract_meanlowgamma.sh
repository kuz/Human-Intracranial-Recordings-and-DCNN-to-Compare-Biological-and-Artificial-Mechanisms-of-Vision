#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range = [1:12]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [13:24]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [25:36]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [37:48]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [49:60]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [61:72]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [73:84]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [85:100]; bandname = 'lowgamma'; freqlimits = [30 70]; bins=[[30 40]; [41 50]; [51 60]; [61 70]]; extract_meanband; exit" < /dev/null > /dev/null &
