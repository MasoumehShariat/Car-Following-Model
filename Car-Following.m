clc 
clear all
%% Exercise: simulation of car following platoon
%introduceing all variables
%DT: Time interval duration 
%dt: Time step
%n : Number of vehicles to simulate (number n of equation of the system): n=10 cars
%sp :speed is equals to 20 m/s for all vehicles 
%Ac :acceleration is equal to zero for all vehicles
%T:time between 0 and 100
%d: distance ,first distance is 0

DT=50 ; dt=0.2; n=10; sp(1,1)=20; T=(0:0.2:100)'; d(1,1)=0;

%% First car
Ac(:,1)=zeros(1,length(T)); %acceleration of first
Ac(46:61)=-1; % break time
Ac(62:77)=1; %accelerates

for i=1:length(T)-1
    sp(i+1,1)=sp(i,1)+Ac(i,1)*dt;  %coloumn of spped
    d(i+1,1)=d(i,1)+sp(i,1)*dt;  %couloumn of distance  
end

% all cars except first 
for j=2:n
    i=-20;
    d(1,j)=d(1,j-1)+i;
    sp(1,j)=sp(1,j-1);
    Ac(1,j)=Ac(1,j-1);
end

%RT: Reaction times in 3 times
RT=5
for j=2:n
    for i=2:RT
        sp(i,j)=sp(i-1,j)+Ac(i-1,j)*dt;
        d(i,j)=d(i-1,j)+sp(i-1,j)*dt;
    end 
end

for j=2:n
    for i=RT+1:length(T)
        sp(i,j)=sp(i-1,j)+Ac(i-1,j)*dt;
        Ac(i,j)=dt*(sp(i-5,j-1)-sp(i-5,j));
        d(i,j)=d(i-1,j)+sp(i-1,j)*dt;
    end
end

spacing_time=zeros(length(T),n-1);
for i=1:length(T)
    for j=1:n-1
        spacing_time(i,j)=d(i,j)-d(i,j+1);
    end
end

%% Plot: speed diagram
plot(sp)
xlabel('Time (s)')
ylabel('Speed (m/s)')
title('Asymptotic Stability: speed diagram')
legend('car #1','car #2','car #3','car #4','car #5','car #6','car #7','car #8','car #9','car #10')
grid on

%% Plot: spacing diagram
plot(spacing_time)
xlabel('Time (s)')
ylabel('spacing (m)')
title('Asymptotic Stability: spacing diagram')
legend('car #2','car #3','car #4','car #5','car #6','car #7','car #8','car #9','car #10')
grid on

%% Plot: spacing diagram
plot(d)
xlabel('Time (s)')
ylabel('Space (m)')
title('Asymptotic Stability: space diagram')
legend('car #1','car #2','car #3','car #4','car #5','car #6','car #7','car #8','car #9','car #10')
grid on

