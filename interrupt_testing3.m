classdef interrupt_testing3 < handle
    %
    %   Class:
    %   interrupt_testing3
    %
    %   Using Java for pausing, not interrupted
    %
    %   
    
    %{
    2020b
    interrupt_testing3()
    UI Figure, timer then direct callback:
        Starting timer
        Stopping timer, elapsed: 5.0
        Button callback started
        Button callback stopped, elapsed: 5.0
    
    UI Figure, direct callback then timer:
        Button callback started
        Button callback stopped, elapsed: 5.0
        Starting timer
        Stopping timer, elapsed: 5.0
    
    
    
    
    
    interrupt_testing2(true)

    
    %Launch GUI, start non-GUI timer, press callback
    interrupt_testing2()
    interrupt_testing2.launchTimer()
    %press callback button

    
    interrupt_testing2()
    %press callback button
    interrupt_testing2.launchTimer()

    
    
    %}
    
    properties
        h_fig
        timer_button
        callback_button
        timer
    end
    
    methods (Static)
        function launchTimer()
            %   interrupt_testing.launchTimer()
            t = timer();
            t.TimerFcn = @(~,~)interrupt_testing.timerCallback2();
            start(t);
            
        end
        function timerCallback2()
            %
            %   interrupt_testing.timerCallback2()
            
            h_tic = tic;
            fprintf(2,'Starting timer2\n');
            a = 1;
            pause(1);
            b = 2;
            pause(1);
            c = 3;
            pause(1);
            d = 4;
            pause(1);
            e = 5;
            pause(1);
            disp(a+b+c+d+e)
            elapsed = toc(h_tic);
            fprintf(2,'Stopping timer2, elapsed: %0.1f\n',elapsed);
        end
    end
    
    methods
        function obj = interrupt_testing3(use_guide)
            if nargin == 0
                use_guide = false;
            end
            if use_guide
                %TODO: Support figure as well ...
                obj.h_fig = figure();
                obj.timer_button = uicontrol(obj.h_fig,'Style','pushbutton','Position',[100 100 100 50],'String','Timer');
                obj.callback_button = uicontrol(obj.h_fig,'Style','pushbutton','Position',[300 100 100 50],'String','Callback');
                obj.timer_button.Callback = @(~,~)obj.startTimer();
                obj.callback_button.Callback = @(~,~)obj.buttonCallback();
            else
            
                obj.h_fig = uifigure();
                obj.timer_button = uibutton(obj.h_fig,'Text','Timer','Position',[100 100 100 50]);
                obj.callback_button = uibutton(obj.h_fig,'Text','Callback','Position',[300 100 100 50]);
                obj.timer_button.ButtonPushedFcn = @(~,~)obj.startTimer();
                obj.callback_button.ButtonPushedFcn = @(~,~)obj.buttonCallback();
            end
        end
        function startTimer(obj)
            %TODO: Make this repeat every 3 seconds (period of 3)
            obj.timer = timer(); %#ok<CPROP>
            obj.timer.TimerFcn = @(~,~)obj.timerCallback();
            start(obj.timer);
        end
        function buttonCallback(obj)
            h_tic = tic;
         	fprintf(2,'Button callback started\n');
            java.lang.Thread.sleep(5000);
            elapsed = toc(h_tic);
            fprintf(2,'Button callback stopped, elapsed: %0.1f\n',elapsed);
        end
        function timerCallback(obj)
            %Java
            %
            h_tic = tic;
            fprintf(2,'Starting timer\n');
            java.lang.Thread.sleep(5000);
            elapsed = toc(h_tic);
            fprintf(2,'Stopping timer, elapsed: %0.1f\n',elapsed);
        end
        function closeFigure(obj)
            
        end
    end
end

