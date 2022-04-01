classdef interrupt_testing4 < handle
    %
    %   Class:
    %   interrupt_testing4
    %
    %   Using Java for pausing, not interrupted
    %
    %   This is true even if we have multiple regular statements ...
    %
    
    %{
    2020b
    interrupt_testing4()
        Starting timer
        val=3
        val=5
        Stopping timer, elapsed: 5.0
        Button callback started
        val=3
        val=5
        Button callback stopped, elapsed: 5.0
    
        Button callback started
        val=3
        val=5
        Button callback stopped, elapsed: 5.0
        Starting timer
        val=3
        val=5
        Stopping timer, elapsed: 5.0
    
    %Launch GUI, start non-GUI timer, press callback
    interrupt_testing4()
    interrupt_testing4.launchTimer()
    %press callback button
            Starting timer2
            val=3
            val=5
            Stopping timer2, elapsed: 5.0
            Button callback started
            val=3
            val=5
            Button callback stopped, elapsed: 5.0
    
    

    
    interrupt_testing4()
    %press callback button
    interrupt_testing4.launchTimer()
            Button callback started
            val=3
            interrupt_testing4.launchTimer()
            val=5
            Button callback stopped, elapsed: 5.0
            Starting timer2
            val=3
            val=5
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
            t.TimerFcn = @(~,~)interrupt_testing4.timerCallback2();
            start(t);
            
        end
        function timerCallback2()
            %
            %   interrupt_testing.timerCallback2()
            
            h_tic = tic;
            fprintf(2,'Starting timer2\n');
            doThings
            elapsed = toc(h_tic);
            fprintf(2,'Stopping timer2, elapsed: %0.1f\n',elapsed);
        end
    end
    
    methods
        function obj = interrupt_testing4(use_guide)
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
            doThings
            elapsed = toc(h_tic);
            fprintf(2,'Button callback stopped, elapsed: %0.1f\n',elapsed);
        end
        function timerCallback(obj)
            %Java
            %
            h_tic = tic;
            fprintf(2,'Starting timer\n');
            doThings
            elapsed = toc(h_tic);
            fprintf(2,'Stopping timer, elapsed: %0.1f\n',elapsed);
        end
        function closeFigure(obj)
            
        end
    end
end

function doThings()
a = 1;
java.lang.Thread.sleep(1000);
b = 2;
java.lang.Thread.sleep(1000);
c = 3;
fprintf('val=%d\n',c);
java.lang.Thread.sleep(1000);
d = 4;
java.lang.Thread.sleep(1000);
e = 5;
java.lang.Thread.sleep(1000);
fprintf('val=%d\n',e);
end

