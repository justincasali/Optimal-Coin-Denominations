function [amount] = number(change, coin_denominations)
% Justin Casali
% Returns number of coins (but not which type)

    % Sorts in ascending order (keep this?)
    coin_denominations = sort(coin_denominations);

    % INITIALIZATION
    m = size(coin_denominations, 2); % Number types of coins
    n = change; % Maximun possible number of stages
    C = zeros(m, n); % Cost matrix
    R = zeros(m, n); % Route matrix

    % STARTING STAGE
    C(:, 1) = change - coin_denominations;
    R(:, 1) = 1:m;
    C(find(C(:, 1) < 0), 1) = -Inf;
    R(find(C(:, 1) < 0), 1) = 0;

    % INTERMEDIATE STAGE
    k = 2;
    while k <= n & all(C(:, k-1) ~= 0)
        for coin = 1:m
            branches = C(:, k-1) - coin_denominations(coin);
            paths = branches(branches >= 0);
            [value, index] = min(paths);
            if isempty(value)
                value = -Inf;
                index = 0;
            end
            C(coin, k) = value;
            R(coin, k) = index;
        end
        k = k + 1;
    end

    % FINAL STAGE WIDTH
    final = k - 1;
    C = C(:, 1:final);

    amount = size(C, 2);

end
