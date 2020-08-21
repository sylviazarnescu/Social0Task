function [thres, noise] = getMLEfit(choice, rexploit)
    X0 = [50 10];
    LB = [0 0];
    UB = [100 Inf];
    xfit= fmincon(@(x)-func(x(1), x(2), choice, rexploit), X0, [],[],[],[],LB, UB);
    thres = xfit(1);
    noise = xfit(2);
end
function lik = func(th, no, choice, rexploit)
    q = rexploit - th;
    p = 1./(1 + exp(-q/no));
    p(choice == 0) = 1 - p(choice == 0);
    logp = log(p);
    logp = logp(~isnan(logp))
    lik = sum(logp);
end