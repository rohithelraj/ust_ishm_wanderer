function [iris,standard_count,plus_count,minus_count,plus_count_2,minus_count_2] = irisRetriever(edgeInput,pupil)
%IRISRETRIEVER Summary of this function goes here
%   Pupil Section of the Eye.
% (1,1)        (200,1)               (400,1)
%                |B|
%     |H|         |        |F|
%                 |
%-|D|------------Cent------------|C|-(400,99)
%                 |
%                 |
%     |E|        |A|       |G|
%                 |                 
% (1,200)     (201,200)              (400,200)
% Determining the outer rim of the iris.
%                     |
%                    |ß|
%    |L|         .    |             |z|
%                 .   |
%                 | . |
%            theta|  .|
%                 | . . .
%--|d|-------------.-----.--------------|r|---
%     radii_spatial . . .
%                     |
%                     |
%                     |
%    |€|              |             |n|
%                    |a|
%                     |

  iris = zeros(200,400);
  %centroid(1)-> Centroid(X)
  %centroid(2)-> Centroid(Y)
  
  standard_count = 0;
  plus_count = 0;
  minus_count = 0;
  plus_count_2 = 0;
  minus_count_2 = 0;
  centroid = [99 201];
  
  radii_spatial = 66;%Lateral distance between pupil and iris outer ring.
  for co_x = 1:400
    for co_y = 1:200
        if (pupil(co_y,co_x) == 1)
            if (co_x == centroid(2))
                if (co_y > centroid(1))%|A|
                    if(edgeInput((co_y+radii_spatial),co_x) == 1)
                        standard_count = standard_count + 1;
                        iris((co_y+radii_spatial),co_x) = 1;
                    elseif(edgeInput((co_y+radii_spatial+1),co_x) == 1)
                        plus_count = plus_count + 1;
                        iris((co_y+radii_spatial+1),co_x) = 1;
                    elseif(edgeInput((co_y+radii_spatial-1),co_x) == 1)
                        minus_count = minus_count + 1;
                        iris((co_y+radii_spatial-1),co_x) = 1;
                    elseif(edgeInput((co_y+radii_spatial+2),co_x) == 1)
                        plus_count_2 = plus_count_2 + 1;
                        iris((co_y+radii_spatial+2),co_x) = 1;
                    elseif(edgeInput((co_y+radii_spatial-2),co_x) == 1)
                        minus_count_2 = minus_count_2 + 1;
                        iris((co_y+radii_spatial-2),co_x) = 1;
                    end
                else%|B|
                    if(edgeInput((co_y-radii_spatial),co_x) == 1)
                        standard_count = standard_count + 1;
                        iris((co_y-radii_spatial),co_x) = 1;
                    elseif(edgeInput((co_y-radii_spatial+1),co_x) == 1)
                        plus_count = plus_count + 1;
                        iris((co_y-radii_spatial+1),co_x) = 1;
                    elseif(edgeInput((co_y-radii_spatial-1),co_x) == 1)
                        minus_count = minus_count + 1;
                        iris((co_y-radii_spatial-1),co_x) = 1;
                    elseif(edgeInput((co_y-radii_spatial+2),co_x) == 1)
                        plus_count_2 = plus_count_2 + 1;
                        iris((co_y-radii_spatial+2),co_x) = 1;
                    elseif(edgeInput((co_y-radii_spatial-2),co_x) == 1)
                        minus_count_2 = minus_count_2 + 1;
                        iris((co_y-radii_spatial-2),co_x) = 1;
                    end
                end
            elseif (co_y == centroid(1))
                if (co_x > centroid(2))%|C|
                    if(edgeInput(co_y,(co_x+radii_spatial)) == 1)
                        standard_count = standard_count + 1;
                        iris(co_y,(co_x+radii_spatial)) = 1;
                    elseif(edgeInput(co_y,(co_x+radii_spatial+1)) == 1)
                        plus_count = plus_count + 1;
                        iris(co_y,(co_x+radii_spatial+1)) = 1;
                    elseif(edgeInput(co_y,(co_x+radii_spatial-1)) == 1)
                        minus_count = minus_count + 1;
                        iris(co_y,(co_x+radii_spatial-1)) = 1;
                    elseif(edgeInput(co_y,(co_x+radii_spatial+2)) == 1)
                        plus_count_2 = plus_count_2 + 1;
                        iris(co_y,(co_x+radii_spatial+2)) = 1;
                    elseif(edgeInput(co_y,(co_x+radii_spatial-2)) == 1)
                        minus_count_2 = minus_count_2 + 1;
                        iris(co_y,(co_x+radii_spatial-2)) = 1;
                    end
                else%|D|
                    if(edgeInput(co_y,(co_x-radii_spatial)) == 1)
                        standard_count = standard_count + 1;
                        iris(co_y,(co_x-radii_spatial)) = 1;
                    elseif(edgeInput(co_y,(co_x-radii_spatial+1)) == 1)
                        plus_count = plus_count + 1;
                        iris(co_y,(co_x-radii_spatial+1)) = 1;
                    elseif(edgeInput(co_y,(co_x-radii_spatial-1)) == 1)
                        minus_count = minus_count + 1;
                        iris(co_y,(co_x-radii_spatial-1)) = 1;
                    elseif(edgeInput(co_y,(co_x-radii_spatial+2)) == 1)
                        plus_count_2 = plus_count_2 + 1;
                        iris(co_y,(co_x-radii_spatial+2)) = 1;
                    elseif(edgeInput(co_y,(co_x-radii_spatial-2)) == 1)
                        minus_count_2 = minus_count_2 + 1;
                        iris(co_y,(co_x-radii_spatial-2)) = 1;
                    end 
                end

             
            elseif ((centroid(1) < co_y)&&(centroid(2) < co_x))%|G|
                %real
                irisCoordinates_real = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial);
                %appended
                irisCoordinates_appended = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial+1);
                %prepended
                irisCoordinates_prepended = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial-1);
                %appended
                irisCoordinates_appended_2 = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial+2);
                %prepended
                irisCoordinates_prepended_2 = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial-2);
                if(edgeInput(irisCoordinates_real(2),irisCoordinates_real(1)) == 1)
                    %disp('Working G 1');
                    standard_count = standard_count + 1;
                    iris(irisCoordinates_real(2),irisCoordinates_real(1)) = 1;
                elseif(edgeInput(irisCoordinates_appended(2),irisCoordinates_appended(1)) == 1)
                    %disp('Working G 2');
                    plus_count = plus_count + 1;
                    iris(irisCoordinates_appended(2),irisCoordinates_appended(1)) = 1;
                elseif(edgeInput(irisCoordinates_prepended(2),irisCoordinates_prepended(1)) == 1)
                    %disp('Working G 3');
                    minus_count = minus_count + 1;
                    iris(irisCoordinates_prepended(2),irisCoordinates_prepended(1)) = 1;
                elseif(edgeInput(irisCoordinates_appended_2(2),irisCoordinates_appended_2(1)) == 1)
                    %disp('Working G 2');
                    plus_count_2 = plus_count_2 + 1;
                    iris(irisCoordinates_appended_2(2),irisCoordinates_appended_2(1)) = 1;
                elseif(edgeInput(irisCoordinates_prepended_2(2),irisCoordinates_prepended_2(1)) == 1)
                    %disp('Working G 3');
                    minus_count_2 = minus_count_2 + 1;
                    iris(irisCoordinates_prepended_2(2),irisCoordinates_prepended_2(1)) = 1;
                end
            elseif ((centroid(1) > co_y)&&(centroid(2) > co_x))%|H|cautious. Threshold point (271,54).
                %real
                irisCoordinates_real = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial);
                %appended
                irisCoordinates_appended = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial+1);
                %prepended
                irisCoordinates_prepended = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial-1);
                %appended
                irisCoordinates_appended_2 = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial+2);
                %prepended
                irisCoordinates_prepended_2 = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial-2);
                if(edgeInput(irisCoordinates_real(2),irisCoordinates_real(1)) == 1)
                    %disp('Working H 1');
                    standard_count = standard_count + 1;
                    iris(irisCoordinates_real(2),irisCoordinates_real(1)) = 1;
                elseif(edgeInput(irisCoordinates_appended(2),irisCoordinates_appended(1)) == 1)
                    %disp('Working H 2');
                    plus_count = plus_count + 1;
                    iris(irisCoordinates_appended(2),irisCoordinates_appended(1)) = 1;
                elseif(edgeInput(irisCoordinates_prepended(2),irisCoordinates_prepended(1)) == 1)
                    %disp('Working H 3');
                    minus_count = minus_count + 1;
                    iris(irisCoordinates_prepended(2),irisCoordinates_prepended(1)) = 1;
                elseif(edgeInput(irisCoordinates_appended_2(2),irisCoordinates_appended_2(1)) == 1)
                    %disp('Working H 2');
                    plus_count_2 = plus_count_2 + 1;
                    iris(irisCoordinates_appended_2(2),irisCoordinates_appended_2(1)) = 1;
                elseif(edgeInput(irisCoordinates_prepended_2(2),irisCoordinates_prepended_2(1)) == 1)
                    %disp('Working H 3');
                    minus_count_2 = minus_count_2 + 1;
                    iris(irisCoordinates_prepended_2(2),irisCoordinates_prepended_2(1)) = 1;
                end          
                
            elseif ((centroid(2) < co_x)&&(centroid(1) > co_y))%|F|cautious. Threshold point (120,65).
                %real
                irisCoordinates_real = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial);
                %appended
                irisCoordinates_appended = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial+1);
                %prepended
                irisCoordinates_prepended = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial-1);
                %appended
                irisCoordinates_appended_2 = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial+2);
                %prepended
                irisCoordinates_prepended_2 = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial-2);
                
                %An unwanted negative came up at some point for Sample
                %M144342 solved by finding absolute in 'findIrisCoordinates'
                %fprintf('\n REALx %d : REALy %d',irisCoordinates_real(2),irisCoordinates_real(1));
                
                
                if(edgeInput(irisCoordinates_real(2),irisCoordinates_real(1)) == 1)
                    %disp('Working F 1');
                    standard_count = standard_count + 1;
                    iris(irisCoordinates_real(2),irisCoordinates_real(1)) = 1;
                elseif(edgeInput(irisCoordinates_appended(2),irisCoordinates_appended(1)) == 1)
                    %disp('Working F 2');
                    plus_count = plus_count + 1;
                    iris(irisCoordinates_appended(2),irisCoordinates_appended(1)) = 1;
                elseif(edgeInput(irisCoordinates_prepended(2),irisCoordinates_prepended(1)) == 1)
                    %disp('Working F 3');
                    minus_count = minus_count + 1;
                    iris(irisCoordinates_prepended(2),irisCoordinates_prepended(1)) = 1;
                elseif(edgeInput(irisCoordinates_appended_2(2),irisCoordinates_appended_2(1)) == 1)
                    %disp('Working F 2');
                    plus_count_2 = plus_count_2 + 1;
                    iris(irisCoordinates_appended_2(2),irisCoordinates_appended_2(1)) = 1;
                elseif(edgeInput(irisCoordinates_prepended_2(2),irisCoordinates_prepended_2(1)) == 1)
                    %disp('Working F 3');
                    minus_count_2 = minus_count_2 + 1;
                    iris(irisCoordinates_prepended_2(2),irisCoordinates_prepended_2(1)) = 1;
                end             
            elseif ((centroid(2) > co_x)&&(centroid(1) < co_y))%|E|
                %real
                irisCoordinates_real = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial);
                %appended
                irisCoordinates_appended = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial+1);
                %prepended
                irisCoordinates_prepended = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial-1);
                %appended
                irisCoordinates_appended_2 = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial+2);
                %prepended
                irisCoordinates_prepended_2 = findIrisCoordinates([co_x co_y],[centroid(2) centroid(1)],radii_spatial-2);
                if(edgeInput(irisCoordinates_real(2),irisCoordinates_real(1)) == 1)
                    %disp('Working E 1');
                    standard_count = standard_count + 1;
                    iris(irisCoordinates_real(2),irisCoordinates_real(1)) = 1;
                elseif(edgeInput(irisCoordinates_appended(2),irisCoordinates_appended(1)) == 1)
                    %disp('Working E 2');
                    plus_count = plus_count + 1;
                    iris(irisCoordinates_appended(2),irisCoordinates_appended(1)) = 1;
                elseif(edgeInput(irisCoordinates_prepended(2),irisCoordinates_prepended(1)) == 1)
                    %disp('Working E 3');
                    minus_count = minus_count + 1;
                    iris(irisCoordinates_prepended(2),irisCoordinates_prepended(1)) = 1;
                elseif(edgeInput(irisCoordinates_appended_2(2),irisCoordinates_appended_2(1)) == 1)
                    %disp('Working E 2');
                    plus_count_2 = plus_count_2 + 1;
                    iris(irisCoordinates_appended_2(2),irisCoordinates_appended_2(1)) = 1;
                elseif(edgeInput(irisCoordinates_prepended_2(2),irisCoordinates_prepended_2(1)) == 1)
                    %disp('Working E 3');
                    minus_count_2 = minus_count_2 + 1;
                    iris(irisCoordinates_prepended_2(2),irisCoordinates_prepended_2(1)) = 1;
                end             
            else
                disp('The eye input is invalid. Failed in irisRetiever.'); 
            end
        else
            
        end
    end
end  
end

