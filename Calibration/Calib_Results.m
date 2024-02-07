% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3105.986147954631178 ; 3126.375038459038478 ];

%-- Principal point:
cc = [ 1977.575626844467934 ; 1484.792530486857686 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.094021432491376 ; -0.206330397732326 ; -0.004059304451075 ; -0.003374473306756 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 4.080484130084992 ; 4.039405611074067 ];

%-- Principal point uncertainty:
cc_error = [ 4.912478124592404 ; 4.377073832593060 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.004678898518318 ; 0.011013489072303 ; 0.000513578810753 ; 0.000559214512906 ; 0.000000000000000 ];

%-- Image size:
nx = 4032;
ny = 3024;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.928895e+00 ; -2.013831e+00 ; -1.564444e-01 ];
Tc_1  = [ 1.416504e+02 ; 1.021888e+02 ; 2.882940e+02 ];
omc_error_1 = [ 1.730402e-03 ; 1.949169e-03 ; 3.344800e-03 ];
Tc_error_1  = [ 5.077328e-01 ; 4.476265e-01 ; 5.823775e-01 ];

%-- Image #2:
omc_2 = [ 1.955145e+00 ; -2.061855e+00 ; 8.268894e-02 ];
Tc_2  = [ 1.613254e+02 ; 8.224223e+01 ; 2.962203e+02 ];
omc_error_2 = [ 1.627762e-03 ; 2.054838e-03 ; 3.398099e-03 ];
Tc_error_2  = [ 5.040910e-01 ; 4.603805e-01 ; 5.896728e-01 ];

%-- Image #3:
omc_3 = [ -2.090823e+00 ; 2.082781e+00 ; 4.802041e-01 ];
Tc_3  = [ 1.626264e+02 ; 1.245370e+02 ; 3.492864e+02 ];
omc_error_3 = [ 1.614161e-03 ; 1.722095e-03 ; 3.386330e-03 ];
Tc_error_3  = [ 5.649495e-01 ; 5.100983e-01 ; 5.468031e-01 ];

%-- Image #4:
omc_4 = [ -2.115826e+00 ; 2.193914e+00 ; 5.096980e-02 ];
Tc_4  = [ 1.798327e+02 ; 1.159445e+02 ; 3.395947e+02 ];
omc_error_4 = [ 1.833347e-03 ; 1.832427e-03 ; 3.706350e-03 ];
Tc_error_4  = [ 5.479230e-01 ; 5.013717e-01 ; 5.798649e-01 ];

%-- Image #5:
omc_5 = [ 2.233877e+00 ; -1.994135e+00 ; -7.903410e-01 ];
Tc_5  = [ 1.075326e+02 ; 1.301826e+02 ; 3.234464e+02 ];
omc_error_5 = [ 1.885427e-03 ; 1.299262e-03 ; 3.178663e-03 ];
Tc_error_5  = [ 5.327283e-01 ; 4.615367e-01 ; 5.115307e-01 ];

%-- Image #6:
omc_6 = [ 1.964878e+00 ; -1.779249e+00 ; -9.749312e-01 ];
Tc_6  = [ 5.478061e+01 ; 1.222267e+02 ; 2.964431e+02 ];
omc_error_6 = [ 1.814345e-03 ; 1.288980e-03 ; 2.526547e-03 ];
Tc_error_6  = [ 4.905170e-01 ; 4.180839e-01 ; 4.866879e-01 ];

%-- Image #7:
omc_7 = [ 1.657946e+00 ; -1.828243e+00 ; -5.689511e-01 ];
Tc_7  = [ 6.056372e+01 ; 9.578059e+01 ; 2.461205e+02 ];
omc_error_7 = [ 1.581770e-03 ; 1.455796e-03 ; 2.304009e-03 ];
Tc_error_7  = [ 4.214485e-01 ; 3.603941e-01 ; 4.755742e-01 ];

%-- Image #8:
omc_8 = [ 1.684311e+00 ; -1.796975e+00 ; 3.097468e-01 ];
Tc_8  = [ 1.124016e+02 ; 5.643244e+01 ; 2.188286e+02 ];
omc_error_8 = [ 1.265625e-03 ; 1.604165e-03 ; 2.246441e-03 ];
Tc_error_8  = [ 3.790477e-01 ; 3.419056e-01 ; 4.298920e-01 ];

%-- Image #9:
omc_9 = [ 1.985024e+00 ; -2.159143e+00 ; 8.095797e-01 ];
Tc_9  = [ 1.643504e+02 ; 6.917295e+01 ; 2.748058e+02 ];
omc_error_9 = [ 1.105029e-03 ; 1.690302e-03 ; 2.597391e-03 ];
Tc_error_9  = [ 4.384007e-01 ; 4.090535e-01 ; 4.251806e-01 ];

%-- Image #10:
omc_10 = [ -2.066423e+00 ; 2.127922e+00 ; -4.143006e-01 ];
Tc_10  = [ 1.506713e+02 ; 9.203053e+01 ; 3.132964e+02 ];
omc_error_10 = [ 1.565653e-03 ; 1.368541e-03 ; 2.895423e-03 ];
Tc_error_10  = [ 4.971240e-01 ; 4.529337e-01 ; 4.589864e-01 ];

%-- Image #11:
omc_11 = [ 1.634724e+00 ; -1.784212e+00 ; -4.532166e-01 ];
Tc_11  = [ 2.486580e+01 ; 8.687618e+01 ; 2.120277e+02 ];
omc_error_11 = [ 1.538130e-03 ; 1.392471e-03 ; 2.151076e-03 ];
Tc_error_11  = [ 3.600558e-01 ; 3.092661e-01 ; 4.183224e-01 ];

%-- Image #12:
omc_12 = [ 2.217220e+00 ; -1.431891e+00 ; -1.037891e+00 ];
Tc_12  = [ -6.658521e+00 ; 1.373025e+02 ; 2.995853e+02 ];
omc_error_12 = [ 1.887434e-03 ; 1.155462e-03 ; 2.434998e-03 ];
Tc_error_12  = [ 4.888879e-01 ; 4.201603e-01 ; 4.673456e-01 ];

%-- Image #13:
omc_13 = [ -2.178309e+00 ; 1.839872e+00 ; 1.007533e+00 ];
Tc_13  = [ 8.946415e+01 ; 1.339691e+02 ; 3.088188e+02 ];
omc_error_13 = [ 1.217703e-03 ; 1.640737e-03 ; 2.661379e-03 ];
Tc_error_13  = [ 4.986395e-01 ; 4.372665e-01 ; 4.227048e-01 ];

%-- Image #14:
omc_14 = [ -1.836883e+00 ; 1.585115e+00 ; 8.998832e-01 ];
Tc_14  = [ 1.040286e+02 ; 1.136509e+02 ; 4.234338e+02 ];
omc_error_14 = [ 1.301222e-03 ; 1.692030e-03 ; 2.291537e-03 ];
Tc_error_14  = [ 6.741484e-01 ; 6.035635e-01 ; 4.637700e-01 ];

%-- Image #15:
omc_15 = [ -1.717370e+00 ; 1.549416e+00 ; 3.195549e-01 ];
Tc_15  = [ 1.276400e+02 ; 9.607182e+01 ; 4.772481e+02 ];
omc_error_15 = [ 1.402136e-03 ; 1.610176e-03 ; 2.170216e-03 ];
Tc_error_15  = [ 7.601330e-01 ; 6.905895e-01 ; 4.750861e-01 ];

%-- Image #16:
omc_16 = [ -2.035508e+00 ; 2.158112e+00 ; -1.764710e-01 ];
Tc_16  = [ 1.293632e+02 ; 1.003861e+02 ; 3.448605e+02 ];
omc_error_16 = [ 1.611471e-03 ; 1.800374e-03 ; 3.395540e-03 ];
Tc_error_16  = [ 5.489465e-01 ; 4.896729e-01 ; 5.269787e-01 ];

%-- Image #17:
omc_17 = [ 1.743829e+00 ; -1.831435e+00 ; -3.989518e-01 ];
Tc_17  = [ 5.809437e+01 ; 9.097282e+01 ; 2.226259e+02 ];
omc_error_17 = [ 1.515407e-03 ; 1.410376e-03 ; 2.323686e-03 ];
Tc_error_17  = [ 3.818581e-01 ; 3.295904e-01 ; 4.300027e-01 ];

%-- Image #18:
omc_18 = [ 1.905159e+00 ; -2.052464e+00 ; 8.473909e-01 ];
Tc_18  = [ 1.552609e+02 ; 7.985128e+01 ; 2.644347e+02 ];
omc_error_18 = [ 1.149984e-03 ; 1.639771e-03 ; 2.515573e-03 ];
Tc_error_18  = [ 4.276838e-01 ; 3.989880e-01 ; 4.211978e-01 ];

%-- Image #19:
omc_19 = [ 1.985175e+00 ; -2.021615e+00 ; 7.638147e-01 ];
Tc_19  = [ 1.478614e+02 ; 7.996782e+01 ; 2.656188e+02 ];
omc_error_19 = [ 1.192893e-03 ; 1.621966e-03 ; 2.585326e-03 ];
Tc_error_19  = [ 4.290122e-01 ; 3.992001e-01 ; 4.260443e-01 ];

%-- Image #20:
omc_20 = [ -1.788198e+00 ; 1.641549e+00 ; 2.927489e-01 ];
Tc_20  = [ 1.322944e+02 ; 9.698828e+01 ; 4.676500e+02 ];
omc_error_20 = [ 1.454838e-03 ; 1.639896e-03 ; 2.382111e-03 ];
Tc_error_20  = [ 7.413366e-01 ; 6.752115e-01 ; 4.873396e-01 ];

