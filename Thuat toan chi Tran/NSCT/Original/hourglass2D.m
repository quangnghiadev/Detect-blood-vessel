function [ H0,H1 ] = hourglass2D( N,version )
% This function creates the two hourglass filters. Studied from
% Truc et. al.'s code.
% INPUT:
% N ? The order of the diamond filter.
% version ? The version of hourglass. OPTIONAL.
% v1,v1T,v190,v1?90;v2,v2T,v290,v2?90.
% This determines the way the hourglass is
% constructed from the diamond filter.

if ~exist('version','var')
    version = 'v1T';
end

%% Construct diamond
D = diamond2D(N);

%% Shift the frequency domain to produce the hourglass from
%% the diamond filter.

if strcmp(version(1:2),'v1')
    H0 = repmat((-1).^(0:N-1),N,1).* D;
    if strcmp(version(3:end),'T')
        H1 = H0';
    elseif strcmp(version(3:end),'90')
        if rem(N,2) == 0
            H1 = rot90([ [H0 zeros(N,1)]; zeros(1,N+1)],1);
            H1 = H1(1:N,1:N);
        else
            H1 = rot90(H0,1);
        end
    elseif strcmp(version(3:end),'-90')
        if rem(N,2) == 0
            H1 = rot90([ [H0 zeros(N,1)]; zeros(1,N+1)],-1);
            H1 = H1(1:N,1:N);
        else
            H1 = rot90(H0,1);
        end
    else
        error(['Unrecognized version 1 option: ' version(3:end) ...
            '.']);
    end
elseif strcmp(version(1:2),'v2')
    H1 = repmat(((-1).^(0:N-1))',1,N).* D;
    if strcmp(version(3:end),'T')
        H0 = H1';
    elseif strcmp(version(3:end),'90')
        if rem(N,2) == 0
            H0 = rot90([ [H1 zeros(N,1)]; zeros(1,N+1)],1);
            H0 = H0(1:N,1:N);
        else
            H0 = rot90(H1,1);
        end
    elseif strcmp(version(3:end),'?90')
        if rem(N,2) == 0
            H0 = rot90([ [H1 zeros(N,1)]; zeros(1,N+1)],-1);
            H0 = H0(1:N,1:N);
        else
            H0 = rot90(H1,1);
        end
    else
        error(['Unrecognized version 2 option: ' version(3:end) ...
            '.']);
    end
else
    error('Unrecognized version.');
end

end