
close all

%% import

gyro_data = readmatrix('Data/GyroscopeUncalibrated.csv');
acceleration_data = readmatrix('Data/TotalAcceleration.csv');
orientation_data = readmatrix('Data/Orientation.csv');

%% assign

gyro_time = gyro_data(:,1);
sensed_rates = [gyro_data(:,5), gyro_data(:,4), gyro_data(:,3)];
time_elapsed = gyro_data(:,2);

acceleration_time = acceleration_data(:,1);
sensed_accelerations = -[acceleration_data(:,5), acceleration_data(:,4), acceleration_data(:,3)];

orientation_time = orientation_data(:,1);
sensed_attitude = [-orientation_data(:,8), orientation_data(:,7), orientation_data(:,9)];

%%

time_steps = time_elapsed(2:end) - time_elapsed(1:end-1);

%% view data

figure
subplot(3,1,1)
plot(gyro_time, sensed_rates(:,:), '.')
legend('p', 'q', 'r')
title('gyroscope')
subplot(3,1,2)
plot(acceleration_time, sensed_accelerations(:,:), '.')
legend('x', 'y', 'z')
title('accelerometer')
subplot(3,1,3)
plot(orientation_time, sensed_attitude(:,1:2), '.')
legend('x', 'y')
title('orientation')

% figure
% plot(gyro_time(1:end-1), time_steps)

%% interpolate

sensed_accelerations_ip = interp1(acceleration_time, sensed_accelerations, gyro_time, 'nearest');

%% process

skip = 10;

time = gyro_time(skip:end,:);
sensed_rates_processed = sensed_rates(skip:end,:) - biases;
% sensed_rates_processed = sensed_rates(skip:end,:);
sensed_accelerations_processed = sensed_accelerations_ip(skip:end,:);

% real-time ekf should not rely on interpolated values

%% view processed data

figure
% subplot(2,1,1)
plot(time, sensed_rates_processed, '.')
% subplot(2,1,2)
% plot(time, sensed_accelerations_processed(:,1), '.')
