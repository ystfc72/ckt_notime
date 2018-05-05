count = 0;

D = 0;
TEMP_SCALE = 6;
IRR_SCALE = 10;
TEMP_MAX = 29;
TEMP_MIN = 20;
IRR_MAX = 1000;
IRR_MIN = 0;

D_MAX = 1;
D_MIN = 0;
dutyRatio = [];
actionNum = [];
temperature = [];
irradiance = [];

for iter_temp = 1:TEMP_SCALE
    for iter_irr = 1: IRR_SCALE
        count = 0;
        % d change
        % a = 4, +0.01
        while D<=D_MAX
            dutyRatio = [dutyRatio D];
            actionNum = [actionNum 4];
            D = D+0.01;
            if(D>0.995 && D<1.005)
                D = 1;
            end
            count = count+1;
        end
        
        % a = 2, -0.01
        D = 1;
        while D>=D_MIN
            dutyRatio = [dutyRatio D];
            actionNum = [actionNum 2];
            D = D-0.01;
            if(D>-0.005 && D<0.005)
                D = 0;
            end
            
            count = count+1;
        end
        % a = 5, +0.05
        % a = 1, -0.05
        for D_base = 0:0.01:0.04
            D = D_base;
            while D<=D_MAX
                dutyRatio = [dutyRatio D];
                actionNum = [actionNum 5];
                D = D+0.05;
                if(D>0.975 && D<1.025)
                    D = 1;
                end
                count = count+1;
            end
            D = 1-D_base;
            while D>=D_MIN
                dutyRatio = [dutyRatio D];
                actionNum = [actionNum 1];
                D = D-0.05;
                if(D>-0.025 && D<0.025)
                    D = 0;
                end
                count = count+1;
            end
        end
        
        % a = 6, +0.1
        % a = 0, -0.1
        for D_base = 0:0.01:0.09
            D = D_base;
            while D<=D_MAX
                dutyRatio = [dutyRatio D];
                actionNum = [actionNum 6];
                D = D+0.1;
                if(D>0.95 && D<1.05)
                    D = 1;
                end
                count = count+1;
            end
            D = 1-D_base;
            while D>=D_MIN
                dutyRatio = [dutyRatio D];
                actionNum = [actionNum 0];
                D = D-0.1;
                if(D>-0.05 && D<0.05)
                    D = 0;
                end
                count = count+1;
            end
        end
        % temperature, irradiance
        temp_result = (iter_temp/TEMP_SCALE)*(TEMP_MAX-TEMP_MIN)+TEMP_MIN;
        irr_result = (iter_irr/IRR_SCALE)*(IRR_MAX-IRR_MIN)+IRR_MIN;
        for ii = 1:count
             temperature = [temperature temp_result];
             irradiance = [irradiance irr_result];
        end
        
    end
end