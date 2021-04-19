function Tout = P_combine(x,fs,hop,frameLen,alpha,beta)
    [sz1, sz2] = size(x);
    ori_len = sz1;
    add = zeros(round(sz1/5),sz2);
    x = [x;add];
    Tout = [];
    for i = 1:sz2
        in = x(:,i);
        f0 = pitch(in,fs);
        %hop = 400;
        %frameLen = 400;
        m = findpitchmarks(in,fs,f0,hop,frameLen);
        out=PSOLA(in,m,alpha,beta);
        Tout = [Tout;out];
    end% end for
    Tout = Tout(:,1:ori_len);
end