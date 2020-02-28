%% STATE VISUALISATION

suptitle('System response');
subplot(221);
plot(t, y(:, 1));
hold on;
plot(t_lqr, y_lqr(:, 1));
grid on;
grid minor;
xlabel('t [s]');
ylabel('Cart position [m]');

subplot(222);
plot(t, y(:, 2));
hold on;
plot(t_lqr, y_lqr(:, 2));
grid on;
grid minor;
xlabel('t [s]');
ylabel('Cart speed [m/s]');

subplot(223);
plot(t, y(:, 3));
hold on;
plot(t_lqr, y_lqr(:, 3));
grid on;
grid minor;
xlabel('t [s]');
ylabel('Pole angle [rad]');

subplot(224);
plot(t, y(:, 4));
hold on;
plot(t_lqr, y_lqr(:, 4));
grid on;
grid minor;
xlabel('t [s]');
ylabel('Pole angular velocity [rad/s]');