function out=NN(p,t)
%rede neuronal
%input:ncamadas,nporcamada,trainfcn,tranferfcn[ncamadas],divide[train
%validation test],path
%output:

net = feedforwardnet(10);
net.trainFcn='trainlm';
net.layers{1}.transferFcn='tansig';
net.layers{2}.transferFcn='logsig';
%net.layers{3}.transferFcn='logsig';
%net.layers{4}.transferFcn='tansig';
%ciclo para funções de layers
net.divideFcn='dividerand';
net.divideParam.trainRatio = 0.33;
net.divideParam.valRatio = 0.33;
net.divideParam.testRatio = 0.33;
%net.trainParam.goal=1e-8;
net.trainParam.min_grad=1e-9;
net.trainParam.max_fail = 1500;
%net.trainParam.lr=0.01;
%net.trainParam.epochs=1000;
% TREINAR
[net,tr] = train(net, p, t);
view(net);
disp(tr)

% SIMULAR
out = sim(net, p);

plotconfusion(t, out) % Matriz de confusao
plotperf(tr) % Grafico com o desempenho da rede nos 3 conjuntos


%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
result=0;
for i=1:size(out,2)               % Para cada classificacao  
  [~,b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [~,d] = max(t(:,i));       %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      result = result+1;
  end
end
result
size(out,2)
accuracy = result/size(out,2)*100;
fprintf('Precisao treino %f\n', accuracy)
% SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
TInput = p(:, tr.testInd);
TTargets = t(:, tr.testInd);
out = sim(net, TInput);
%Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
result=0;
for i=1:size(tr.testInd,2)        % Para cada classificacao  
  [~,b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [~,d] = max(TTargets(:,i));     %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      result = result+1;
  end
end
accuracy = result/size(tr.testInd,2)*100;

fprintf('Precisao teste %f\n', accuracy)


% Test the Network
outputs = net(p);
errors = gsubtract(t,outputs);
performance = perform(net,t,outputs)
% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,outputs)
valPerformance = perform(net,valTargets,outputs)
testPerformance = perform(net,testTargets,outputs)

end
function simula()
    
end
