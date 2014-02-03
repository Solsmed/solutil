function [ dataVectorQuantiles ] = statplot3d(x, y, data)
%STATPLOT3D Take raw scalar data of two parameters and plot it as surfaces
%showing quantiles.
%   (Detailed explanation goes here)

statDim = 3;
quants = [0.25 0.5 0.75];
alphas = [0.2 0.9 0.2];%0.5 - abs(0.5 - quants);
markers = ['v','o','^'];

%dataVectorMean = nanmean(data,statDim);
dataVectorQuantiles = quantile(data,quants,statDim);
[X Y] = meshgrid(x, y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUANTILE SURFACES

for q=1:length(quants)
    s=surf(x,y,dataVectorQuantiles(:,:,q)','edgecolor','none');
    hold on
    set(s,'FaceAlpha',alphas(q));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% QUANTILE RODS

% TODO: shaded rods

for xx = 1:length(x)
    for yy = 1:length(y)
        plot3([x(xx) x(xx)],[y(yy) y(yy)],[dataVectorQuantiles(xx,yy,end) dataVectorQuantiles(xx,yy,1)],'k-','LineWidth',2)
    end
end

for q = 1:length(quants)
    plot3(X,Y,dataVectorQuantiles(:,:,q)',markers(q))
end

end

