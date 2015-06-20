% The library contains several unit tests written using
% XUnit test framework. To execute these tests, the
% library must be installed.
close all; clear all; clc;
globals = spx_setup();

include_long_tests = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd (fullfile(globals.commons, 'tests'));
runtests;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd (fullfile(globals.dictionary, 'tests'));
runtests;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd (fullfile(globals.conjugate_gradient, 'tests'));
runtests;

cd (fullfile(globals.steepest_descent, 'tests'));
runtests;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if include_long_tests
cd (fullfile(globals.basis_pursuit, 'tests'));
runtests;
end

cd (fullfile(globals.cosamp, 'tests'));
runtests;

cd (fullfile(globals.matching_pursuit, 'tests'));
runtests;

cd (fullfile(globals.orthogonal_matching_pursuit, 'tests'));
runtests;


% Finally return to the main directory
cd(globals.root);