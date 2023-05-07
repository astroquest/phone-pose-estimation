# phone-pose-estimation
Educational project where the goal is to estimate smartphone orientation using built-in sensors.

#### Description
- Estimate pose from accelerometer, gyroscope, and magnetometer measurements

#### Limitations
- Current version is barebones and only estimates roll and pitch from accelerometer and gyroscope measurements.
  - Better estimates are obtained by including magnetometer measurements and estimating the gyroscope biases.
- Biased and noisy measurements are fused together in an extended Kalman filter to create better estimates.
  - Gyroscope-measured angular rates are noisy and show drifting bias, which means integrating these rates to find angles will lead to an accumulation of orientation errors over time.
  - Linear acceleration measurements are noisy and are only valid in steady-state (no exogenous inputs except gravity)
