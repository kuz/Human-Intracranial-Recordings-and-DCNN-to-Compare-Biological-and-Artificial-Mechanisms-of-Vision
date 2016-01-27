#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range = [1:12]; extract_meantheta; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [13:24]; extract_meantheta; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [25:36]; extract_meantheta; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [37:48]; extract_meantheta; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [49:60]; extract_meantheta; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [61:72]; extract_meantheta; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [73:84]; extract_meantheta; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range = [85:100]; extract_meantheta; exit" < /dev/null > /dev/null &
