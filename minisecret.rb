require'json';o=e='';n=?\n;S=->x{x.split n};
M=->x,y{(d=[S[x],S[y]]).map{|x|x.size}.max.times{|i|d[0][i]=((x=d[0][i])?x:e)+d[1][i]};d[0]*n}
w,s,c,l,d=(JSON.parse File.read"data.json").values;_,f=c;b,q=s.values;w=w.upcase if b
v=->x{x.count f};w=w.scan(/[#{d.map{|k|k}*e}]/)*e;i=0;w.chars.map{|v|k=l.map{|x|x[-1]};t=l.flatten.map{|j|c[(d[v].index j)?0:1]+((k.index j)?n:e)}*e
o=M[o,t];o=M[o,(f+n)*l.size]if w.size>i+=1};i=0;(x=(o=S[o]).map{|l|v[l]}.max;o=o.each{|l|o[i]+=f*(x-v[l]);i+=1}*n)if q
puts o
