clc;clear; %ekraný ve commandwindow u temizliyoruz.
tic % geçen süreyi tutmak için kullanýyoruz.
faceDetector = vision.CascadeObjectDetector; % yüz kýsmý belirlemek için kullanýlan kod.
eyeDetector = vision.CascadeObjectDetector('EyePairBig'); % göz kýsmý belirleme için kullanýlan kod.%iki gözü birden tespit için eyepairbig kullanýlýr.
cs = 8; % cell size belirledik alt alana ayýrmak için kullanacaðýz
%% CREATE TRAIN DATASET  - EÐÝTÝM VERÝSETÝNÝ HAZIRLAMAK ÝÇÝN KULLANILIR.. 
 listing = dir('train'); %train klasörünü dinliyoruz.
 sayac = 0; 
 for i=3:length(listing) % dizinleri dinliyor.
     subFolder = dir([listing(i).folder '/' listing(i).name]); %alt klasördeki klasörler ve adlarý alanýyor.
     for j=3:length(subFolder) % dizinden alt kalsörlere kadar 
         sayac = sayac + 1; % sayýyoruz
         I = imread([subFolder(j).folder '/' subFolder(j).name]); % klasörlerdeki ve alt klasördeki resimler alýnýyor.
         bboxes = faceDetector(I); % I resmindeki yüz belirleniyor.
         for k=1:size(bboxes,1) % eðer belirlenen yüz 1 adet ise
            I2 = imcrop(I,bboxes(k,:)); % I2 I resminin kýrpýlmýþ haline atanýyor.
            bboxes2 = eyeDetector(I2); 
            if(~isempty(bboxes)) % eðer bboxes boþ ise 
                I2 = imresize(I2,[128 128]); % I2 yeniden boyutlandýrýlýyor.
                trainData(sayac,:) = extractLBPFeatures(I2,'CellSize',[cs cs]); % sayaçtaki kadar eðitim sýnýfý verisinin özellikleri çýkartýlýyor.
                trainLabel{sayac,1} = listing(i).name; %eðitim verisinin etikerleri train etiketine atanýyor.
            end
         end
     end
 end
 
 save(['trainDataset-[cs' num2str(cs) '].mat'],'trainData','trainLabel'); % eðitim seti eðitim verisi ve etiket ile cs deðeriyle kaydediliyor.

%% CREATE TEST DATASET   - TEST VERÝSETÝNÝ HAZIRLAMAK ÝÇÝN KULLANILIR.. 
 listing = dir('test'); % test klasörünü dinliyoruz.
 sayac = 0;
 for i=3:length(listing) % dizinleri dinliyor.
     subFolder = dir([listing(i).folder '/' listing(i).name]); %alt klasördeki klasörler ve adlarý alanýyor.
     for j=3:length(subFolder)
         sayac = sayac + 1;
         I = imread([subFolder(j).folder '/' subFolder(j).name]);
         bboxes = faceDetector(I);  % I resmindeki yüz belirleniyor.
         for k=1:size(bboxes,1) % eðer belirlenen yüz 1 adet ise
            I2 = imcrop(I,bboxes(k,:));
            bboxes2 = eyeDetector(I2);
            if(~isempty(bboxes))% eðer bboxes boþ ise 
                I2 = imresize(I2,[128 128]); % I2 yeniden boyutlandýrýlýyor.
                testData(sayac,:) = extractLBPFeatures(I2,'CellSize',[cs cs]);% sayaçtaki kadar test sýnýfý verisinin özellikleri çýkartýlýyor.
                testLabel{sayac,1} = listing(i).name; %test verisinin etiketleri test etiketine atanýyor..
            end
         end
     end
 end
 
 save(['testDataset-[cs' num2str(cs) '].mat'],'testData','testLabel');% özellikleri çýkarýlmýþ verileri kaydediyourz veri ve etiketiyle birlikte.
 toc % geçen süreyi tutmak için kullanýyoruz.