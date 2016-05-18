%{
testcase1 = ocd(11, [1, 5, 8])
testcase2 = ocd(13, [1, 5, 8])
testcase3 = ocd(47, [1, 5, 10, 25])

USD = [1, 5, 10, 25];
GBP = [1, 2, 5, 10, 20, 50, 100, 200];
JPY = [1, 5, 10, 50, 100, 500];

x = zeros(1, 99);
y = zeros(1, 99);
z = zeros(1, 99);

quantity = @(a, b) sum(ocd(a, b));

for k = 1:99
    x(k) = quantity(k, USD);
    y(k) = quantity(k, GBP);
    z(k) = quantity(k, JPY);
end

plot(1:99, x);
title('USD')
xlabel('Change')
ylabel('Amount of Coins')

k = [1, randi(99), randi(99), randi(99)]
change = randi(99)

ocd(change, k)
%}

% Finding optimum coin values
n = 10;

maximun = zeros(n, n, n);
average = zeros(n, n, n);
change = zeros(n, 1);

for a = 1:n
    for b = 1:n
        for c = 1:n
            for k = 1:n
                change(k) = number(k, [1, a, b, c]);
            end
            maximum(a, b, c) = max(change);
            average(a, b, c) = sum(change)/n;
        end
    end
end

%{
value = min(opt(:));
index = find(opt(:) == value);

c1 = ceil(index/n^2);
c2 = ceil((index - (c1-1)*n^2) / n);
c3 = index - (c1-1)*n^2 - (c2-1) * n;

% Check
if opt(c1(1), c2(2), c3(3)) == value
    disp('It works!');
end
combinations = size(index, 1) / 3;

value
oneSet = [1, c1(1), c2(1), c3(1)]
%}
