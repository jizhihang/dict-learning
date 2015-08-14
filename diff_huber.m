function ret = diff_huber( x )
beta = 0.001;

if (abs(x) < beta)
  ret = x / beta;
else
  ret = sign(x);
end
end