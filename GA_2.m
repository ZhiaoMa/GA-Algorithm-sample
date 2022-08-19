%% 自己编写的代码~十进制

%问题： 20个城市的TSP问题
clear all;clc

citys=[
 1 12.8 8.5
 2 18.4 3.4
 3 15.4 16.6
 4 18.9 15.2
 5 15.5 11.6
 6 3.9 10.6
 7 10.6 7.6
 8 8.6 8.4
 9 12.5 2.1
 10 13.8 5.2
 11 6.7 16.9
 12 14.8 2.6
 13 1.8 8.7
 14 17.1 11
 15 7.4 1
 16 0.2 2.8
 17 11.9 19.8
 18 13.2 15.1
 19 6.4 5.6
 20 9.6 14.8];  %城市位置数据

%初始参数设置
pop=100; %种群规模
n=20;   %编码长度
M=500;   %迭代次数
crossover_prob=0.6; %交叉的概率
mutation_prob=0.2;  %变异的概率
initial_pop=zeros(pop,n);
for i =1:pop
    initial_pop(i,:)=randperm(n); %初始种群
end

for g =1:M

%编码排序
route=zeros(pop,n+1);    
distance=zeros(pop,1);  %储存每代的情况
fitness=zeros(pop,1);

for i=1:pop   
    route(i,:)=[initial_pop(i,:),initial_pop(i,1)]; %回到出发点
    
    for j =1:n  %计算距离
        distance(i)=distance(i)+sqrt((citys(route(i,j),2)-citys(route(i,j+1),2))^2+(citys(route(i,j),3)-citys(route(i,j+1),3))^2);
    end
    
    fitness(i)=1/distance(i); %距离倒数求最大=距离求最小
end

[a,b]=max(fitness);  % a记录最大值 b记录所在行
[c,d]=min(distance);  % c记录最小距离 d记录所在行 b=d

%2-选择
choosen_pop=zeros(pop,n);

fit1=(fitness-min(fitness))/(max(fitness)-min(fitness));
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
        temp=crossover_pop(i,8:12);  %交叉位置固定
        
        for k=1:length(temp)
            f(k)=find(crossover_pop(i+1,:)==temp(k));
        end
        
        for p=1:length(temp)
            crossover_pop(i,p+7)=crossover_pop(i+1,f(p));
            crossover_pop(i+1,f(p))=temp(p);
        end
        
    end
end

%变异
mutation_pop=crossover_pop;

for i=1:pop
    if rand<mutation_prob
        r=randperm(20);
        r1=r(1);
        r2=r(2);
        row=mutation_pop(i,:);
        m1=find(row==r1);
        m2=find(row==r2);
        mutation_pop(i,m1)=r2;
        mutation_pop(i,m2)=r1;
    end
end
    
%产生下一代
mutation_pop(end,:)=initial_pop(b,:); %保留最好的一代

best_distance(g)=distance(b);
best_route=route(b,:);
initial_pop=mutation_pop;
 
drawnow
scatter(citys(:,2),citys(:,3))
hold on
plot(citys(best_route(1:n+1),2),citys(best_route(1:n+1),3),'b')  %行程图
title(['遗传算法第 ' num2str(g) '代']);
hold off

end

plot(1:M,best_distance);  %适应度函数迭代过程
%% 自己编写的代码~二进制

%问题： 20个城市的TSP问题
clear all;clc

citys=[
 1 12.8 8.5
 2 18.4 3.4
 3 15.4 16.6
 4 18.9 15.2
 5 15.5 11.6
 6 3.9 10.6
 7 10.6 7.6
 8 8.6 8.4
 9 12.5 2.1
 10 13.8 5.2
 11 6.7 16.9
 12 14.8 2.6
 13 1.8 8.7
 14 17.1 11
 15 7.4 1
 16 0.2 2.8
 17 11.9 19.8
 18 13.2 15.1
 19 6.4 5.6
 20 9.6 14.8];  %城市位置数据

%初始参数设置
pop=100; %种群规模
n=20;   %编码长度
M=500;   %迭代次数
crossover_prob=0.6; %交叉的概率
mutation_prob=0.2;  %变异的概率
initial_pop=rand(pop,n); %初始种群

for g =1:M

%编码排序
route=zeros(pop,n+1);    
distance=zeros(pop,1);  %储存每代的情况
fitness=zeros(pop,1);

for i=1:pop   
    [sort1,sort2]=sort(initial_pop(i,:));
    route(i,:)=[sort2,sort2(1)];
    
    for j =1:n  %计算距离
        distance(i)=distance(i)+sqrt((citys(route(i,j),2)-citys(route(i,j+1),2))^2+(citys(route(i,j),3)-citys(route(i,j+1),3))^2);
    end
    
    fitness(i)=1/distance(i); %距离倒数求最大=距离求最小
end

[a,b]=max(fitness);  % a记录最大值 b记录所在行
[c,d]=min(distance);  % c记录最小距离 d记录所在行 b=d

%2-选择
choosen_pop=zeros(pop,n);

fit1=(fitness-min(fitness))/(max(fitness)-min(fitness));
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

best_distance(g)=distance(b);
best_route=route(b,:);
initial_pop=mutation_pop;
 
drawnow
scatter(citys(:,2),citys(:,3))
hold on
plot(citys(best_route(1:n+1),2),citys(best_route(1:n+1),3),'b')  %行程图
title(['遗传算法第 ' num2str(g) '代']);
hold off
end


plot(1:M,best_distance);  %适应度函数迭代过程


%% B站代码
clear;clc;
citys1=[
 1 12.8 8.5
 2 18.4 3.4
 3 15.4 16.6
 4 18.9 15.2
 5 15.5 11.6
 6 3.9 10.6
 7 10.6 7.6
 8 8.6 8.4
 9 12.5 2.1
 10 13.8 5.2
 11 6.7 16.9
 12 14.8 2.6
 13 1.8 8.7
 14 17.1 11
 15 7.4 1
 16 0.2 2.8
 17 11.9 19.8
 18 13.2 15.1
 19 6.4 5.6
 20 9.6 14.8]; 
population_size=50;%初始种群数量
length=20;%种群基因编码长度
crossover_probablity=0.8;%交叉概率
variation_probablity=0.3;%变异概率

initial_population=rand(population_size,length);

for l=1:500
distance=zeros(1,population_size);
distance_min(l)=inf;
a=0;
for j=1:population_size%对种群进行遍历
[sort1,sort2]=sort(initial_population(j,:));%对一行种群中的元素进行由小到大的排列
route=[sort2,sort2(1)];%生成旅行路线
for k=1:length
distance(j)=sqrt((citys1(route(k),2)-citys1(route(k+1),2))^2+(citys1(route(k),3)-citys1(route(k+1),3))^2)+distance(j);
%对每段距离进行一个累加
end
if distance(j)<distance_min(l)
distance_min(l)=distance(j);
a=j;
end
distance_reciprocial(j)=1/distance(j);%把目标转化为求距离倒数的最大值
end

fit1=(distance_reciprocial-min(distance_reciprocial))/(max(distance_reciprocial)-min(distance_reciprocial));
fit2=fit1/sum(fit1);
fit3=cumsum(fit2);

% 基因选择
choose=sort(rand(population_size,1));
k=1;
i=1;
while k<=population_size
if choose(k)<fit3(i)
choosen_population(k,:)=initial_population(i,:);
k=k+1;
else i=i+1;
end
end

% 基因交叉
for i=1:2:population_size-1
if rand<crossover_probablity
crossover_length=round(rand*(length-1))+1;
crossover_population(i,:)=[choosen_population(i,1:crossover_length),choosen_population(i+1,crossover_length+1:end)];
crossover_population(i+1,:)=[choosen_population(i+1,1:crossover_length),choosen_population(i,crossover_length+1:end)];
end
end

% 基因变异
variation_population=crossover_population;
for i=1:population_size
if rand<variation_probablity
variation_location=round(rand*(length-1))+1;
variation_population(i,variation_location)=1-variation_population(i,variation_location);
end
end

variation_population(end,:)=initial_population(a,:);
initial_population=variation_population;


end

[sort1,sort2]=sort(initial_population(end,:));
route=[sort2,sort2(1)];
set(gcf,'position',[300,100,530,400])
plot(distance_min)
figure
set(gcf,'position',[900,100,530,400])
scatter(citys1(:,2),citys1(:,3))
hold on
plot(citys1(route(1:21),2),citys1(route(1:21),3),'b')
hold off 