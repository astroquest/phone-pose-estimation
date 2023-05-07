function y_pred = OutputEquation(x)

    g = 9.78;

    T_x = [
        1, 0, 0;
        0, cos(x(1)), sin(x(1));
        0, -sin(x(1)), cos(x(1))
    ];

    T_y = [
        cos(x(2)), 0, -sin(x(2));
        0, 1, 0;
        sin(x(2)), 0, cos(x(2))
    ];

    y_pred = T_x*T_y*[0; 0; -g];
end