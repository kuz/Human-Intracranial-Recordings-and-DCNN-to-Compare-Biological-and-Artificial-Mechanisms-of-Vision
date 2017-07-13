function [Ab,msgObj] = notchpeakargchk(Wo,BW,opts)
% NOTCHPEAKARGCHK Validates the inputs for the IIRNOTCH and IIRPEAK
% functions.

%   Author(s): P. Pacheco
%   Copyright 1999-2011 The MathWorks, Inc.

% Define default values.
Ab = abs(10*log10(.5)); % 3-dB width

% Check Wo and BW for notch/peak filters.
msgObj = freq_n_bandwidth(Wo,BW);
if ~isempty(msgObj), return, end

% Parse and validate optional input args.
[Ab,msgObj] = parseoptions(Ab,opts);
if ~isempty(msgObj), return, end

%------------------------------------------------------------------------
function msgObj = freq_n_bandwidth(Wo,BW)
% Check Wo and BW for notch/peak filters.

msgObj = '';
% Validate frequency cutoff and bandwidth.
if (Wo<=0) || (Wo >= 1),
    msgObj = message ('dsp:notchpeakargchk:FilterErr1');
    return;
end

if (BW <= 0) || (BW >= 1),
    msgObj = message ('dsp:notchpeakargchk:FilterErr2');
    return;
end

%------------------------------------------------------------------------
function [Ab,msgObj] = parseoptions(Ab,opts)
% Parse the optional input arguments.

msgObj='';
if ~isempty(opts),
    [Ab,msgObj] = checkAtten(opts{1});
end

%------------------------------------------------------------------------
function [Ab,msgObj] = checkAtten(option)
% Determine if input argument is a scalar numeric value.

% Initialize output args.
Ab = [];
msgObj = '';
if isnumeric(option) && all(size(option)==1),  % Make sure it's a scalar
    Ab = abs(option);  % Allow - or + values
else
    msgObj = message ('dsp:notchpeakargchk:FilterErr3');
end

% [EOF]

