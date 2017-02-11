function [solution LINcoefficients_progression e converged MSE]=LMS_CNAP_solver_itterator(current,desired,channel_noise,Mu,Order,Tolerance,Max_Iterations,PaCoefficients,initial_coefficients,adaptive,adapt_rate)

if isscalar(Mu)
    My_Mu=Mu;
else
    [My_Mu Muopt_Error]=LMS_muopt(current,[],[]);
end

if isscalar(Order)
    Ncoefficients=Order;
else    
    if isvector(Order)
        Ncoefficients=length(Order);
    else
        Ncoefficients=39;
    end
end

if isscalar(Tolerance)
    Tolerance=Tolerance;
else
    Tolerance=1e-5;
end

if isscalar(Max_Iterations)
    Max_Iterations=Max_Iterations;
else
    Max_Iterations=300;
end

if isvector(initial_coefficients)
    LINCoefficients=initial_coefficients;
else
    LINCoefficients=zeros(1,Ncoefficients);
end

cont=0; iter=1; e=[]; LINcoefficients_progression=[];
wbar=waitbar(0,'progress'); stable_mu_opt=1; esig_past=1; esig=10;

% % % wbar=waitbar(0,'progress','CreateCancelBtn',...
% % %     'cont=1;,converged=1;');

if adaptive==1
	while (cont==0) & (iter < Max_Iterations)
		
		if (mod(iter,adapt_rate)==0)
			esig_past=mean(abs(esig));
		end
		
		if (mod(iter,adapt_rate)==0) & (stable_mu_opt) 
		%%& (esig_past*1.2) < (mean(abs(esig)))
			[My_Mu Muopt_Error]=LMS_muopt(current,[],[]);
			esig_past=mean(abs(esig));
		elseif (My_Mu > 8) & (stable_mu_opt)
			stable_mu_opt=0;
			My_Mu=My_Mu/2;
			esig_past=mean(abs(esig));
		end
		
		if (mod(iter,adapt_rate/2)==0) & (My_Mu < 5)
			if (esig_past*1.1) < (mean(abs(esig)))
				My_Mu=My_Mu/1.2;
			elseif (esig_past - mean(abs(esig))) < esig_past*0.8
				My_Mu=My_Mu*1.2;
			end
			esig_past=mean(abs(esig));
		elseif (My_Mu > 5)
			My_Mu=My_Mu/2;
		end
		
		if iter > 1
            [bLMS PAcoefficients_prog esig]=LMS_CNAP_solver(My_Mu,Ncoefficients,PaCoefficients,bLMS,current,desired,channel_noise);
		else
			[bLMS PAcoefficients_prog esig]=LMS_CNAP_solver(My_Mu,Ncoefficients,PaCoefficients,LINCoefficients,current,desired,channel_noise);
		end
		iter=iter+1;
		
		if (Max_Iterations*length(current)) > 100000
	%         e=esig.';
	%         PAcoefficients_progression=PAcoefficients_prog;
		elseif (Max_Iterations*length(current)) <= 100000
			e=[e esig.'];
			LINcoefficients_progression=[LINcoefficients_progression;PAcoefficients_prog];
		end
		
		if MSE <= Tolerance
			cont=1; converged=1;
        else
            converged=0;
        end
		MSE=10*log10(abs((1/length(esig))*sum(power(esig,2))));
		waitbar(iter/Max_Iterations,wbar,sprintf('current Mean error value %5.9f current mu %5.5f',MSE,My_Mu));
	end
elseif adaptive==0
	while (cont==0) & (iter < Max_Iterations)
		
		if iter > 1
			[bLMS PAcoefficients_prog esig]=LMS_CNAP_solver(My_Mu,Ncoefficients,PaCoefficients,bLMS,current,desired,channel_noise);
		else
			[bLMS PAcoefficients_prog esig]=LMS_CNAP_solver(My_Mu,Ncoefficients,PaCoefficients,LINCoefficients,current,desired,channel_noise);
		end
		iter=iter+1;
		
		if (Max_Iterations*length(current)) > 100000
	%         e=esig.';
	%         PAcoefficients_progression=PAcoefficients_prog;
		elseif (Max_Iterations*length(current)) <= 100000
			e=[e esig.'];
			LINcoefficients_progression=[LINcoefficients_progression;PAcoefficients_prog];
        end
		MSE=10*log10(abs((1/length(esig))*sum(power(esig,2))));
		waitbar(iter/Max_Iterations,wbar,sprintf('current Mean error value %5.9f current mu %5.5f',MSE,My_Mu));        
		if MSE <= Tolerance
			cont=1; converged=1;
        else
            converged=0;
        end
	end
end
e=esig;
close(wbar);
solution=bLMS;