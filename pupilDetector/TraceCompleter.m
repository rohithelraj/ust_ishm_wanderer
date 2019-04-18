function tracedIris = TraceCompleter(iris)
%TRACECOMPLETER Summary of this function goes here
%   Detailed explanation goes here
  tracedIris = iris;
  for y = 1:200
    x_detect_flag_front = 0;
    x_detect_flag_topCircle = 0;
    x_detect_flag_bottomCircle = 0;
    for x = 1:400
        if(iris(y,x) == 1)
            for i = 1:(400-x)
                if((x_detect_flag_front == 0))
                    if((iris(y,x+i) == 1))
                        %x_detect_flag_front = 1;
                        if(i > 1)
                            for j = 1:(i-1)
                                tracedIris(y,x+j) = 1;
                               
                            end
                        end
                    %bottom circle.     
                    elseif((iris(y-1,x) == 1))
                        if(x_detect_flag_bottomCircle == 0)
                            min_x = 0;
                            max_x = 0;
                            for m = x:400
                                if((iris((y-1),m) == 1))
                                    if(x_detect_flag_bottomCircle == 0)
                                        for n = 1:(x-1)
                                            if((iris((y-1),x-n) == 1))
                                                min_x = m;
                                            end
                                        end    
                                        
                                        
                                    end
                                    x_detect_flag_bottomCircle = 1;
                                    max_x = m;
                                    
                                end
                            end
                            if((min_x > 0)&&(max_x > 0))
                                delta = x - min_x;
                                last_x = max_x - delta;
                                for l = x: last_x
                                    tracedIris(y,l) = 1;
                                    
                                end     
                            end
                        end
                    %top circle.    
                    else
                        if(x_detect_flag_topCircle == 0)
                            min_x = 0;
                            max_x = 0;
                            for m = x:400
                                if((iris((y-1),m) == 1))
                                    if(x_detect_flag_topCircle == 0)
                                        min_x = m;
                                    end
                                    x_detect_flag_topCircle = 1;
                                    max_x = m;
                                    
                                end
                            end
                            if((min_x > 0)&&(max_x > 0))
                                delta = x - min_x;
                                last_x = max_x + delta;
                                for l = x: last_x
                                    tracedIris(y,l) = 1;
                                    
                                end     
                            end
                               
                        end
                    end
                end
            end
        end
    end    
  end  
  for x = 1:400
    y_detect_flag_front = 0;
    
    for y = 1:200
        if(iris(y,x) == 1)
            for i = 1:(200-y)
                if((y_detect_flag_front == 0))
                    if((iris(y+i,x) == 1))
                        y_detect_flag_front = 1;
                        if(i > 1)
                            for j = 1:(i-1)
                                tracedIris(y+j,x) = 1;
                                %disp('Tracing Worked');
                            end
                        end

                    end
                end
            end
        end
    end    
  end
  
end

