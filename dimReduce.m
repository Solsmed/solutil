function [R, pcaBase, lambdas] = dimReduce(data, D)
% dimReduce(data, D)
%
% data is NxP matrix, N is observations, P is features
% D is the dimensionality of the reduced data
%
% Returns NxD matrix where each row has been projected onto data's D first
% principal components.
%
% Also returns the D-dimensional base onto which the projection was made,
% as well as the lambdas for the axis of the base.

N = size(data,1);
P = size(data,2);
[pcs,~,lambdas]  = princomp(data);

pcaBase = pcs(:,1:D);

repData = repmat(data, [1+0*size(data) D]);
repBase = squeeze(reshape(imresize(pcaBase',[D N*P],'nearest')',N,P,[]));

R = squeeze(sum(repData .* repBase, 2));