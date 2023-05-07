
close all

%%

accel_ = zeros(length(sensed_attitude), 3);

for k=1:length(sensed_attitude)

    x = [sensed_attitude(k,1), sensed_attitude(k,2), 0, 0, 0]';

    accel_(k,:) = OutputEquation(x);
end

%%

figure
subplot(3,1,1)
plot(0:length(sensed_accelerations)-1, sensed_accelerations(:,1))
hold on
plot(0:length(accel_)-1, accel_(:,1))
subplot(3,1,2)
plot(0:length(sensed_accelerations)-1, sensed_accelerations(:,2))
hold on
plot(0:length(accel_)-1, accel_(:,2))
subplot(3,1,3)
plot(0:length(sensed_accelerations)-1, sensed_accelerations(:,3))
hold on
plot(0:length(accel_)-1, accel_(:,3))
