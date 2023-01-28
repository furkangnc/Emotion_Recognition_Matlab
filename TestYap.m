clc;clear;%ekran� ve commandwindow u temizliyoruz.

cs = 8; % y�klenecek verisetini belirtmek i�in cs yi kullan�yoruz.cs bizim cellsize verisetini hangi de�erler olu�turduysak onu y�kletmede kulan�yoruz.
%% LOAD TRAIN DATASET   - E��T�M VER�SET�N� Y�KLEMEK ���N KULLANILIR.. 
load(['trainDataset-[cs' num2str(cs) '].mat']); % e�itim veri seti y�kleniyor cs de�erine g�re.

%% LOAD TEST DATASET  - TEST VER�SET�N� Y�KLEMEK ���N KULLANILIR.. 
info = load(['testDataset-[cs' num2str(cs) '].mat']); % test veri seti y�kleniyor cs de�erine g�re.
%testNumber = 1; % Denenecek �rnek say�s�. (1,2,3... gibi giri� verebilir.) 

%% SETUP CLASSIFICATION  - SINIFLANDIRICI AYARLARINI YAPMAK ���N KULLANILIR.. 
k = 1; % En yak�n kom�u say�s�, 1,3,5 gibi giri�ler vererek sonu�taki de�i�imler g�rebilir.1
Mdl = fitcknn(trainData,trainLabel,'NumNeighbors',k); % E�itim data's� ve s�n�f etiketleriyle S�n�fland�r�c� modelini olu�turuyoruz.

% Siniflar = Mdl.ClassNames' % Verisetindeki s�n�flar� g�r�nt�l�yoruz.. (Command window'da g�z�k�r)
% Dagilim_Agirliklari = Mdl.Prior % S�n�flar�n da��l�m a��rl�klar�n� g�r�nt�l�yoruz. (Command window'da g�z�k�r)

%% PREDICT TEST SAMPLE  - TEK B�R �RNEK SINIFLANDIRMAK ���N KULLANILIR.. 
% oneSamplePredictedLabel = predict(Mdl,info.testData(testNumber,:)) % Olu�turulan modele giri� �rne�ini veriyoruz ve tahmin edilen ��k��a bak�yoruz.
% info.testLabel(testNumber) % Ger�ek ��k��� g�steriyoruz.

%% PREDICT WHOLE SAMPLES - T�M �RNEKLER� SINIFLANDIRMAK ���N KULLANILIR.. 
 wholeSamplesPredictedLabels = predict(Mdl,info.testData) % T�m �rnekleri Model'e giri� olarak veriyoruz ve ��k��lara bak�yoruz.
 info.testLabel % Ger�ek ��k��lara bak�yoruz.
 dogruTahmin = 0; % Do�ru tahmin edilenleri saymak i�in kullan�lan de�i�ken..
 for i=1:length(wholeSamplesPredictedLabels)
     if(strcmp(wholeSamplesPredictedLabels(i),info.testLabel(i)))
         dogruTahmin = dogruTahmin + 1; % Do�ru tahmin edilenlerin say�s� (True Positives)
     end
 end
 Test_Edilecek_Resim_Sayisi = i
 Dogru_Tahmin_Edilen_Resim_Sayisi = dogruTahmin
 Dogruluk = (dogruTahmin * 100) / length(wholeSamplesPredictedLabels) % Accuracy : True Positives / (True Positives + False Positives)