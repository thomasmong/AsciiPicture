%% Chargement de l'image
image = imread("image.jpg");

%% Dimensionnement
[height, width, ~] = size(image);
imRes = width/height;
numberOfChar = 600; %nombre de caractères sur une ligne
scaleFactor = numberOfChar/width;
charRes = [ceil(numberOfChar/(2*imRes)),numberOfChar];

%% Traitement de l'image
grayImage = rgb2gray(image);
%imshow(grayImage);
grayScaledImage = imresize(grayImage,charRes);

%% Création du texte Ascii
chars = ['@','#','$','*','"','^',',','.',' '];

grayMin = min(grayScaledImage,[],'all');
grayMax = max(grayScaledImage,[],'all');

% Création fichier texte
textFile = fopen("asciiImage.txt",'wt');
matrixImage = zeros(charRes);

for i = 1:charRes(1)
    for j = 1:charRes(2)
        gray = grayScaledImage(i,j);
        alpha = double((gray-grayMin))/double((grayMax-grayMin));
        indexChar = floor(alpha * (size(chars,2)-1)) + 1;
        char = chars(indexChar);
        fprintf(textFile, '%s', char);
        matrixImage(i,j) = char;
    end
    fprintf(textFile, '\n');
end     
plot(matrixImage)