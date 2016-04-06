#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range=[1:12]; bandname='delta'; freqlimits=[1 4]; bins=[[1 4]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[13:24]; bandname='delta'; freqlimits=[1 4]; bins=[[1 4]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[25:36]; bandname='delta'; freqlimits=[1 4]; bins=[[1 4]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[37:48]; bandname='delta'; freqlimits=[1 4]; bins=[[1 4]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[49:60]; bandname='delta'; freqlimits=[1 4]; bins=[[1 4]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[61:72]; bandname='delta'; freqlimits=[1 4]; bins=[[1 4]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[73:84]; bandname='delta'; freqlimits=[1 4]; bins=[[1 4]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[85:100]; bandname='delta'; freqlimits=[1 4]; bins=[[1 4]]; extract_meanband; exit" < /dev/null > /dev/null &
