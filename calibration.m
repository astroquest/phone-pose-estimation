
close all

%% import

gyro_data = readmatrix('Calibration/GyroscopeUncalibrated.csv');
acceleration_data = readmatrix('Calibration/TotalAcceleration.csv');

%% assign

sensed_rates = [gyro_data(:,5), gyro_data(:,4), gyro_data(:,3)];
sensed_accelerations = -[acceleration_data(:,5), acceleration_data(:,4), acceleration_data(:,3)];

%% view

figure
subplot(2,1,1)
plot(0:length(sensed_rates)-1, sensed_rates)
subplot(2,1,2)
plot(0:length(sensed_accelerations)-1, sensed_accelerations)

%% estimate standard deviation

std_rates = std(sensed_rates(10:end,:));
std_accelerations = std(sensed_accelerations(10:end,:));

%% estimate bias

biases = [mean(sensed_rates(10:end,1)), mean(sensed_rates(10:end,2)), mean(sensed_rates(10:end,3))];

figure
subplot(2,1,1)
plot(0:length(sensed_rates)-1, sensed_rates - biases)

%% estimate gravitational acceleration

total_norm = 0;

for i=1:length(sensed_accelerations)
    total_norm = total_norm + norm(sensed_accelerations(i,:));
end

gravitational_acceleration = 1/length(sensed_accelerations)*total_norm;
