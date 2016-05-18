function [number_coins] = optimal_coin_dispersion(change, coin_denominations)
% Justin Casali
% Optimal_Coin_Dispersion Function
% Returns the optimal number of each coin given an possitive integer amout of change a coin denomination array.

    % Sorts in ascending order (keep this?)
    coin_denominations = sort(coin_denominations);

    % INITIALIZATION
    m = size(coin_denominations, 2); % Number types of coins
    n = change; % Maximun possible number of stages
    C = zeros(m, n); % Cost matrix
    R = zeros(m, n); % Route matrix
    number_coins = zeros(1, m); % Number of each coin

    % STARTING STAGE
    C(:, 1) = change - coin_denominations;
    R(:, 1) = 1:m;
    C(find(C(:, 1) < 0), 1) = -Inf;
    R(find(C(:, 1) < 0), 1) = 0;

    % INTERMEDIATE STAGE
    k = 2;
    while k <= n && all(C(:, k-1) ~= 0)
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

    % FINAL STAGE & ROUTE CREATION
    final = k - 1;
    C = C(:, 1:final);
    R = R(:, 1:final);
    [y, x] = find(C == 0, 1, 'first');
    route = R(R(y, x), :);
    route(final) = y;

    % SUMMING OF COINS
    for coin = 1:m
        number_coins(coin) = size(find(route == coin), 2);
    end

    % ERROR CHECKING
    if change ~= sum(number_coins .* coin_denominations)
        number_coins = NaN;
        disp('ERROR!');
    end

    % Just return the columb size of C as number of coins for calculations.

end
