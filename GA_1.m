%% 自己编写的代码

%问题： x1 属于(-2,5)  x2属于 (-3,4)  求 x1^2+2*x1*x2+x2^2+3 的最大值

clear;clc
%初始参数设置
pop=50; %种群规模
n=10;   %单变量编码长度/精度
M=200;   %迭代次数
length=2*n; %两个变量
crossover_prob=0.5; %交叉的概率
mutation_prob=0.2;  %变异的概率
initial_pop=round(rand(pop,length)); %初始种群

for g =1:M

%编码
x1=zeros(pop,1);   x2=zeros(pop,1);   y=zeros(pop,1);  %储存每代的情况

for i=1:pop   %十进制转二进制
    for j=1:n
         x1(i)=x1(i)+initial_pop(i,j)*2^(j-1);
         x2(i)=x2(i)+initial_pop(i,j+10)*2^(j-1);
    end       
end

%1-解码计算适应度
for i=1:pop   %转换到给定范围
    x1(i)=-2+(x1(i)*(5-(-2)))/(2^n-1);
    x2(i)=-3+(x2(i)*(4-(-3)))/(2^n-1);   
    y(i)=x1(i)^2+2*x1(i)*x2(i)+x2(i)^2+3;     
end

[a,b]=max(y);  % a记录最大值 b记录所在行

%2-选择
choosen_pop=zeros(pop,length);

fit1=(y-min(y))/(max(y)-min(y));
fit2=fit1/sum(fit1);
fit3=cumsum(fit2);  %求累计概率

compare=sort(rand(pop,1));  %轮盘赌
i=1;j=1;

while i<=pop                                                               
    if compare(i)<fit3(j)
        choosen_pop(i,:)=initial_pop(j,:);
        i=i+1;
    else
        j=j+1;
    end
end

%3-交叉
crossover_pop=choosen_pop;

for i=1:2:pop-1  %相邻上下两个配对
    if rand<crossover_prob
        c=randi([1 20]); %单点交叉
        crossover_pop(i,:)=[crossover_pop(i,1:c-1),crossover_pop(i+1,c),crossover_pop(i,c+1:end)];
        crossover_pop(i+1,:)=[crossover_pop(i+1,1:c-1),crossover_pop(i,c),crossover_pop(i+1,c+1:end)];
    end
end

%变异
mutation_pop=crossover_pop;

for i=1:pop
    if rand<mutation_prob
        m=randi([1 20]); %单点变异
        mutation_pop(i,m)=1-mutation_pop(i,m);
    end
end
    
%产生下一代
mutation_pop(end,:)=initial_pop(b,:); %保留最好的一代

best(g,1)=x1(b);
best(g,2)=x2(b);
best(g,3)=y(b);

initial_pop=mutation_pop;
 
end

plot(1:M,best(:,3))
%% 教程
clear;
clc;

population_size=50; %初始种群数量
n=10;   %单变量编码长度/精度
length=2*n;          %基因编码长度 10+10
crossover_pob=0.5;  %交叉概率
variation_pob=0.2;  %变异概率
initial_population=round(rand(population_size,length));  %生成初始种群

for m =1:100
    
x=zeros(population_size,2); %储存种群编码值
y=zeros(population_size,1); 

for i = 1:population_size  %转换到规定区间
   
    for j = 1:10
        x(i,1)=initial_population(i,j)*2^(j-1)+x(i,1);
    end
    
    for j = 11:20
        x(i,2)=initial_population(i,j)*2^(j-11)+x(i,2);
    end
    
end

for i = 1:population_size   
    x(i,1)=-2+(5-(-2))*x(i,1)/(2^n-1);  %转换到规定区间
    x(i,2)=-3+(4-(-3))*x(i,2)/(2^n-1);
end


for i = 1:population_size  %因变量取值
    y(i)=x(i,1)^2+2*x(i,1)*x(i,2)+x(i,2)^2+3;
end
    
[a,b]=max(y);  %最优秀的种群  a是最优值 b是位置
    
fit1=(y-min(y))/(max(y)-min(y)); %计算每个种群适应度，归一化-为fit3服务
fit2=fit1/sum(fit1); %计算每个种群适应度在总适应度中的占比-为fit3服务
fit3=cumsum(fit2);  % 每个位置都是前面的累加（轮盘赌）

%基因选择
choose=sort(rand(population_size,1));
k=1;
i=1;
while k<=population_size
    if choose(k)<fit3(i)
        choosen_population(k,:)=initial_population(i,:);
        k=k+1;
    else
        i=i+1;
    end
end
        
%交叉
crossover_population=choosen_population;
for i = 1:2:population_size-1 
    if rand<crossover_pob
        crossover_length=round(rand*(length-1))+1;
        crossover_population(i,:)=[choosen_population(i,1:crossover_length),choosen_population(i+1,1+crossover_length:end)];
        crossover_population(i+1,:)=[choosen_population(i+1,1:crossover_length),choosen_population(i,1+crossover_length:end)];
    end
end

%变异
variation_population=crossover_population;
for i = 1:population_size
    if rand<variation_pob
        variation_location=round(rand*(length-1))+1;
        variation_population(i,variation_location)=1-variation_population(i,variation_location);
    end
end

variation_population(end,:)=initial_population(b,:); %保留该次迭代中最优种群

initial_population=variation_population; %变为下一代初始种群

best(m,1)=y(b);
best(m,2)=x(b,1);
best(m,3)=x(b,2);

end
    
plot(1:size(best,1),best(:,1))    