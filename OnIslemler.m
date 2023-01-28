
[filename, folder] = uigetfile ({'*.jpg';'*.bmp';'*.png'}, 'Dosya Se�iniz'); %Burada i�lem yap�lacak resim se�tiriliyor.
fullFileName = fullfile(folder, filename);% Resmin konumunu al�yoruz.
I=imread(fullFileName); %Gir� resmi I y� konumdaki resme e�itliyoruz.
imshow(I); %Se�ilen resim fig�rde g�r�nt�leniyor.

I=im2double(I); %resim double a �eviriliyor.
if size(I,3)==3 % e�er resim boyutu 3 rgb yani renkli ise 
    I=rgb2gray(I); %resmi griye �eviriyoruz.
end
R = imresize(I,[256 256]); %imresize ile resim yeniden boyutland�r�l�yor.
figure, imshow(R)% yeniden boyutlanm�� gri resimde fig�rde g�r�nt�leniyor.
defaultFileName = fullfile(folder, '.jpg'); % varsay�lan resim kay�t t�r� ayarland�.
[baseFileName, folder] = uiputfile(defaultFileName, 'Dosyay� Kaydedin'); % Dosya kaydetme penceresi i�in kullan�ld�.
if baseFileName == 0 % eger iptal edilirse bo� geri d�n�yor.

  return;
end
fullFileName = fullfile(folder, baseFileName) % dosya ve klas�r yolu tutuluyor
imwrite(R, fullFileName); %tutulan dosya ve klas�r yolu command window a yaz�l�yor.