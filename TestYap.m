clc;clear;%ekraný ve commandwindow u temizliyoruz.

cs = 8; % yüklenecek verisetini belirtmek için cs yi kullanýyoruz.cs bizim cellsize verisetini hangi deðerler oluþturduysak onu yükletmede kulanýyoruz.
%% LOAD TRAIN DATASET   - EÐÝTÝM VERÝSETÝNÝ YÜKLEMEK ÝÇÝN KULLANILIR.. 
load(['trainDataset-[cs' num2str(cs) '].mat']); % eðitim veri seti yükleniyor cs deðerine göre.

%% LOAD TEST DATASET  - TEST VERÝSETÝNÝ YÜKLEMEK ÝÇÝN KULLANILIR.. 
info = load(['testDataset-[cs' num2str(cs) '].mat']); % test veri seti yükleniyor cs deðerine göre.
%testNumber = 1; % Denenecek örnek sayýsý. (1,2,3... gibi giriþ verebilir.) 

%% SETUP CLASSIFICATION  - SINIFLANDIRICI AYARLARINI YAPMAK ÝÇÝN KULLANILIR.. 
k = 1; % En yakýn komþu sayýsý, 1,3,5 gibi giriþler vererek sonuçtaki deðiþimler görebilir.1
Mdl = fitcknn(trainData,trainLabel,'NumNeighbors',k); % Eðitim data'sý ve sýnýf etiketleriyle Sýnýflandýrýcý modelini oluþturuyoruz.

% Siniflar = Mdl.ClassNames' % Verisetindeki sýnýflarý görüntülüyoruz.. (Command window'da gözükür)
% Dagilim_Agirliklari = Mdl.Prior % Sýnýflarýn daðýlým aðýrlýklarýný görüntülüyoruz. (Command window'da gözükür)

%% PREDICT TEST SAMPLE  - TEK BÝR ÖRNEK SINIFLANDIRMAK ÝÇÝN KULLANILIR.. 
% oneSamplePredictedLabel = predict(Mdl,info.testData(testNumber,:)) % Oluþturulan modele giriþ örneðini veriyoruz ve tahmin edilen çýkýþa bakýyoruz.
% info.testLabel(testNumber) % Gerçek çýkýþý gösteriyoruz.

%% PREDICT WHOLE SAMPLES - TÜM ÖRNEKLERÝ SINIFLANDIRMAK ÝÇÝN KULLANILIR.. 
 wholeSamplesPredictedLabels = predict(Mdl,info.testData) % Tüm örnekleri Model'e giriþ olarak veriyoruz ve çýkýþlara bakýyoruz.
 info.testLabel % Gerçek çýkýþlara bakýyoruz.
 dogruTahmin = 0; % Doðru tahmin edilenleri saymak için kullanýlan deðiþken..
 for i=1:length(wholeSamplesPredictedLabels)
     if(strcmp(wholeSamplesPredictedLabels(i),info.testLabel(i)))
         dogruTahmin = dogruTahmin + 1; % Doðru tahmin edilenlerin sayýsý (True Positives)
     end
 end
 Test_Edilecek_Resim_Sayisi = i
 Dogru_Tahmin_Edilen_Resim_Sayisi = dogruTahmin
 Dogruluk = (dogruTahmin * 100) / length(wholeSamplesPredictedLabels) % Accuracy : True Positives / (True Positives + False Positives)