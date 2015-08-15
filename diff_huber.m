function diff = diff_huber( x )
beta = 0.00001;

if (abs(x) < beta)
  diff = x / beta;
else
  diff = sign(x);
end
end