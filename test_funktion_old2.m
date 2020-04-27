function test_funktion(model,rk3,rk4,rk34,idx)

val=dlmread('exercise.autogen.csv');
test_data=[];

state=4;
ind_t=1;
ind_x=ind_t+1:ind_t+state;
ind_dx=ind_x(end)+1:ind_x(end)+state;

ind_h=ind_dx(end)+1;
ind_xrk3=ind_h+1:ind_h+state;
ind_xrk4=ind_xrk3(end)+1:ind_xrk3(end)+state;
ind_y=ind_xrk4(end)+1;

t=val(:,ind_t);
x=val(:,ind_x);
dx=val(:,ind_dx);
y=val(:,ind_y);

h=val(:,ind_h);
xrk3=val(:,ind_xrk3);
xrk4=val(:,ind_xrk4);

if(strcmp(idx,'model'))
    for i =1:length(t)
        t1=(model(t(i),x(i,:)')-dx(i,:)');
        t1(abs(dx(i,:)')>1)=t1(abs(dx(i,:)')>1)./dx(i,abs(dx(i,:)')>1)';
        test_data=[test_data,t1];
    end
elseif(strcmp(idx,'rk3'))
    for i =1:length(t)
        t1=(rk3(@(t,x_) model(t,x_),h(i),x(i,:)',t(i))-xrk3(i,:)');
        t1(abs(xrk3(i,:)')>1)=t1(abs(xrk3(i,:)')>1)./xrk3(i,abs(xrk3(i,:)')>1)';
        test_data=[test_data,t1];
    end
elseif(strcmp(idx,'rk4'))
    for i =1:length(t)
        t1=(rk4(@(t,x_) model(t,x_),h(i),x(i,:)',t(i))-xrk4(i,:)');
        t1(abs(xrk4(i,:)')>1)=t1(abs(xrk4(i,:)')>1)./xrk4(i,abs(xrk4(i,:)')>1)';
        test_data=[test_data,t1];
    end
elseif(strcmp(idx,'rk34'))
    test_data=(interp1(rk34.t,rk34.y,t)-y);
    test_data(abs(y)>1)=test_data(abs(y)>1)./y(abs(y)>1);
else
    error('falsches flag');
end


if any(abs(test_data(:))>1e-7)
    error(['ERROR:  ',idx]);
else
    disp('##########');
    disp([idx,':  OK']);
    disp('##########');
end
end
