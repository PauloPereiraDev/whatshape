
outputs=net(p);
%VISUALIZAR DESEMPENHO

save('Saves/nn001','net');

% extracting the test and predicted data. 
testX = p(:, tr.testInd);
testT = t(:, tr.testInd);
testY = net(testX);
testI = vec2ind(testY);
plotconfusion(testT, testY)
% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
%valTargets = t  .* tr.valMask{1};
testTargets = t  .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs);
%valPerformance   = perform(net,valTargets,outputs)
testPerformance  = perform(net,testTargets,outputs);
fprintf('Precisao de treino %f\n', trainPerformance*100);
fprintf('Precisao de teste %f\n', testPerformance*100);





 flag=4;
        o=1;
        n=1;
 while(flag>0)
            try
                p(n,:)=pst(o,:);
                t(n,:)=tst(o,:);
                n=n+1;
            catch
                flag=flag-1;
                %catch error maybe
            end
            try
                p(n,:)=psq(o,:);
                t(n,:)=tsq(o,:);
                n=n+1;
            catch
                flag=flag-1;
                %catch error maybe
            end
            try
                p(n,:)=ptr(o,:);
                t(n,:)=ttr(o,:);
                n=n+1;
            catch
                flag=flag-1;
                %catch error maybe
            end
            try
                p(n,:)=pci(o,:);
                t(n,:)=tci(o,:);
                n=n+1;
            catch
                flag=flag-1;
                %catch error maybe
            end
            o=o+1;
            if(flag>0)
                flag=4;
            end
 end
        
 
 
 
 
%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
r=0;
for i=1:size(out,2)               % Para cada classificacao  
  [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(t(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100;
fprintf('Precisao total %f\n', accuracy)


% SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
TInput = p(:, tr.testInd);
TTargets = t(:, tr.testInd);

out = sim(net, TInput);

%Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
r=0;
for i=1:size(tr.testInd,2)               % Para cada classificacao  
  [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end
accuracy = r/size(tr.testInd,2)*100;
fprintf('Precisao teste %f\n', accuracy)