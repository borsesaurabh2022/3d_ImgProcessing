classdef sift_orientation

    properties
        grad_magnitude; % magnitude of gradient
        grad_direction; % direction of gradient 
        counter; 
        keypoints;
        orientation;
        orientation_hist;
        scale;
    end

    methods
        function obj = sift_orientation(input_sift_matcher)
            % read dataset object from the SIFT operator(gaussiand & DoG pyramid)
            obj.keypoints =input_sift_matcher;
            
        end

        function obj = find_gradient(obj)
            n_keypoints = obj.keypoints.counter;
            obj.counter = 0;  
            for i = 1:n_keypoints
                x = obj.keypoints.positions(i,6);
                y = obj.keypoints.positions(i,7);
                n_octave = obj.keypoints.octave(i);
                n_layer = obj.keypoints.layer(i);
                process_img = obj.keypoints.image_pyramid.gauss_diff_p{n_layer,n_octave};
                [img_h, img_w] = size(obj.keypoints.image_pyramid.gauss_diff_p{n_layer,n_octave});
                if x > 8 && x < (img_w-8)
                    if y > 8 && y < (img_h-8)
                        roi = process_img(y-8:y+7,x-8:x+7);
                        [n_cols, n_rows] = size(roi);
                        for m = (2:n_rows-1)
                            for n = (2:n_cols-1)
                                prev_pixx = roi(m,n-1);
                                next_pixx = roi(m,n+1); 
                                prev_pixy = roi(m-1,n);
                                next_pixy = roi(m+1,n);
                                obj.grad_magnitude{i,1}(m,n) = sqrt((next_pixx-prev_pixx)^2+(next_pixy-prev_pixy)^2);
                                obj.grad_direction{i,1}(m,n) = mod(rad2deg(atan2((next_pixy-prev_pixy),(next_pixx-prev_pixx))), 360);
                            end
                        end
                           
                    end
                end
            end
        end

        function obj = find_histogram(obj)
            n_keypoints = obj.keypoints.counter;
            for j = 1:n_keypoints
                if ~isempty(obj.grad_direction{j,1})
                    obj.grad_direction{j,1} = obj.grad_direction{j,1}(2:15,2:15);
                    obj.grad_magnitude{j,1} = obj.grad_magnitude{j,1}(2:15,2:15);
                end
            end
            for j = 1:n_keypoints  
                if ~isempty(obj.grad_direction{j,1})
                    obj.orientation_hist{j,1} = histogram(obj.grad_direction{j,1},36,"Normalization","probability");
                    [obj.orientation(j,1),obj.orientation(j,2)] = max(obj.orientation_hist{j,1}.Values);
                    obj.orientation(j,3) = (obj.orientation_hist{j,1}.BinEdges(obj.orientation(j,2))+obj.orientation_hist{j,1}.BinEdges(obj.orientation(j,2)+1))/2;
                    obj.scale(j,1) = obj.keypoints.scale(j,1)*1.5;
                    obj.scale(j,2) = mean(obj.grad_magnitude{j,1},"all");
                end
            end
        end
    end
end
