#!/bin/bash

matlab -nojvm -nodisplay -nosplash -r "range=[1:12]; bandname='theta'; freqlimits=[4 8]; bins=[[4 8]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[13:24]; bandname='theta'; freqlimits=[4 8]; bins=[[4 8]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[25:36]; bandname='theta'; freqlimits=[4 8]; bins=[[4 8]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[37:48]; bandname='theta'; freqlimits=[4 8]; bins=[[4 8]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[49:60]; bandname='theta'; freqlimits=[4 8]; bins=[[4 8]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[61:72]; bandname='theta'; freqlimits=[4 8]; bins=[[4 8]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[73:84]; bandname='theta'; freqlimits=[4 8]; bins=[[4 8]]; extract_meanband; exit" < /dev/null > /dev/null &
matlab -nojvm -nodisplay -nosplash -r "range=[85:100]; bandname='theta'; freqlimits=[4 8]; bins=[[4 8]]; extract_meanband; exit" < /dev/null > /dev/null &
