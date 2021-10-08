function plotjdk(data)
 figure
 hold on
 l=length(data);
 plot([1:l;1:l],data(:,[1,4])','b','LineWidth',4)
 plot([1:l;1:l],data(:,[2,3])','m')