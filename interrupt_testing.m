classdef interrupt_testing < handle
    %
    %   Class:
    %   interrupt_testing
    
    %{
    Old matlab, timers can't be interrupted:
    https://www.mathworks.com/matlabcentral/answers/96855-is-it-possible-to-interrupt-timer-callbacks-in-matlab-7-14-r2012a
    
    System() used to not be blocking:
    https://www.mathworks.com/matlabcentral/answers/415834-why-system-function-block-the-timer-function-in-matlab-r2018a-but-not-in-r2014a
    
    
    
    %}
    
    
    %{
    2020b
    interrupt_testing()
    UI Figure, timer then direct callback:
        Starting timer
        Button callback started
        Button callback stopped, elapsed: 5.0
        Stopping timer, elapsed: 7.4
    UI Figure, direct callback then timer:
        Button callback started
        Starting timer
        Stopping timer, elapsed: 5.0
        Button callback stopped, elapsed: 7.3
    
    interrupt_testing(true)
        Starting timer
        Button callback started
        Button callback stopped, elapsed: 5.0
        Stopping timer, elapsed: 6.4
        Button callback started
        Starting timer
        Stopping timer, elapsed: 5.0
        Button callback stopped, elapsed: 6.0
    
    %Launch GUI, start non-GUI timer, press callback
    interrupt_testing()
    interrupt_testing.launchTimer()
    %press callback button
        Starting timer2
        Button callback started
        Button callback stopped, elapsed: 5.0
        Stopping timer2, elapsed: 7.6
    
    interrupt_testing()
    %press callback button
    interrupt_testing.launchTimer()
        Button callback started
        >> interrupt_testing.launchTimer()
        Button callback stopped, elapsed: 5.0
        Starting timer2
        Stopping timer2, elapsed: 5.0
    
    interrupt_testing(true)
    interrupt_testing.launchTimer()
    %press callback button
        Starting timer2
        Button callback started
        Button callback stopped, elapsed: 5.0
        Stopping timer2, elapsed: 8.7
    
    interrupt_testing(true)
    %press callback button
    interrupt_testing.launchTimer()   
        Button callback started
        interrupt_testing.launchTimer()
        Button callback stopped, elapsed: 5.0
        Starting timer2
        Stopping timer2, elapsed: 5.0
    
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
            pause(5);
            elapsed = toc(h_tic);
            fprintf(2,'Stopping timer2, elapsed: %0.1f\n',elapsed);
        end
    end
    
    methods
        function obj = interrupt_testing(use_guide)
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
            pause(5);
            elapsed = toc(h_tic);
            fprintf(2,'Button callback stopped, elapsed: %0.1f\n',elapsed);
        end
        function timerCallback(obj)
            %Java
            %
            h_tic = tic;
            fprintf(2,'Starting timer\n');
            pause(5);
            elapsed = toc(h_tic);
            fprintf(2,'Stopping timer, elapsed: %0.1f\n',elapsed);
        end
        function closeFigure(obj)
            
        end
    end
end

