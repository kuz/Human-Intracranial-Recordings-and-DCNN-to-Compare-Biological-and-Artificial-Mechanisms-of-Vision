% This program produces a spectrogram using plotPSD of a specified section
% of LFP recording. By Sander, August 2014.

% This function makes the assumption that the recording is at 1000Hz from
% -1 to 4s.
% LFP - LFP recording, with each row a separate trial
% nw - variable for plotPSD, which defines the number of multitapers used
% optional variables - 'plot' - plot the spectra
%                      'plotmany' - plot multiple spectra
%                      'padding',1000 - use padding to maintain same faxis
%                      for windows of different length. Must be followed by
%                      a number of datapoints of required window.
%                      'freqs',[50 150] - to limit the range of frequencies
%                      (output and plot)
%                      'block',500 - specify the datapoints used for single
%                      block in calculating spectra (averaged over blocks)
%                      'fs',1000 - sampling frequency (Hz) (1000 is default)
%                      'nolog' - skip taking 10*log10 of power value
    
%
% Optional output variables - [mLogPower,faxis] = getpower(LFP,nw,varargin)

function [varargout] = getpower(LFP,nw,varargin)

if sum(strcmp(varargin,'fs')) > 0
    idx = find(strcmp(varargin, 'fs'));
    sRate = varargin{idx+1};
else
    sRate = 1000; %Recording rate in Hz
end

if sum(strcmp(varargin,'padding')) > 0
    %Padding: add ~equivalent number of zeros to before and after window to
    %make a total defined milliseconds.
    idx = find(strcmp(varargin, 'padding'));
    padding = (varargin{idx+1}-size(LFP,2))/2;
    LFP = [zeros(size(LFP,1),ceil(padding)) LFP zeros(size(LFP,1),floor(padding))];
end

if sum(strcmp(varargin,'block')) > 0
    idx = find(strcmp(varargin, 'block'));
    blocklength = varargin{idx+1};
else
    blocklength = size(LFP,2);
end

%Calculate the power spectrum for each trial using plotPSD
[powers, faxis] = plotPSD(LFP,sRate,blocklength,nw,1,1);
powers = powers';

if sum(strcmp(varargin,'freqs')) > 0
    freqs = varargin{find(strcmp(varargin,'freqs'))+1};
    idx = find(faxis>freqs(1)&faxis<freqs(2));
    faxis = faxis(idx);
    powers = powers(:,idx);
end

if any(strcmp(varargin,'nolog'))
    LogPower = powers;
else
    LogPower = 10*log10(powers);
end

%Plot if requested
if sum(strcmp(varargin,'plot'))+sum(strcmp(varargin,'plotmany')) > 0
    if sum(strcmp(varargin,'plotmany')) > 0
        hold all; else; figure;
    end
    plot(faxis,LogPower)
    title('Single-Sided Amplitude Spectrum')
    xlabel('Frequency (Hz)')
    ylabel('Mean Log Power')
end

%Set output variables if requested
if nargout == 1
        varargout{1} = LogPower';
elseif nargout == 2
        varargout{1} = LogPower';
        varargout{2} = faxis';
end

end