function MAP=map_mmpp2(MEAN,SCV,SKEW,ACF1)
% MAP=map_mmpp2(MEAN,SCV,SKEW,ACF1) - Fit a MMPP(2) as a MAP
%
%  Input:
%  MEAN: mean inter-arrival time of the process
%  SCV: squared coefficient of variation of inter-arrival times
%  SKEW: skewness of inter-arrival times (-1 => automatic minimization,
%  applies only to SCV>1)
%  ACF1: lag-1 autocorrelation coefficient (-1 => maximum feasible
%  autocorrelation)
%
%  Output:
%  MAP: a MAP in the form of {D0,D1}
%
%  Examples:
%  - MAP=map_mmpp2(1,2,-1,0.2) MMPP(2) process with minimal skewness
%  - MAP=map_mmpp2(1,2,-1,-1) MMPP(2) process with minimal skewness and
%  maximal autocorrelation
%

E1=MEAN;
E2=(1+SCV)*E1^2;
E3=-(2*E1^3-3*E1*E2-SKEW*(E2-E1^2)^(3/2));
if ACF1==-1
    G2=1-10*10^(-map_feastol); % autocorrelation decay rate
else
    G2=ACF1/(1-1/SCV)/0.5; % autocorrelation decay rate
end
if SKEW==-1 && SCV>1 % determine MAP with nearly minimum third moment
    E3=(3/2+0.001)*E2^2/E1;
end
SCV=(E2-E1^2)/E1^2;
if G2<1e-6
    mu00=2*(6*E1^3*SCV-E3)/E1/(6*E1^3*SCV+3*E1^3*SCV^2+3*E1^3-2*E3);
    mu11=0;
    q01= 9*E1^5*(SCV-1)*(SCV^2-2*SCV+1)/(6*E1^3*SCV-E3)/(6*E1^3*SCV+3*E1^3*SCV^2+3*E1^3-2*E3);
    q10=-3*(SCV-1)*E1^2/(6*E1^3*SCV-E3);
else
    mu00=G2*(-4*E3*G2+4*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3*G2-18*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2-18*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV^2-12*E1^3*G2^2-12*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2*SCV+12*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV+12*E1^3*G2*SCV^2-9*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV+3*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)+12*E1^3*G2^2*SCV+9*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^2+12*E1^3*G2+12*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2-3*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^3)/(12*E1^3*G2^3*SCV+3*E1^3*SCV^3*G2-12*E1^3*G2^3+18*E1^3*G2^2*SCV^2-3*E1^3*G2+27*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV^2-9*E1^3*G2*SCV^2+18*E1^3*G2^2-12*E1^3*G2^2*SCV+9*E1^3*G2*SCV-12*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^3*SCV-9*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^3*G2-24*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2*SCV^2-(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3*SCV^2+4*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3*G2^2+12*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^3-(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3+2*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3*SCV+9*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2+24*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2*SCV-27*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV+6*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV-12*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^2-24*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2+6*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^3-4*E3*G2^2)/E1;
    mu11=(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/E1/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3);
    q01=-3*E1^2*(-6*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV+12*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV-6*G2*SCV*E1^2-3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2+(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/E1/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3+3*E1^2*G2+6*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^2-9*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^2*G2+3*E1^2*G2*SCV^2-E3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/E1/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV-6*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2*SCV+6*E1^2*G2^2*SCV+3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2-G2*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/E1/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3-3*E1^2*G2^2+3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^2*G2^2-3*E1^2*SCV^2*G2^2+G2*SCV*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/E1/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3)/(-45*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV^2+18*G2^2*E1^5*SCV+18*E1^5*G2^3-27*E1^5*G2^2*SCV^2+6*E1^2*G2^2*E3-27*E1^5*G2^2-18*E1^5*G2^3*SCV-18*E1^5*G2*SCV+18*E1^5*G2*SCV^2+3*E1^2*G2*E3-3*E1^2*G2*E3*SCV+(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/E1/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3^2+3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV*E3-36*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2*SCV+36*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2+36*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^2+45*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV-12*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV*E3-3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*E3+9*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV^3+36*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2*SCV^2-6*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^2/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^2*E3+18*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^3*SCV-18*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2^3-9*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))*E1^5/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2);
    q10=3*(-3*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^3-3*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV^2+6*E1^3*SCV^2+3*E1^3*G2*SCV^2+3*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV^2+6*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2*SCV-E3*SCV-6*E1^3*SCV+(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3*SCV-6*E1^3*G2*SCV-3*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*SCV-(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*E3+3*E1^3*G2-3*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)*G2+3*E1^3*(-3*E1^3*G2+3*E1^3*G2*SCV-6*E1^3*SCV+E3+(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2)^(1/2))/(-3*E1^3*SCV^2-6*E1^3*SCV-3*E1^3+2*E3)+E3)*E1^2*(-1+G2)/(E3^2-12*E1^3*SCV*E3+6*E1^3*G2*E3-6*G2*SCV*E1^3*E3+18*G2*SCV^3*E1^6-18*E1^6*G2*SCV^2+9*E1^6*G2^2+36*E1^6*SCV^2+18*E1^6*G2*SCV-18*E1^6*SCV*G2^2+9*E1^6*SCV^2*G2^2-18*E1^6*G2);
end
D0=[ -mu00-q01,       q01;
    q10, -mu11-q10];
D1=[ mu00,   0;
    0, mu11];
MAP={D0,D1};
end