function [errAreas, varargout] = skyscatter2errarea(theta, phi, HEALPixGrid, probVals)
%A = SKYSCATTER2ERRAREA(D,R,H,P)
%Obtain error regions on the sky from a scatterplot of estimated source
%positions using Kernel Density Estimation (KDE). D and R are the polar and
%azimuthal angles of the scatterplot points, H is a 2 column matrix of
%HEALPix polar (column 1) and azimuthal (column 2) angles for computing the
%KDE and the error region areas, and P is the array of error region
%probabilities. A is the areas of these regions in steradians. C is a cell
%array containing 2D matrices, with each matrix containing the polar and
%azimuthal angles as the first and second rows, respectively, of the
%corresponding error region's contour.
%
%[A, CDENSITY,CNTRLVLS, CPHIGRID, CTHEGGRID] = SKYSCATTER2ERRAREA(D,R,H,P)
%Optional output arguments:
%   CDENSITY: 2D matrix of the KDE pdf values on a Cartesian grid.
%   CNTRLVLS: Contour levels of the KDE pdf corresponding to the error regions
%   CPHIGRID: Cartesian grid of the azimuthal angles (phi) for the contour plot.
%   CTHEGGRID: Cartesian grid of the polar angles (theta) for the contour plot.
%
%TODO This function has the two following two hard-coded parameters:
%       1. The bandwidth of the KDE is set to 0.1 radians.
%       2. The Cartesian grid for the contour plot is set to 100x100 points.
%These parameters can be changed as needed or a better version of this function
%can be written to allow the user to specify these parameters through additional 
%optional input arguments.

%Soumya D. Mohanty, June 2025

%Number of error region probabilities
nProb = length(probVals);

%HEALPix grid used for computing the KDE and error region areas
HEALPixTheta = HEALPixGrid(:,1);
HEALPixPhi = HEALPixGrid(:,2);

%Compute KDE pdf on the HEALPix grid using the polar and azimuthal angles of the
%scatterplot points. 
skyDensity = ksdensity([phi(:), theta(:)],[HEALPixPhi(:), HEALPixTheta(:)],'Bandwidth',0.1);

%The error regions are found by integrating the KDE pdf starting from the
%loudest sky pixel. Since the HEALPix grid has equal area pixels,
%integration can be replaced with summation normalized by the constant pixel area.
pixArea = 4*pi/length(HEALPixPhi); %steradians
[sortSkyDensity, ~] = sort(skyDensity, 'descend');
%Area as a function of decreasing KDE value
allErrAreas = cumsum(sortSkyDensity)*pixArea;
%Normalize to account for the sky discretization approximation
allErrAreas = allErrAreas/allErrAreas(end);

%Find the error region areas and KDE pdf contour levels corresponding to
%the given error region probability values. The lowest KDE value in an
%error region gives the required contour level of the KDE pdf.
cntrLvls = zeros(1, nProb);
errAreas = zeros(1, nProb);
for lp = 1:nProb
    cntrIndx = find(allErrAreas <= probVals(lp), 1, 'last' );
    cntrLvls(lp) = sortSkyDensity(cntrIndx);
    errAreas(lp) = cntrIndx*pixArea;
end

%Optional output
if nargout > 1
    cPlaneTheta = linspace(min(HEALPixTheta),max(HEALPixTheta),100);
    cPlanePhi = linspace(min(HEALPixPhi),max(HEALPixPhi),100);
    [cPlanePhiGrid,cPlaneThetaGrid] = meshgrid(cPlanePhi,cPlaneTheta);
    cPlaneDensity = griddata(HEALPixPhi,HEALPixTheta,skyDensity,cPlanePhiGrid,cPlaneThetaGrid,'linear');
    varargout{1} = cPlaneDensity;
    if nargout > 2
        varargout{2} = cntrLvls; 
        if nargout > 3
            varargout{3} = cPlanePhiGrid;
            if nargout > 4
                varargout{4} = cPlaneThetaGrid;
            end
        end
    end
end
