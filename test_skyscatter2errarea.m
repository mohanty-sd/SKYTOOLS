%% Test suite for SKYSCATTER2ERRAREA
% Load the HEALPix grid and the test data.
% Generate the HEALPix grid at a finer resolution using a 
% higher nSide if needed.
HEALPixGrid = load('test_HEALPixGrid.txt');
dataInfo = load('test_skycatter2errarea_data.txt');
% Polar coordinates (radians) of the data points on the sky
estTheta = dataInfo(:,1); 
% Azimuthal coordinates (radians) of the data points on the sky
estPhi = dataInfo(:,2);   
%Required probability values (e.g., 1, 2, and 3*sigma error regions)
probVals = [0.68, 0.95, 0.997];

%Get the error region areas and KDE contour levels
[errAreas, cPlaneDensity, cntrLvls, cPlanePhiGrid, cPlaneThetaGrid] = skyscatter2errarea(estTheta, estPhi, HEALPixGrid, probVals);
figure;
contourf(cPlanePhiGrid,cPlaneThetaGrid,cPlaneDensity,cntrLvls,'FaceAlpha',0.5,'EdgeColor','none');
hold on;
plot(estPhi,estTheta,'.');
xlim([0,2*pi]);
ylim([0,pi]);
title(['Prb: ',num2str(probVals)],'Interpreter','none');
% Print the areas of the error regions
disp('Areas of error regions:');
for lp = 1:length(probVals)
    disp(['Probability: ',num2str(probVals(lp)), ', Area (steradians): ', num2str(errAreas(lp))]);
end
