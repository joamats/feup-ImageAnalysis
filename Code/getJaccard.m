function [J] = getJaccard(pos1, pos2)

%Calculate the Jaccard Index of two rectangles
%INPUT: 2 Vectors with information for each square:
%(xCoordinate, yCoordinate, width, height)
%OUTPUT: Jaccard Index

intersectionArea = rectint(pos1,pos2);                            %Calcule of area of intersection of the two squares
unionArea = (pos2(3)*pos2(4))+(pos1(3)*pos1(4))-intersectionArea; %Calcule of area of union of the two squares
J = intersectionArea/unionArea;                                   %Calcule of jaccard index

end