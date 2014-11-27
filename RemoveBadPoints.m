function[positions] = RemoveBadPoints(ScanPoints1, ScanPoints2, ScanPoints3, ScanPoints4, fipLength)
    for j = 1:4
        % Calculate the distance from every point to all the others
        dist1 = [];
        dist2 = [];
        dist3 = [];

        if j == 1
            for i = 1:length(ScanPoints1)
                dist1(i,:) = sqrt((ScanPoints2(:,1)-ScanPoints1(i,1)).^2+(ScanPoints2(:,2)-ScanPoints1(i,2)).^2)';
                dist2(i,:) = sqrt((ScanPoints3(:,1)-ScanPoints1(i,1)).^2+(ScanPoints3(:,2)-ScanPoints1(i,2)).^2)';
                dist3(i,:) = sqrt((ScanPoints4(:,1)-ScanPoints1(i,1)).^2+(ScanPoints4(:,2)-ScanPoints1(i,2)).^2)';
            end
        elseif j == 2
            for i = 1:length(ScanPoints2)
                dist1(i,:) = sqrt((ScanPoints1(:,1)-ScanPoints2(i,1)).^2+(ScanPoints1(:,2)-ScanPoints2(i,2)).^2)';
                dist2(i,:) = sqrt((ScanPoints3(:,1)-ScanPoints2(i,1)).^2+(ScanPoints3(:,2)-ScanPoints2(i,2)).^2)';
                dist3(i,:) = sqrt((ScanPoints4(:,1)-ScanPoints2(i,1)).^2+(ScanPoints4(:,2)-ScanPoints2(i,2)).^2)';
            end
        elseif j == 3
            for i = 1:length(ScanPoints3)
                dist1(i,:) = sqrt((ScanPoints2(:,1)-ScanPoints3(i,1)).^2+(ScanPoints2(:,2)-ScanPoints3(i,2)).^2)';
                dist2(i,:) = sqrt((ScanPoints1(:,1)-ScanPoints3(i,1)).^2+(ScanPoints1(:,2)-ScanPoints3(i,2)).^2)';
                dist3(i,:) = sqrt((ScanPoints4(:,1)-ScanPoints3(i,1)).^2+(ScanPoints4(:,2)-ScanPoints3(i,2)).^2)';
            end
        else
            for i = 1:length(ScanPoints4)
                dist1(i,:) = sqrt((ScanPoints2(:,1)-ScanPoints4(i,1)).^2+(ScanPoints2(:,2)-ScanPoints4(i,2)).^2)';
                dist2(i,:) = sqrt((ScanPoints3(:,1)-ScanPoints4(i,1)).^2+(ScanPoints3(:,2)-ScanPoints4(i,2)).^2)';
                dist3(i,:) = sqrt((ScanPoints1(:,1)-ScanPoints4(i,1)).^2+(ScanPoints1(:,2)-ScanPoints4(i,2)).^2)';
            end
        end

        % Remove points that are further away from any other point than
        % fipLength
        dist1(dist1 > fipLength) = 0;
        dist2(dist2 > fipLength) = 0;
        dist3(dist3 > fipLength) = 0;

        % Get the positions of the points based on their indices. 
        [rowsVerticalHorizontal cols] = find(dist1); %// find row and col indices
        [rowsdistDiagonalHorizontal1 cols] = find(dist2); %// find row and col indices
        [rowsdistDiagonalHorizontal2 cols] = find(dist3); %// find row and col indices

        % Create a new matrix of points with points from all different sets. 
        % Remove duplicates and sort the matrix
        scanReferenceIndex = [rowsVerticalHorizontal; rowsdistDiagonalHorizontal1; rowsdistDiagonalHorizontal2];
        [~,index] = unique(scanReferenceIndex,'first');        %# Capture the index, ignore the actual values
        scanReferenceIndex = sort(scanReferenceIndex(sort(index))); %# Index nearHorizontalPointsIndex with the sorted index

        % Only return points with indices that are close to other points
        if j == 1
            ScanPoints1 = ScanPoints1(scanReferenceIndex, :);
        elseif j == 2
            ScanPoints2 = ScanPoints2(scanReferenceIndex, :);
        elseif j == 3
            ScanPoints3 = ScanPoints3(scanReferenceIndex, :);
        elseif j == 4
            ScanPoints4 = ScanPoints4(scanReferenceIndex, :);
        end
    end
    
    positions = [ScanPoints1; ScanPoints2; ScanPoints3; ScanPoints4];
    
end