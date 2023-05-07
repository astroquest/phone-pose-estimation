
function [F,G,H] = StateSpaceMatrices(x, u)

    g = 9.78;  % calibrate this maybe?

    F11 = (u(2))*cos(x(1))*tan(x(2)) - (u(3))*sin(x(1))*tan(x(2));
    F12 = (u(2))*cos(x(1))/(cos(x(2)))^2 - (u(3))*sin(x(1))/(cos(x(2)))^2;
    F13 = -1;
    F14 = -sin(x(1))*tan(x(2));
    F15 = -cos(x(1))*tan(x(2));
    F21 = -(u(2))*sin(x(1)) - (u(3))*cos(x(1));
    F22 = 0;
    F23 = 0;
    F24 = -cos(x(1));
    F25 = sin(x(1));

    F = [
        F11, F12;
        F21, F22;
    ];

%     F = [
%         F11, F12, F13, F14, F15;
%         F21, F22, F23, F24, F25;
%         zeros(3,5)
%     ];

    G = [
        1, sin(x(1))*tan(x(2)), cos(x(1))*tan(x(2));
        0, cos(x(1)), -sin(x(1));
    ];  % not a good approx?

%     G = [
%         G1, zeros(2,3);
%         zeros(3,3), ones(3)
%     ];  % not a good approx?


    H1 = -g*[
        0, cos(x(2));
        cos(x(1))*cos(x(2)), -sin(x(1))*sin(x(2));
        -sin(x(1))*cos(x(2)), -cos(x(1))*sin(x(2))
    ];

    H = H1;

%     H = [H1, zeros(3,3)];
end