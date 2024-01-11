function []=FDB_RUN()
[population, dimension, maxIteration, lbArray, ubArray] = problem_terminate();
nP=population;          % Number of Population
MaxIt=maxIteration;      % Maximum number of iterations
dim=dimension;
% esetting;
lb=lbArray;
ub=ubArray;

Cost=zeros(nP,1);                % Record the Fitness of all Solutions
X=initialization(nP,dim,ub,lb);  % Initialize the set of random solutions   
Xnew2=zeros(1,dim);

Convergence_curve = zeros(1,MaxIt);

for i=1:nP
    Cost(i)=k_nn( X(i,:)' );
end

[Best_Cost,ind] = min(Cost);     % Determine the Best Solution
Best_X = X(ind,:);

Convergence_curve(1) = Best_Cost;

%% Main Loop of RUN 
it=1;%Number of iterations
while it<MaxIt
        
    f=20.*exp(-(12.*(it/MaxIt))); 
    Xavg = mean(X);               % Determine the Average of Solutions
    SF=2.*(0.5-rand(1,nP)).*f;    % Determine the Adaptive Factor 
  fdbindex = fitnessDistanceBalance( X, Cost );   
    for i=1:nP
            [~,ind_l] = min(Cost);
            lBest = X(ind_l,:);   
            
            [A,B,C]=RndX(nP,i);   % Determine Three Random Indices of Solutions
            [~,ind1] = min(Cost([A B C]));
            
            % Determine Delta X 
            gama = rand.*(X(i,:)-rand(1,dim).*(ub-lb)).*exp(-4*it/MaxIt);  
            Stp=rand(1,dim).*((Best_X-rand.*Xavg)+gama);
            DelX = 2*rand(1,dim).*(abs(Stp));
            
            % Determine Xb and Xw for using in Runge Kutta method
            if Cost(i)<Cost(ind1)                
                Xb = X(i,:);
                Xw = X(ind1,:);
            else
                Xb = X(ind1,:);
                Xw = X(i,:);
            end

            SM = RungeKutta(Xb,Xw,DelX);   % Search Mechanism (SM) of RUN based on Runge Kutta Method
                        
            L=rand(1,dim)<0.5;
            Xc = L.*X(i,:)+(1-L).*X(A,:);  
            Xm = L.*Best_X+(1-L).*lBest;   
              
            vec=[1,-1];
            flag = floor(2*rand(1,dim)+1);
            r=vec(flag);                   % An Interger number 
            
            g = 2*rand;
            mu = 0.5+.1*randn(1,dim);
            
            % Determine New Solution Based on Runge Kutta Method 
            if rand<0.5
                Xnew = (Xc+r.*SF(i).*g.*Xc) + SF(i).*(SM) + mu.*(Xm-Xc);
            else
                Xnew = (Xm+r.*SF(i).*g.*Xm) + SF(i).*(SM)+ mu.*(X(A,:)-X(B,:));
            end  
            
        % Check if solutions go outside the search space and bring them back
        FU=Xnew>ub;FL=Xnew<lb;Xnew=(Xnew.*(~(FU+FL)))+ub.*FU+lb.*FL; 
        CostNew=k_nn( Xnew' );
        it=it+1;
        
        if CostNew<Cost(i)
            X(i,:)=Xnew;
            Cost(i)=CostNew;
        end
%% Enhanced solution quality (ESQ)  (Eq. 19)      
        if rand<0.5
            EXP=exp(-5*rand*it/MaxIt);
            r = floor(Unifrnd(-1,2,1,1));

            u=2*rand(1,dim); 
            w=Unifrnd(0,2,1,dim).*EXP;           
            
            [A,B,C]=RndX(nP,i);
            if rand<0.9
                Xavg=(X(fdbindex,:)+X(fdbindex,:)+X(fdbindex,:))/3;
            else
            Xavg=(X(A,:)+X(B,:)+X(C,:))/3;               
            end
           
            beta=rand(1,dim);
            Xnew1 = beta.*(Best_X)+(1-beta).*(Xavg); 
            
            for j=1:dim
                if w(j)<1 
                    Xnew2(j) = Xnew1(j)+r*w(j)*abs((Xnew1(j)-Xavg(j))+randn); 
                else
                    Xnew2(j) = (Xnew1(j)-Xavg(j))+r*w(j)*abs((u(j).*Xnew1(j)-Xavg(j))+randn);  
                end
            end
            
            FU=Xnew2>ub;FL=Xnew2<lb;Xnew2=(Xnew2.*(~(FU+FL)))+ub.*FU+lb.*FL;
            CostNew=k_nn( Xnew2');
            it=it+1;
            
            if CostNew<Cost(i)
                X(i,:)=Xnew2;
                Cost(i)=CostNew;
            else
                if rand<w(randi(dim)) 
                    SM = RungeKutta(X(i,:),Xnew2,DelX);
                    Xnew = (Xnew2-rand.*Xnew2)+ SF(i)*(SM+(2*rand(1,dim).*Best_X-Xnew2));  
                    
                    FU=Xnew>ub;FL=Xnew<lb;Xnew=(Xnew.*(~(FU+FL)))+ub.*FU+lb.*FL;
                    CostNew=k_nn( Xnew');
                    it=it+1;
                    
                    
                    if CostNew<Cost(i)
                        X(i,:)=Xnew;
                        Cost(i)=CostNew;
                    end
                end
            end
        end
% End of ESQ         
%% Determine the Best Solution
        if Cost(i)<Best_Cost
            Best_X=X(i,:);
            Best_Cost=Cost(i);
        end

    end
% Save Best Solution at each iteration    
Convergence_curve(it) = Best_Cost;
%disp(['it : ' num2str(it) ', Best Cost = ' num2str(Convergence_curve(it) )]);

end
bestSolution=Best_X;
bestFitness=Best_Cost;
iteration=it;

fprintf('Best Fitness: %d\n', Best_Cost);
fprintf('Best Solution: %d\n', Best_X);
end


% A funtion to determine a random number 
%with uniform distribution (unifrnd function in Matlab) 
function z=Unifrnd(a,b,c,dim)
a2 = a/2;
b2 = b/2;
mu = a2+b2;
sig = b2-a2;
z = mu + sig .* (2*rand(c,dim)-1);
end

% A function to determine thress random indices of solutions
function [A,B,C]=RndX(nP,i)
Qi=randperm(nP);Qi(Qi==i)=[];
A=Qi(1);B=Qi(2);C=Qi(3);
end










