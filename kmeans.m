function [c, Z, niter] = kmeans(D, c0, endcrit, miniter)
% KMEANS - K-means algorithm
% 
% Input Parameters:
% D(N,P)   data matrix (N datapoints, P dimensions)
% c0(K,P)  K initial centroids
% endcrit  end criterion: stop when the distortion decrease between
%          iterations is lower than endcrit
% miniter  ignore endcrit as long as the number of iteration is
%          lower than miniter
%
% Output Parameters:
% c(K,P)   final centroids
% Z(N)     assignment of each datapoint to a class
% niter    number of iterations before end criterion is reached
%
% See also: updateCentroids, updateClusters

c = c0;
niter = 0;
biggestUpdate = Inf;
N = size(D,1);
K = size(c0,1);

% PLOT  % % % % % % %
clf
cl = 'rgbk';
for m=1:N
    plot(D(m,1), D(m,2),'*k'), hold on;
end
for k=1:K
    plot(c(k,1), c(k,2), [cl(k) 'x'])
end
drawnow
pause(0.5);
% % % % % % % % % % %

while (niter < miniter || biggestUpdate > endcrit)
    Z = updateClusters(D, c);
    newC = updateCentroids(D, Z, K);
    biggestUpdate = max(sqrt(sum((c - newC).^2,2)));
    c = newC;
    niter = niter + 1;
    
    % PLOT  % % % % % % %
    clf
    cl = 'rgbk';
    for m=1:N
        plot(D(m,1), D(m,2),['*' cl(Z(m))]), hold on;
    end
    for k=1:K
        plot(c(k,1), c(k,2), [cl(k) 'x'])
    end
    drawnow
    pause(0.5);
    % % % % % % % % % % %
end
