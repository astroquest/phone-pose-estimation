function x_pred = StateEquation(x, u, T)

    C = 1/cos(x(2))*[
        cos(x(2)), sin(x(1))*cos(x(2)), cos(x(1))*sin(x(2));
        0, cos(x(1))*cos(x(2)), -sin(x(1))*cos(x(2));
    ];

    xdot = C*[u(1); u(2); u(3)];

    x_pred = x + T*xdot;
%     x_pred = x + T*[xdot; zeros(3,1)];
end