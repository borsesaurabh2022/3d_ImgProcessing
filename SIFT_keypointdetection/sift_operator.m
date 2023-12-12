classdef sift_operator
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    properties
        img;
        octave = 5;
        s = 3;
        k;                      
        gauss_p;
        gauss_diff_p;
        sigma_gauss_p;         
        sigma_gauss_diff_p;    
        p_min = 5;
    end

    methods
        % init function to initialize the parameters for the function and
        % check for image validity 
        function obj = sift_operator(input_img)

            % Check if input img is gray 
            if(size(input_img,3) == 3)
                obj.img = im2double(im2gray(input_img));
            else
                obj.img = im2double(input_img);
            end
            
            % define scale value and cell to store gaussian and diff of
            % gaussian images 
            obj.k = 2^(1/obj.s);
            obj.gauss_p = cell(obj.s+3, obj.octave);
            obj.gauss_diff_p = cell(obj.s+2, obj.octave);
        end

        function obj = gauss_and_dog_pyramid(obj) 
            %UNTITLED2 Construct an instance of this class
            %   Detailed explanation goes here
            %original_img = obj.img;
            
            % Iterate over no. of octave and compurte the gaussian image
            % with increasing value of sigma and corresponding kernal size
            % from octave = 1 to octave =5
            for i = 1:obj.octave
                if i == 1
                    original_img = obj.img;
                else
                    original_img = imresize(obj.gauss_p{floor((obj.s + 3)/2 + 1), i-1}, 0.5);
                end
                sigma_init = (2^i)/4;
                sigma = sigma_init*obj.k;
                kernalSize = 2 * ceil(3 * sigma) + 1;
                k_filter = fspecial("gaussian", kernalSize, sigma);
                obj.gauss_p{1,i} = imfilter(original_img,k_filter ,'conv');
                obj.sigma_gauss_p{1,i} = sigma;
                for j = 2:obj.s+3
                    sigma = sigma*obj.k;
                    kernalSize = 2 * ceil(3 * sigma) + 1;
                    k_filter = fspecial("gaussian", kernalSize, sigma);
                    obj.gauss_p{j, i} = imfilter(original_img, k_filter, 'conv');
                    obj.sigma_gauss_p{j,i} = sigma;
                    obj.gauss_diff_p{j-1,i} = obj.gauss_p{j-1,i} - obj.gauss_p{j,i};
                    obj.sigma_gauss_diff_p{j-1,i} = obj.sigma_gauss_p{j-1,i};
                end
            end 
        end
    end
end