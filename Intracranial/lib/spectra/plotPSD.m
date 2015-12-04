function [avePxx,f] = plotPSD(x,fs,blockLength,nw,plotStyle,color)

%nw - defines how many windows/tapers are used in the multitaper function.

[nTrials,n] = size(x);
nBlocks = floor(n/blockLength);

for jj = 1:nTrials  % Averaging over trials

    
    for ii=1:nBlocks    % Averaging over blocks

        lim_inf = 1+(ii-1)*blockLength;
        lim_sup = lim_inf+blockLength-1;

        [Pxx,Pxxc,f] = pmtm(x(jj,lim_inf:lim_sup),nw,[],fs,0.99);
        
        if ii==1
            totPxx = Pxx;
        else
            totPxx = totPxx + Pxx;
        end

    end

    if jj==1
        avePxx = totPxx/nBlocks;
    else
        avePxx = [avePxx totPxx/nBlocks];
    end
end
