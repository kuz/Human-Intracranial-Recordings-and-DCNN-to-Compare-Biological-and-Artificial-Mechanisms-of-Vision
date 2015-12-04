%This function will calculate fourier spectra for each seperate window.
%By Sander August 2014

%INPUTS
%signal - input signal
%window - width of the moving window (ms)
%slide - step length of the moving window. Between 0 and 0.99 as percentage
    %of the window width.
%nw - number of tapers used for estimating multitapered PSD (minimum of 1.25).
%sRate - sampling rate of the signal

%OUTPUTS
%PSD - (NxM) matrix with power spectral density of the signal (N) for each
    %window (M).
%faxis - frequency axis for PSD (N).
%window_pos - center position of each window as an index of 'signal'. To
%get window position in milliseconds: window_pos/sRate.

function [PSD,faxis,window_pos] = spectrogramfn(signal,window,slide,nw,sRate)

if slide > 0.99 %Maximum value for slide is 0.99
    slide = 0.99;
    disp('Maximum allowed value for slide is 0.99')
end

window = ceil(window/(1000/sRate)); %window from ms to bins

%% Produce a matrix for indexing windows seperately into PSD calculation
windows = [];
window_pos = [];
w_start = 1;
w_finish = w_start+window-1;
while w_finish <= length(signal)
    windows = [windows; w_start:w_finish];
    window_pos = [window_pos floor(w_start+window/2)];
    w_start = ceil(w_start+window*(1-slide));
    w_finish = w_start+window-1;
end

%% Calculate the power spectra for each window using multitapers
for n_window = 1:size(windows,1)
    [temp_powers, faxis] = plotPSD(signal(windows(n_window,:)),sRate,window,nw,1,1);
    PSD(:,n_window) = permute(temp_powers,[1 3 2]);
end

end