

lmsresponse = load("LMSResponse.mat");
ciematch = load("CIEMatch.mat");
Cie2rgb = load("CIE2RGB.mat");


%Question 2 a (i)
mapped = Cie2rgb.T * ciematch.CIEMatch

figure
title("RGB color matching function");
hold on

plot([360:5:730], mapped(1,:), 'r');
plot([360:5:730], mapped(2,:),'g');
plot([360:5:730], mapped(3,:),'b');
hold off



%question 2 a (iii)
figure 
title("CIE color matching function")
xlabel("wavelength")
hold on 

for ii = 1:3
    plot([360:5:730], ciematch.CIEMatch(ii, :));
end


%question 2 a (ii)

reversed = pinv(mapped);

figure 
title("Primary light spectra associated with RGB")


hold on 

plot([360:5:730], reversed(:,1), 'r');
plot([360:5:730], reversed(:,2),'g');
plot([360:5:730], reversed(:,3),'b');



%question 2 a (iv)

reversed = pinv(ciematch.CIEMatch);

figure 
title("Primary light spectra associated with CIE")
xlabel("wavelength")
hold on 

for ii = 1: 3
    plot([360:5:730], reversed(:,ii));
end


%Question 2 b

lms = lmsresponse.LMSResponse;
lms(isnan(lms)) = 0;
lmsinverse = pinv(lms);
title("LMS primaries")
xlabel("wavelength")
figure
hold on 

plot([360:5:730], lmsinverse(:,1), 'r');
plot([360:5:730], lmsinverse(:,2),'g');
plot([360:5:730], lmsinverse(:,3),'b');
hold off

