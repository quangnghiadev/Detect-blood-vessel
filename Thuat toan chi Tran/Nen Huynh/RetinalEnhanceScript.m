% RetinalEnhanceScript.m

% Run this script to see bar graph in Figure 28 of thesis
% and the mean of Table 5. To see bar graph in Figure 27,
% change AUC (including variable name AUCplot) to accy
% for part F of this script. To see the standard deviation of Table 5,
% change part G to call std() instead of mean().

%% A. Setup the parameters

MVEoption = struct('FrangiScaleRange',[1 6],'FrangiScaleRatio',2,...
    'FrangiBetaOne',0.75,'FrangiBetaTwo',15,...
    'BlackWhite',true,'verbose',false);


DDFBoption = struct('N',3,'sigma',2 : 1 : 6,...
    'beta',0.75,'gamma',15,...
    'LightonDark',false);

midOption = struct('func',@(I,opt) homofilter(I,opt),...
    'method','Butterworth',...
    'n',2,'D0',300,'alphaL',0.1,'alphaH',1);

%% B. DRIVE Vessel extraction database
DRIVE_db = cell(40,1);
for i = 1 : 9
    DRIVE_db{i} = struct('I',imread(['DRIVE\test\images\0' ...
        num2str(i) ' test.tif']),...
        'mask',imread(['DRIVE\test\mask\0' ...
        num2str(i) ' test mask.gif']),...
        'trace',imread(['DRIVE\test\1st manual\0' ...
        num2str(i) ' manual1.gif']));
end

for i = 10 : 20
    DRIVE_db{i} = struct('I',imread(['DRIVE\test\images\' ...
        num2str(i) ' test.tif']),...
        'mask',imread(['DRIVE\test\mask\' ...
        num2str(i) ' test mask.gif']),...
        'trace',imread(['DRIVE\test\1st manual\' ...
        num2str(i) ' manual1.gif']));
end

for i = 21 : 40
    DRIVE_db{i} = struct('I',imread(['DRIVE\training\images\' ...
        num2str(i) ' training.tif']),...
        'mask',imread(['DRIVE\training\mask\' ...
        num2str(i) ' training mask.gif']),...
        'trace',imread(['DRIVE\training\1st manual\' ...
        num2str(i) ' manual1.gif']));
end

%% C. STARE Vessel extraction database
names = {'im0001','im0002','im0003','im0004','im0005',...
    'im0044','im0077','im0081','im0082','im0139',...
    'im0162','im0163','im0235','im0236','im0239',...
    'im0240','im0255','im0291','im0319','im0324'};

STARE_db = cell(length(names),1);

for i = 1 : length(names)
    STARE_db{i} = struct('I',imread(['STARE\Images\' names{i} ...
        '.ppm']),...
        'traceAH',imread(['STARE\ah trace\' ...
        names{i} '.ah.ppm']),...
        'traceVK',imread(['STARE\vk trace\' ...
        names{i} '.vk.ppm']));
end

T = [50 40 60 33 50 70 50 * ones(1,9) 40 50 * ones(1,4)];

for i = 1 : length(names)
    STARE_db{i}.mask = 255 * uint8(STARE_db{i}.I(:,:,1) > T(i));
end

%% D. Enhance DRIVE database

parfor j = 1 : 40
    disp(['Scanning image ' num2str(j)]);
    
    % The marking used to identify binary regions
    mark = max(DRIVE_db{j}.trace(:));
    
    % Shrink the marked region to accommodate the incorrect mask ...
    provided
    interior = (DRIVE_db{j}.mask == mark);
    for i = 1 : 5
        interior = interior-bwmorph(interior,'remove');
    end
    
    % Smooth the boundary to prevent false identification of ...
    boundary as vessel
    DRIVE_db{j}.diffuse = BasicHeatInpaint( ...
        double(DRIVE_db{j}.I(:,:,2)),interior );
    
    %%% 1. MVE
    Temp = struct();
    
    % Use the Multiscale enhancement
    Temp.MVEoption = MVEoption;
    
    [enhance,~,~] = FrangiFilter2D(DRIVE_db{j}.diffuse, ...
        Temp.MVEoption);
    Temp.enhance = enhance;
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(DRIVE_db{j}.trace(DRIVE_db{j}.mask ...
        == mark),...
        enhance(DRIVE_db{j}.mask == mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(DRIVE_db{j}.mask == mark),...
        DRIVE_db{j}.trace(DRIVE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    
    DRIVE_db{j}.MVE = Temp;
    
    %%% 2. DDFB
    Temp = struct();
    
    Temp.DDFBoption = DDFBoption;
    
    enhance = ...
        DFBMultiscaleEnhance(DRIVE_db{j}.diffuse,Temp.DDFBoption);
    Temp.enhance = enhance;
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(DRIVE_db{j}.trace(DRIVE_db{j}.mask ...
        == mark),...
        enhance(DRIVE_db{j}.mask == mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(DRIVE_db{j}.mask == mark),...
        DRIVE_db{j}.trace(DRIVE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    DRIVE_db{j} = setfield(DRIVE_db{j},...
        ['DDFB' num2str(Temp.DDFBoption.N)],...
        Temp);
    
    %%% 3. DDFB homomorphic mid
    Temp = struct();
    
    Temp.DDFBoption = DDFBoption;
    
    Temp.midOption = midOption;
    
    enhance = DFBMultiscaleEnhance(DRIVE_db{j}.diffuse,...
        Temp.DDFBoption,Temp.midOption);
    Temp.enhance = enhance;
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(DRIVE_db{j}.trace(DRIVE_db{j}.mask ...
        == mark),...
        enhance(DRIVE_db{j}.mask == ...
        mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(DRIVE_db{j}.mask == mark),...
        DRIVE_db{j}.trace(DRIVE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    
    DRIVE_db{j} = setfield(DRIVE_db{j},...
        ['DDFB' num2str(Temp.DDFBoption.N) 'MidHomo'],Temp);
    
end

%% E. Enhance STARE database

% AH
parfor j = 1 : 20
    disp(['Scanning image ' num2str(j)]);
    
    % The marking used to identify binary regions
    mark = max(STARE_db{j}.traceAH(:));
    
    % Shrink the marked region to accommodate the incorrect mask ...
    provided
    interior = (STARE_db{j}.mask == mark);
    for i = 1 : 5
        interior = interior-bwmorph(interior,'remove');
    end
    
    % Smooth the boundary to prevent false identification of ...
    boundary as vessel
    STARE_db{j}.diffuse = BasicHeatInpaint( ...
        double(STARE_db{j}.I(:,:,2)),interior );
    
    %%% 1. MVE
    Temp = struct();
    
    % Use the Multiscale enhancement
    Temp.MVEoption = MVEoption;
    
    [enhance,~,~] = FrangiFilter2D(STARE_db{j}.diffuse, ...
        Temp.MVEoption);
    Temp.enhance = enhance;
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(STARE_db{j}.traceAH(STARE_db{j}.mask ...
        == mark),...
        enhance(STARE_db{j}.mask == mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(STARE_db{j}.mask == mark),...
        STARE_db{j}.traceAH(STARE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    STARE_db{j}.MVE_AH = Temp;
    
    
    %%% 2. DDFB
    Temp = struct();
    
    Temp.DDFBoption = DDFBoption;
    
    enhance = ...
        DFBMultiscaleEnhance(STARE_db{j}.diffuse,Temp.DDFBoption);
    Temp.enhance = enhance;
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(STARE_db{j}.traceAH(STARE_db{j}.mask ...
        == mark),...
        enhance(STARE_db{j}.mask == mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(STARE_db{j}.mask == mark),...
        STARE_db{j}.traceAH(STARE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    STARE_db{j} = setfield(STARE_db{j},...
        ['DDFB' num2str(Temp.DDFBoption.N) ' AH'],Temp);
    
    %%% 3. DDFB homomorphic mid
    Temp = struct();
    
    Temp.DDFBoption = DDFBoption;
    
    Temp.midOption = midOption;
    
    enhance = DFBMultiscaleEnhance(STARE_db{j}.diffuse,...
        Temp.DDFBoption,Temp.midOption);
    Temp.enhance = enhance;
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(STARE_db{j}.traceAH(STARE_db{j}.mask ...
        == mark),...
        enhance(STARE_db{j}.mask == mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(STARE_db{j}.mask == mark),...
        STARE_db{j}.traceAH(STARE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    STARE_db{j} = setfield(STARE_db{j},...
        ['DDFB' num2str(Temp.DDFBoption.N) 'MidHomo AH'],Temp);
end


% VK
parfor j = 1 : 20
    disp(['Scanning image ' num2str(j)]);
    
    % The marking used to identify binary regions
    mark = max(STARE_db{j}.traceVK(:));
    
    % Shrink the marked region to accommodate the incorrect mask ...
    provided
    interior = (STARE_db{j}.mask == mark);
    for i = 1 : 5
        interior = interior-bwmorph(interior,'remove');
    end
    
    % Smooth the boundary to prevent false identification of ...
    boundary as vessel
    STARE_db{j}.diffuse = BasicHeatInpaint( ...
        double(STARE_db{j}.I(:,:,2)),interior );
    
    %%% 1. MVE
    Temp = struct();
    
    % Use the Multiscale enhancement
    Temp.MVEoption = MVEoption;
    
    [enhance,~,~] = FrangiFilter2D(STARE_db{j}.diffuse, ...
        Temp.MVEoption);
    Temp.enhance = enhance;
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(STARE_db{j}.traceVK(STARE_db{j}.mask ...
        == mark),...
        enhance(STARE_db{j}.mask == mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(STARE_db{j}.mask == mark),...
        STARE_db{j}.traceVK(STARE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    STARE_db{j}.MVE_VK = Temp;
    
    %%% 2. DDFB
    Temp = struct();
    
    Temp.DDFBoption = DDFBoption;
    
    enhance = ...
        DFBMultiscaleEnhance(STARE_db{j}.diffuse,Temp.DDFBoption);
    Temp.enhance = enhance;
    
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(STARE_db{j}.traceVK(STARE_db{j}.mask ...
        == mark),...
        enhance(STARE_db{j}.mask == mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(STARE_db{j}.mask == mark),...
        STARE_db{j}.traceVK(STARE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    STARE_db{j} = setfield(STARE_db{j},...
        ['DDFB' num2str(Temp.DDFBoption.N) ' VK'],Temp);
    
    %%% 3. DDFB homomorphic mid
    Temp = struct();
    
    Temp.DDFBoption = DDFBoption;
    
    Temp.midOption = midOption;
    
    enhance = DFBMultiscaleEnhance(STARE_db{j}.diffuse,...
        Temp.DDFBoption,Temp.midOption);
    Temp.enhance = enhance;
    
    % Get the ROC curve
    [X,Y,T,AUC] = perfcurve(STARE_db{j}.traceVK(STARE_db{j}.mask ...
        == mark),...
        enhance(STARE_db{j}.mask == mark),mark);
    Temp.X = X; Temp.Y = Y; Temp.T = T;
    Temp.AUC = AUC;
    
    [Accy,t] = SoftAccuracy(enhance(STARE_db{j}.mask == mark),...
        STARE_db{j}.traceVK(STARE_db{j}.mask == mark));
    [accy,i] = max(Accy);
    Temp.accy = accy; Temp.thresh = t(i);
    
    STARE_db{j} = setfield(STARE_db{j},...
        ['DDFB' num2str(Temp.DDFBoption.N) 'MidHomo VK'],Temp);
end

%% F. Bar graph of the ROC AUC
% DRIVE
AUCplt = [arrayfun(@(i) DRIVE_db{i}.MVE.AUC,1:40); ...
    arrayfun(@(i) DRIVE_db{i}.DDFB3.AUC,1:40);
    arrayfun(@(i) DRIVE_db{i}.DDFB3MidHomo.AUC,1:40)]';

figure('color','white'),
bar(AUCplt,'grouped','BaseValue',0.80);

title('DRIVE AUC','fontsize',20);
legend('MVE','DDFB','DDFB w/ Homomorphic filter');

% STARE AH
AUCplt = [arrayfun(@(i) STARE_db{i}.MVE_AH.AUC,1:20); ...
    arrayfun(@(i) STARE_db{i}.DDFB3_AH.AUC,1:20);
    arrayfun(@(i) STARE_db{i}.DDFB3MidHomo_AH.AUC,1:20)]';

figure('color','white'),
bar(AUCplt,'grouped','BaseValue',0.80);
title('STARE AH AUC','fontsize',20);
legend('MVE','DDFB','DDFB w/ Homomorphic filter');


% STARE VK
AUCplt = [arrayfun(@(i) STARE_db{i}.MVE_VK.AUC,1:20); ...
    arrayfun(@(i) STARE_db{i}.DDFB3_VK.AUC,1:20);
    arrayfun(@(i) STARE_db{i}.DDFB3MidHomo_VK.AUC,1:20)]';

figure('color','white'),
bar(AUCplt,'grouped','BaseValue',0.80);
title('STARE VK AUC','fontsize',20);
legend('MVE','DDFB','DDFB w/ Homomorphic filter');

%% G. Calculate the mean and standard deviation
mnMVE = mean(arrayfun(@(i) DRIVE_db{i}.MVE.AUC,1:40));
mnDDFB = mean(arrayfun(@(i) DRIVE_db{i}.DDFB3.AUC,1:40));
mnDDFB3MidHomo = mean(arrayfun(@(i) ...
    DRIVE_db{i}.DDFB3MidHomo.AUC,1:40));