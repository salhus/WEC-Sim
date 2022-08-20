close all

figure()

h(1) = subplot(5,1,1);
plot(SwellandChop(:,1),SwellandChop(:,2),'k')
h(1).FontSize = 15;
h(1).YLabel.String = 'Combined Wave (m)';
h(1).XLabel.String = 'Time (s)';

h(2) = subplot(5,1,2);
plot(w1(:,1),w1(:,2),'k')
h(2).FontSize = 15;
h(2).YLabel.String = 'Wave A (m)';
h(2).XLabel.String = 'Time (s)';

h(3) = subplot(5,1,3);
plot(w2(:,1),w2(:,2),'k')
h(3).FontSize = 15;
h(3).YLabel.String = 'Wave B (m)';
h(3).XLabel.String = 'Time (s)';

h(4) = subplot(5,1,4);
plot(w3(:,1),w3(:,2),'k')
h(4).FontSize = 15;
h(4).YLabel.String = 'Wave C (m)';
h(4).XLabel.String = 'Time (s)';

h(5) = subplot(5,1,5);
plot(w4(:,1),w4(:,2),'k')
h(5).FontSize = 15;
h(5).YLabel.String = 'Wave D (m)';
h(5).XLabel.String = 'Time (s)';



