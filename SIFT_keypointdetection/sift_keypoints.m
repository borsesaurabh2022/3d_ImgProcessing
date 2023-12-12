classdef sift_keypoints

    properties
        scale;
        octave;
        layer;
        positions;      % x,y,(z) co-ordinate of keypoint
        metric;
        image_pyramid;  % sift data set:data from sift operator 
        counter;        % counter fro no. of keypoints found
        area_values;    % keaypoint area
        thr = 0.03;     % treshold for  Keypoints
        r = 10;         % edge treshold für Keypoints 
    end

    methods
        function obj = sift_keypoints(input_sift_matcher)
            % read dataset object from the SIFT operator(gaussiand & DoG pyramid)
            obj.image_pyramid=input_sift_matcher;
        end

        function obj = find_all_keypoints(obj)
            n_octave = obj.image_pyramid.octave;
            s = obj.image_pyramid.s;
            obj.counter = 0;               

            for i = (1:n_octave)                       % Iterate over all octaves
                [n_rows, n_coloums]=size(obj.image_pyramid.gauss_diff_p{1,i}); % Determine no. of pixels in image based on First image of the octave
                for j = (2:s+1)                          % Run over all frames of an octave except for the 1st and last frame
                    for x = (2:n_rows-1)                 % Run over all pixels along the vertical except the 1st and last pixel
                        for y = (2:n_coloums-1)          % Run over all pixels along the horizontal except the 1st and last pixel
                            for n = (1:3)
                                for m = (1:3)
                                    % "area" contains the values of the 26 neighboring pixels
                                    area(1,n,m) = obj.image_pyramid.gauss_diff_p{j-1,i}(x-2+n,y-2+m);
                                    area(2,n,m) = obj.image_pyramid.gauss_diff_p{j,i}(x-2+n,y-2+m);
                                    area(3,n,m) = obj.image_pyramid.gauss_diff_p{j+1,i}(x-2+n,y-2+m);
                                end
                            end
                            maxima_check = nnz(obj.image_pyramid.gauss_diff_p{j,i}(x,y) > area);
                            minima_check = nnz(obj.image_pyramid.gauss_diff_p{j,i}(x,y) < area);
                            if maxima_check == 26 || minima_check == 26
                                        
                                % Siehe Vorlesung-Folien zu SIFT
                                % S.36f
    
                                up= obj.image_pyramid.gauss_diff_p{j-1,i};
                                curr = obj.image_pyramid.gauss_diff_p{j,i};
                                down = obj.image_pyramid.gauss_diff_p{j+1,i};
    
                                % calculate the second derivates in x-, y-, z-direction
                                % (here sigma = z)
                                Dxx= curr(x-1,y)+curr(x+1,y)-2*curr(x,y);
                                Dyy= curr(x,y-1)+curr(x,y+1)-2*curr(x,y);
                                Dzz=up(x,y)+down(x,y)-2*curr(x,y);

                                % calculate all mixed derivatives for the Hessian matrix
                                Dxz=((up(x+1,y)-down(x+1,y))-(up(x-1,y)-down(x-1,y)))/4;
                                Dyz=((up(x,y+1)-down(x,y+1))-(up(x,y-1)-down(x,y-1)))/4;
                                Dxy= curr(x-1,y-1)+curr(x+1,y+1)-curr(x-1,y+1)-curr(x+1,y-1);
                                Dx=curr(x,y)-curr(x-1,y);
                                Dy=curr(x,y)-curr(x,y-1);
                                Dz=(up(x,y)-down(x,y))/2;

                                % create the Hessian matrix with all derivates (i.e. fxy=fyx)
                                H=[Dzz Dxz Dyz;
                                Dxz Dxx Dxy;
                                Dyz Dxy Dyy];
                                
                                %The scale of the keypoint sigma is the smaller of
                                %the two gaussian images from the DoG image
                                Dsigma = obj.image_pyramid.sigma_gauss_diff_p{j,i};

                                % extrema localization using Taylor series
                                X=-inv(H)*([Dz Dx Dy]');

                                % calculate the DoG value at the extrema position px,py
                                D_hat=curr(x,y) + ([Dz Dx Dy]*X)/2;

                                % if this value is below a threshold value this point is
                                % excluded, otherwise make further calculations
                                if abs(D_hat) > obj.thr % further consideration of the keypoint

                                % Eliminate poorly localized extrema: In these cases there
                                % is a large principle curvature across the edge but a
                                % small curvature in the perpendicular direction in the DoG
                                % Compute the Hessian matrix with: H = [Dxx Dxy ; Dxy Dyy
                                % Curvature criteria is trace(h)^2/det (H) < (r+1)^2/r
                                % the principal curvature must be below a threshold r

                                    if ((Dxx + Dyy )^2/(Dxx *Dyy-Dxy^2))<((obj.r+1)^ 2/obj.r)
                                        metric_abs = abs(D_hat);    %wofür Variable gebraucht wird, ist mir noch unbekannt
                                        %rejected=false;  
                                        obj.counter = obj.counter+1;
                                        obj.scale(obj.counter,1) = Dsigma;
                                        obj.octave(obj.counter,1) = i;
                                        obj.layer(obj.counter,1) = j;
                                        obj.metric(obj.counter,1) = metric_abs;
                                        obj.area_values(obj.counter,:,:,:)=area(:,:,:);
                                        obj.positions(obj.counter,:) = [X(1), X(2), X(3), x+X(2), y+X(3), x, y];
                                    end
                                end
                            end 
                        end
                    end
                end
            end
        end
    end
end
