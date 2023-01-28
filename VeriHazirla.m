clc;clear; %ekran� ve commandwindow u temizliyoruz.
tic % ge�en s�reyi tutmak i�in kullan�yoruz.
faceDetector = vision.CascadeObjectDetector; % y�z k�sm� belirlemek i�in kullan�lan kod.
eyeDetector = vision.CascadeObjectDetector('EyePairBig'); % g�z k�sm� belirleme i�in kullan�lan kod.%iki g�z� birden tespit i�in eyepairbig kullan�l�r.
cs = 8; % cell size belirledik alt alana ay�rmak i�in kullanaca��z
%% CREATE TRAIN DATASET  - E��T�M VER�SET�N� HAZIRLAMAK ���N KULLANILIR.. 
 listing = dir('train'); %train klas�r�n� dinliyoruz.
 sayac = 0; 
 for i=3:length(listing) % dizinleri dinliyor.
     subFolder = dir([listing(i).folder '/' listing(i).name]); %alt klas�rdeki klas�rler ve adlar� alan�yor.
     for j=3:length(subFolder) % dizinden alt kals�rlere kadar 
         sayac = sayac + 1; % say�yoruz
         I = imread([subFolder(j).folder '/' subFolder(j).name]); % klas�rlerdeki ve alt klas�rdeki resimler al�n�yor.
         bboxes = faceDetector(I); % I resmindeki y�z belirleniyor.
         for k=1:size(bboxes,1) % e�er belirlenen y�z 1 adet ise
            I2 = imcrop(I,bboxes(k,:)); % I2 I resminin k�rp�lm�� haline atan�yor.
            bboxes2 = eyeDetector(I2); 
            if(~isempty(bboxes)) % e�er bboxes bo� ise 
                I2 = imresize(I2,[128 128]); % I2 yeniden boyutland�r�l�yor.
                trainData(sayac,:) = extractLBPFeatures(I2,'CellSize',[cs cs]); % saya�taki kadar e�itim s�n�f� verisinin �zellikleri ��kart�l�yor.
                trainLabel{sayac,1} = listing(i).name; %e�itim verisinin etikerleri train etiketine atan�yor.
            end
         end
     end
 end
 
 save(['trainDataset-[cs' num2str(cs) '].mat'],'trainData','trainLabel'); % e�itim seti e�itim verisi ve etiket ile cs de�eriyle kaydediliyor.

%% CREATE TEST DATASET   - TEST VER�SET�N� HAZIRLAMAK ���N KULLANILIR.. 
 listing = dir('test'); % test klas�r�n� dinliyoruz.
 sayac = 0;
 for i=3:length(listing) % dizinleri dinliyor.
     subFolder = dir([listing(i).folder '/' listing(i).name]); %alt klas�rdeki klas�rler ve adlar� alan�yor.
     for j=3:length(subFolder)
         sayac = sayac + 1;
         I = imread([subFolder(j).folder '/' subFolder(j).name]);
         bboxes = faceDetector(I);  % I resmindeki y�z belirleniyor.
         for k=1:size(bboxes,1) % e�er belirlenen y�z 1 adet ise
            I2 = imcrop(I,bboxes(k,:));
            bboxes2 = eyeDetector(I2);
            if(~isempty(bboxes))% e�er bboxes bo� ise 
                I2 = imresize(I2,[128 128]); % I2 yeniden boyutland�r�l�yor.
                testData(sayac,:) = extractLBPFeatures(I2,'CellSize',[cs cs]);% saya�taki kadar test s�n�f� verisinin �zellikleri ��kart�l�yor.
                testLabel{sayac,1} = listing(i).name; %test verisinin etiketleri test etiketine atan�yor..
            end
         end
     end
 end
 
 save(['testDataset-[cs' num2str(cs) '].mat'],'testData','testLabel');% �zellikleri ��kar�lm�� verileri kaydediyourz veri ve etiketiyle birlikte.
 toc % ge�en s�reyi tutmak i�in kullan�yoruz.