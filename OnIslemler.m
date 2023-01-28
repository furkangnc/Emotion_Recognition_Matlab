
[filename, folder] = uigetfile ({'*.jpg';'*.bmp';'*.png'}, 'Dosya Seçiniz'); %Burada iþlem yapýlacak resim seçtiriliyor.
fullFileName = fullfile(folder, filename);% Resmin konumunu alýyoruz.
I=imread(fullFileName); %Girþ resmi I yý konumdaki resme eþitliyoruz.
imshow(I); %Seçilen resim figürde görüntüleniyor.

I=im2double(I); %resim double a çeviriliyor.
if size(I,3)==3 % eðer resim boyutu 3 rgb yani renkli ise 
    I=rgb2gray(I); %resmi griye çeviriyoruz.
end
R = imresize(I,[256 256]); %imresize ile resim yeniden boyutlandýrýlýyor.
figure, imshow(R)% yeniden boyutlanmýþ gri resimde figürde görüntüleniyor.
defaultFileName = fullfile(folder, '.jpg'); % varsayýlan resim kayýt türü ayarlandý.
[baseFileName, folder] = uiputfile(defaultFileName, 'Dosyayý Kaydedin'); % Dosya kaydetme penceresi için kullanýldý.
if baseFileName == 0 % eger iptal edilirse boþ geri dönüyor.

  return;
end
fullFileName = fullfile(folder, baseFileName) % dosya ve klasör yolu tutuluyor
imwrite(R, fullFileName); %tutulan dosya ve klasör yolu command window a yazýlýyor.