function tests = test_lansvd
  tests = functiontests(localfunctions);
end

function A = mat_simple1_1(n)
    m = 200;
    if nargin < 1
        n = 50;
    end
    U0 = orth(randn(m));
    V0 = orth(randn(n));
    S0 = zeros(m, n);
    for i=1:n
        S0(i,i) = m / (i);
    end
    A = U0*S0*V0';
end

function verify_lansvd(A, k, testCase)
    S1 = svds(A, k);
    options.verbosity = 0;
    options.tolerance = 16 * eps;
    options.k = k;
    S2 = spx.fast.lansvd(A, options);
    verifyEqual(testCase, S1, S2, 'RelTol', 1e-9);

    [U1, S1, V1] = svds(A, k);
    S1 = diag(S1);
    [U2, S2, V2] = spx.fast.lansvd(A, options);
    verifyEqual(testCase, S1, S2, 'RelTol', 1e-9);
    verifyEqual(testCase, spx.la.nonorthogonality(U2), 0, 'AbsTol', 1e-9);
    verifyEqual(testCase, spx.la.nonorthogonality(V2), 0, 'AbsTol', 1e-9);
    % TODO this tolerance is very high
    verifyEqual(testCase, abs(U1), abs(U2), 'AbsTol', 1e-5);
    % verifyEqual(testCase, abs(V1), abs(V2), 'AbsTol', 1e-12);
end

function verify_lansvd_func_handle(A, k, testCase)
    S.A = @(x)  A *x;
    S.At = @(x)  (x' * A)';
    [M, N] = size(A);
    S.M = M;
    S.N = N;

    S1 = svds(A, k);
    options.verbosity = 0;
    options.tolerance = 16 * eps;
    options.k = k;
    S2 = spx.fast.lansvd(S, options);
    verifyEqual(testCase, S1, S2, 'RelTol', 1e-9);

    [U1, S1, V1] = svds(A, k);
    [U2, S2, V2] = spx.fast.lansvd(S, options);
    verifyEqual(testCase, S1, S2, 'RelTol', 1e-9);
    verifyEqual(testCase, spx.la.nonorthogonality(U2), 0, 'AbsTol', 1e-10);
    verifyEqual(testCase, spx.la.nonorthogonality(V2), 0, 'AbsTol', 1e-10);
    verifyEqual(testCase, abs(U1), abs(U2), 'AbsTol', 1e-12);
    verifyEqual(testCase, abs(V1), abs(V2), 'AbsTol', 1e-12);
end

function verify_lansvd_svt(A, lambda, testCase)
    options.verbosity = 0;
    options.tolerance = 16 * eps;
    options.lambda = lambda;
    S2 = spx.fast.lansvd(A, options);
    k = numel(S2);
    S1 = svds(A, k+1);
    % verify that the singular value after k-th one is smaller than the threshold
    verifyTrue(testCase, S1(k+1) <= lambda);
    verifyEqual(testCase, S1(1:k), S2, 'RelTol', 1e-9);
end


function test_simple_cases(testCase)
    A = [];
    verify_lansvd(A, 1, testCase);
    A = [2.4];
    verify_lansvd(A, 1, testCase);
end

function test_single_row(testCase)
    A = [1 2 3];
    verify_lansvd(A, 1, testCase);
    verify_lansvd_func_handle(A, 1, testCase);
end

function test_single_col(testCase)
    A = [1 2 3]';
    verify_lansvd(A, 1, testCase);
end

function test_1(testCase)
    verify_lansvd(spx.data.mtx_mkt.abb313, 4, testCase);
    verify_lansvd(spx.data.mtx_mkt.abb313, 10, testCase);
end

function test_2(testCase)
    verify_lansvd(spx.data.mtx_mkt.illc1850, 4, testCase);
    verify_lansvd(spx.data.mtx_mkt.illc1850, 10, testCase);
end

function test_3(testCase)
    verify_lansvd(mat_simple1_1(20), 4, testCase);
end

function test_4(testCase)
    verify_lansvd(mat_simple1_1(50), 10, testCase);
end

function test_cryg10000(testCase)
    verify_lansvd(spx.data.mtx_mkt.cryg10000, 4, testCase);
    verify_lansvd(spx.data.mtx_mkt.cryg10000, 10, testCase);
end

function test_abb313_svt(testCase)
    verify_lansvd_svt(spx.data.mtx_mkt.abb313, 7.51, testCase);
end

function test_illc1850_svt(testCase)
    %TODO . The test should pass at much lower thresholds
    verify_lansvd_svt(spx.data.mtx_mkt.illc1850, 1.5, testCase);
end
