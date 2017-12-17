% SpecificRetinalScript.m

 % Run script Retinal EnhanceScript.m before this script!
 % "i" is the retinal image index. For STARE images, change
 % DRIVE_db to STARE db, corresponding traceAH/traceVK and
 % corresponding MVE AH/MVE VK, etc.
 i = 34;

 %% A. Generate the result as seen in Figure 2 and Figure 24

 figure('color','white','name',...
 ['Retinal Image ' num2str(i)],...
 'NumberTitle','off'),

 subplot(3,3,1),
 imagesc(DRIVE_db{i}.I);
 axis off
 subplot(3,3,2),
 imagesc(DRIVE_db{i}.diffuse);

 axis off
 subplot(3,3,3),
 imagesc(DRIVE_db{i}.trace);
 axis off

 subplot(3,3,4),
 imagesc(DRIVE_db{i}.MVE.enhance);
 axis off
 subplot(3,3,5),
 imagesc(DRIVE_db{i}.DDFB3.enhance);
 axis off
 subplot(3,3,6),
 imagesc(DRIVE_db{i}.DDFB3MidHomo.enhance);
 axis off

 subplot(3,3,7),
 imagesc(DRIVE_db{i}.MVE.enhance > DRIVE_db{i}.MVE.thresh);
 axis off
 subplot(3,3,8),
 imagesc(DRIVE_db{i}.DDFB3.enhance > DRIVE_db{i}.DDFB3.thresh);
 axis off
 subplot(3,3,9),
 imagesc(DRIVE_db{i}.DDFB3MidHomo.enhance > ...
DRIVE_db{i}.DDFB3MidHomo.thresh);
 axis off

 %% B. Generate ROC curve seen in Figure 24
 figure('color','white','name',...
 ['Retinal Image ' num2str(i) ' ROC'],...
 'NumberTitle','off'),

 hold on,
 plot(DRIVE_db{i}.MVE.X,DRIVE_db{i}.MVE.Y,'g');
 plot(DRIVE_db{i}.DDFB3.X,DRIVE_db{i}.DDFB3.Y,'r');
 plot(DRIVE_db{i}.DDFB3MidHomo.X,DRIVE_db{i}.DDFB3MidHomo.Y,'b');
 hold off

 legend('MVE','DDFB','DDFB w/ Homomorphic');