
close all

%% 

if exist('u','var') == 0
    calibration
    import_and_process_data
end

%%

u = sensed_rates_processed;
y = sensed_accelerations_processed;
T = time_steps;
N = size(u,1);

%% data settings

n = 2;  % 2 angles

%% standard deviations

std_w = zeros(3+n-2,1);
std_w(1:3) = std_rates; % propagated gyro noise
% std_w(4:6) = [1e0; 1e0; 1e0];

std_v = zeros(3,1);
std_v(1:3) = std_accelerations; % accelerometer noise

%% noise covariance

R = diag(std_v);

%% ekf

x_corr = zeros(n,1);
P_corr = eye(n);

x_est = zeros(N,n);
x_est(1,:) = x_corr';

for k=2:N
    x_pred = StateEquation(x_corr, u(k-1,:), T(k-1));
    [F,G,H] = StateSpaceMatrices(x_pred, u(k-1,:));
    A = eye(n) + F*T(k-1);
    Gamma = G*T(k-1);

    Q = Gamma*diag(std_w.^2)*Gamma';
    P_pred = A*P_corr*A' + Q;

    K = P_pred*H'/(H*P_pred*H' + R);

    x_corr = x_pred + K*(y(k,:)' - OutputEquation(x_pred));
    P_corr = (eye(n) - K*H)*P_pred*(eye(n) - K*H)' + K*R*K';

%     x_corr(1) = wrapTo180(x_corr(1));
%     x_corr(2) = wrapTo180(x_corr(2));

    x_est(k,:) = x_corr';
end

% rerun calibration experiment
% check dynamics again -> check G derivation
% add mag data

%% plot attitude

% figure
% subplot(3,1,1)
% plot(time, u(:,1))
% hold on
% plot(time, u(:,1) - x_est(:,3))
% subplot(3,1,2)
% plot(time, u(:,2))
% hold on
% plot(time, u(:,2) - x_est(:,4))
% subplot(3,1,3)
% plot(time, u(:,3))
% hold on
% plot(time, u(:,3) - x_est(:,5))
% 
% figure
% plot(time, x_est(:,3))
% hold on
% plot(time, x_est(:,4))
% plot(time, x_est(:,5))

figure
subplot(3,1,1)
plot(orientation_time, sensed_attitude(:,1))
hold on
plot(time, x_est(:,1))
subplot(3,1,2)
plot(orientation_time, sensed_attitude(:,2))
hold on
plot(time, x_est(:,2))
subplot(3,1,3)
plot(orientation_time, sensed_attitude(:,3))
