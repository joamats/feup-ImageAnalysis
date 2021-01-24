function displayCells(pos,imIN)

% Draw rectangles in each counted cell in RGB image and show result
% INPUT: Matrix nCountedCells x 4 and RGB image

imF = insertShape(imIN, 'Rectangle', pos,'Color','red', 'LineWidth', 6);
imshow(imF, [], 'InitialMagnification','fit');

end

