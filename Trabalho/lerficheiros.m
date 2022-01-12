function [p,t]=lerficheiros(path)
%valores predefinidos de pixels
nrows=30;
ncols=30;


tstar=[0;0;0;1];
ttriangle=[0;0;1;0];
tsquare=[0;1;0;0];
tcircle=[1;0;0;0];

if(strcmp(path,'Formas_1/'))
    %lê imagens na pasta
    Files=dir([path '*.png']);
    %inicia matriz de inputs a zero
    p=zeros(nrows*ncols,length(Files));
    %inicia matriz de targets a zero
    t=zeros(4,length(Files));
    for k=1:length(Files)
        temp = imresize(imbinarize(imread(Files(k).name)),[nrows ncols]);
        imshow(temp)
        n=1;
        for i=1:nrows
            for j=1:ncols
                p(n,k)=temp(i,j);  
                n=n+1;
            end
        end
        switch(Files(k).name)
            case '0_triangle.png'
                t(:,k)=ttriangle;
            case '0_star.png'
                t(:,k)=tstar;
            case '0_square.png'
                t(:,k)=tsquare;
            case '0_circle.png'
                t(:,k)=tcircle;
        end
    end
else
    if(strcmp(path,'Formas_2/')||strcmp(path,'Formas_3/'))
        %leitura da pasta formas 2 e 3
        stars=dir([path 'star/*.png']);
       
        %inicia matriz de inputs a zero
        p=zeros(nrows*ncols,length(stars));
        %inicia matriz de targets a zero
        t=zeros(4,length(stars));
        for k=1:length(stars)
            temp = imresize(imbinarize(imread(stars(k).name)),[nrows ncols]);
            n=1;
            for i=1:nrows
                for j=1:ncols
                    p(n,k)=temp(i,j);
                    n=n+1;
                end
            end
            t(:,k)=tstar;
        end
        triangle=dir([path 'triangle/*.png']);
        %inicia matriz de inputs a zero
        ptr=zeros(nrows*ncols,length(triangle));
        %inicia matriz de targets a zero
        ttr=zeros(4,length(triangle));
        for k=1:length(triangle)
            temp = imresize(imbinarize(imread(triangle(k).name)),[nrows ncols]);
            n=1;
            for i=1:nrows
                for j=1:ncols
                    ptr(n,k)=temp(i,j);
                    n=n+1;
                end
            end
            ttr(:,k)=ttriangle;
        end
        p=[p ptr];
        t=[t ttr];
        square=dir([path 'square/*.png']);     
        %inicia matriz de inputs a zero
        psq=zeros(nrows*ncols,length(square));
        %inicia matriz de targets a zero
        tsq=zeros(4,length(square));
        for k=1:length(square)
            temp = imresize(imbinarize(imread(square(k).name)),[nrows ncols]);
            n=1;
            for i=1:nrows
                for j=1:ncols
                    psq(n,k)=temp(i,j);
                    n=n+1;
                end
            end
            tsq(:,k)=tsquare;
        end
        p=[p psq];
        t=[t tsq];
        circle=dir([path 'circle/*.png']);
        %inicia matriz de inputs a zero
        pci=zeros(nrows*ncols,length(circle));
        %inicia matriz de targets a zero
        tci=zeros(4,length(circle));
        
        for k=1:length(circle)
            temp = imresize(imbinarize(imread(circle(k).name)),[nrows ncols]);
            n=1;
            for i=1:nrows
                for j=1:ncols
                    pci(n,k)=temp(i,j);
                    n=n+1;
                end
            end
            tci(:,k)=tcircle;
        end
        p=[p pci];
        t=[t tci];
    else
        %codigo para teste desenhado
        temp = imbinarize(imread(path));
        %inicia matriz de inputs a zero
        p=zeros(nrows*ncols);
        %inicia matriz de targets a zero
        t=zeros(4);
        n=1;
        for i=1:nrows
            for j=1:ncols
                p(n)=temp(i,j);  
                n=n+1;
            end
        end
    end
end
    