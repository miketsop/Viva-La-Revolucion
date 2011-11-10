function [x] = gsample(mu,Sigma,n)

%GSAMPLE  Function that produces n draws from a D-dimensional
%         Gaussian. (The dimension D is implicitly specified
%         by mu and Sigma)

D = length(mu);

[U,L] = schur(Sigma); % Sigma = U*L*U'

g = randn(n,D); % n draws, D dimensions N(0,1)

x = U*sqrt(L)*g'+repmat(mu,n,1)';
x = x';

end

