function ex_ssc_omp(num_subjects)
    if nargin < 1
        num_subjects = 2;
    end
    close all;
    clc;
    check_yale_faces(num_subjects, @ssc_mc_omp, 'ssc_mc_omp');
end

